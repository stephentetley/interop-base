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

    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}

    ///
    /// Represents a Java List.
    /// Interface / Mutable
    ///
    pub enum ListZ[_: Type, _: Region](##java.util.List)

    instance Scoped[ListZ[a]] {
        pub def regionOf(_: ListZ[a, r]): Region[r] = () as Region[r]
    }

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

    pub def wrapHH(_: Region[r], prim: ##java.util.List): ListZ[a, r] =
        ListZ(prim)


    pub def toListHH[t: Type -> Region -> Type, a: Type, r: Region](list: t[a, r]): ##java.util.List with ImpListZ[t] = 
        Interop/Util/ImpListZ.toListZ(list) |> getHH



    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(l: ListZ[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        toFlixIterator(Scoped.regionOf(l), Interop/Flix/Marshal.fromJavaObject, l)
    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(r2: Region[r2], ocast: ##java.lang.Object -> a, l: ListZ[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } =
        import java.util.List.iterator(): ##java.util.Iterator \ {r, r2};
        let ListZ(l1) = l;
        if (Object.isNull(l1))
            Iterator.new(r2)
        else 
            iterator(l1) 
                |> Interop/Util/IteratorZ.wrapHH(r2)
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)



    pub def toFlixList(l: ListZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, l) |> Iterator.toList
        }

    pub def toSet(l: ListZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, l) |> Iterator.toSet
        }


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
