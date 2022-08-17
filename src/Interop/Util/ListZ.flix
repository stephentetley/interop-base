/*
 * Copyright 2022 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

namespace Interop/Util {

    use Interop/Util.Collection;
    use Interop/Util.Collection.{Collection};

    ///
    /// Represents a Java List.
    ///
    pub enum ListZ[_: Type, _: Region](##java.util.List)

    pub class ImpListZ[t: Type -> Region -> Type] {
        pub def toListZ[a: Type, r: Region](s: t[a, r]): ListZ[a, r]
        pub def fromListZ[a: Type, r: Region](s: ListZ[a, r]): t[a, r]
    }


    instance Interop/Util.ImpCollection[ListZ] {
        pub def toCollection(t: ListZ[a, r]): Collection[a, r] = 
            let ListZ(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): ListZ[a, r] = 
            let Collection(t1) = t;
            ListZ(t1 as ##java.util.List) 
    }

}

namespace Interop/Util/ListZ {

    use Interop/Util.ListZ;
    use Interop/Util.ListZ.{ListZ};
    use Interop/Util.ImpListZ;
    use Interop/Flix.Marshal;


    pub def getHH(m: ListZ[a, r]): ##java.util.List = 
        let ListZ(m1) = m;
        m1

    pub def mkListZ(_: Region[r], prim: ##java.util.List): ListZ[a, r] \ Write(r) =
        ListZ(prim) as \ Write(r)


    pub def toListHH[t: Type -> Region -> Type, a: Type, r: Region](list: t[a, r]): ##java.util.List with ImpListZ[t] = 
        Interop/Util/ImpListZ.toListZ(list) |> getHH


    pub def hhToList(prim: ##java.util.List): List[a] with Marshal[a]=  
        hhToListWith(Interop/Flix/Marshal.fromJavaObject, prim)

    /// via iterator...
    /// cast must be Pure
    pub def hhToListWith(ocast: ##java.lang.Object -> a, prim: ##java.util.List): List[a] = 
        region r { 
            if (Object.isNull(prim))
                Nil
            else 
                hhToIterator(r, ocast, prim) |> Iterator.toList
        }


    pub def hhToIterator(r: Region[r], ocast: ##java.lang.Object -> a, l: ##java.util.List): Iterator[a, r] \ { Write(r) } =
        import java.util.List.iterator(): ##java.util.Iterator \ Write(r) as iterator;
        Interop/Util/IteratorZ.hhToIterator(r, ocast, iterator(l))

    /// No `new` - List is an interface so it has no constructor

    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(r1: Region[r1], l: ListZ[a, r2]): Iterator[a, r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        iteratorWith(r1, Interop/Flix/Marshal.fromJavaObject, l)
    ///
    /// Returns an iterator over `l`.
    ///
    pub def iteratorWith(r1: Region[r1], ocast: ##java.lang.Object -> a, l: ListZ[a, r2]): Iterator[a, r1] \ { Read(r2), Write(r1) } =
        import java.util.List.iterator(): ##java.util.Iterator & (r2 and r1) as iterator1;
        let ListZ(l1) = l;
        Interop/Util/IteratorZ.mkIteratorZ(r1, iterator1(l1)) |> Interop/Util/IteratorZ.iteratorWith(ocast)


    pub def foldListZ(f: (b, a) -> b & ef, s: b, l: ListZ[a, r]): b \ { Read(r), ef } with Marshal[a] =
        region r1 {
            let iter = iterator(r1, l);
            Iterator.foldLeft(f, s, iter)
        }


    pub def unfoldViaArrayList(_: Region[r], f: s -> Option[(a, s)] & ef, st: s): ListZ[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.ArrayList(): ##java.util.ArrayList & r as new1;
        import java.util.ArrayList.add(##java.lang.Object): Bool & r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => ListZ(acc as ##java.util.List)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())


    pub def fromListViaArrayList(r: Region[r], l: List[a]): ListZ[a, r] \ { Write(r) } with Marshal[a] =
        let step = st -> match st {
            case a :: rs => Some((a, rs))
            case Nil     => None
        };
        unfoldViaArrayList(r, step, l)


    pub def toList(l: ListZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        let step = (k, a) -> ks -> k(a :: ks);
        foldListZ(step, ks -> ks, l) |> f -> f(Nil)

    pub def toSet(l: ListZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        let step = (acc, a) -> Set.insert(a, acc);
        foldListZ(step, Set.empty(), l)


    /// TEMP ...

    pub def fromArrayOfObject(arr: Array[##java.lang.Object, r1]): Result[ListZ[##java.lang.Object, r1], String] \ { Read(r1), Write(r1) } =
        try {
            import static java.util.Arrays.asList(Array[##java.lang.Object, r1]): ##java.util.List \ { Read(r1), Write(r1) };
            asList(arr) |> ListZ |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def toArrayOfString(r1: Region[r1], l: ListZ[String, r2]): Result[Array[String, r1], String] \ { Read(r2), Write(r1) } =
        try {
            import java.util.List.toArray(): Array[String, r1] \ { Read(r2), Write(r1) };
            let _ = [] @ r1;
            let ListZ(l1) = l;
            toArray(l1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
