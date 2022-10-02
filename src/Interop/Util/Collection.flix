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

    ///
    /// Represents a Java Collection.
    /// Iterface / Mutable (some implementations may not be mutable)
    ///
    pub enum Collection[_: Type, _: Region](##java.util.Collection)

    instance Scoped[Collection[a]] {
        pub def regionOf(_: Collection[a, r]): Region[r] = () as Region[r]
    }

    pub class ImpCollection[t: Type -> Region -> Type] {
        pub def toCollection[a: Type, r: Region](s: t[a, r]): Collection[a, r]
        pub def fromCollection[a: Type, r: Region](s: Collection[a, r]): t[a, r]
    }


}

namespace Interop/Util/Collection {

    use Interop/Util.Collection;
    use Interop/Util.Collection.{Collection};
    use Interop/Util.ImpCollection;
    use Interop/Flix.Marshal;


    pub def getHH(iter: Collection[a, r]): ##java.util.Collection = 
        let Collection(iter1) = iter;
        iter1


    pub def wrapHH(_: Region[r], col: ##java.util.Collection): Collection[a, r] = 
        Collection(col)


    pub def toCollectionHH[t: Type -> Region -> Type, a: Type, r: Region](col: t[a, r]): ##java.util.Collection with ImpCollection[t] = 
        Interop/Util/ImpCollection.toCollection(col) |> getHH



    pub def size[t: Type -> Region -> Type, a: Type, r: Region](col: t[a, r]): Int32 \ { Read(r) } with ImpCollection[t] =
        import java.util.Collection.size(): Int32 \ r;
        toCollectionHH(col) |> size

    pub def isEmpty[t: Type -> Region -> Type, a: Type, r: Region](col: t[a, r]): Bool \ { Read(r) } with ImpCollection[t] =
        import java.util.Collection.isEmpty(): Bool \ r;
        toCollectionHH(col) |> isEmpty

    pub def hashCode[t: Type -> Region -> Type, a: Type, r: Region](col: t[a, r]): Int32 \ { Read(r) } with ImpCollection[t] =
        import java.util.Collection.hashCode(): Int32 \ r;
        toCollectionHH(col) |> hashCode

    pub def clear![t: Type -> Region -> Type, a: Type, r: Region](col: t[a, r]): Result[Unit, String] \ Write(r) with ImpCollection[t] =
        try {
            import java.util.Collection.clear(): Unit \ r;
            toCollectionHH(col) |> clear |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def iterator[t: Type -> Region -> Type, a: Type, r: Region]
                    (col: t[a, r]): Iterator[a, r] \ { Write(r) } with ImpCollection[t], Scoped[t[a]], Marshal[a] =
        toFlixIterator(Scoped.regionOf(col), Interop/Flix/Marshal.fromJavaObject, col)
        

    pub def toFlixIterator[t: Type -> Region -> Type, a: Type, r: Region, r2: Region]
                            (r2: Region[r2], 
                                ocast: ##java.lang.Object -> a,
                                col: t[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } with ImpCollection[t], Marshal[a] =
        import java.util.Collection.iterator(): ##java.util.Iterator \ {r, r2} as iterator;
        let c1 = toCollectionHH(col);
        if (Object.isNull(c1))
            Iterator.new(r2)
        else 
            iterator(c1) 
                |> Interop/Util/IteratorZ.wrapHH(r2)
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)

    /// pub def enumerator(r: Region[r1], c: Collection[a, r2]): Iterator[(a, Int32), r] \ { Read(r2), Write(r1) }  with Marshal[a] =
    ///     iterator(r, c) |> Iterator.enumerator

    pub def unfoldCollection(_: Region[r], f: s -> Option[(a, s)] & ef, st: s): Collection[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.LinkedList(): ##java.util.LinkedList & r as new1;
        import java.util.LinkedList.add(##java.lang.Object): Bool & r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => Collection(acc as ##java.util.Collection)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())


    pub def fromList(r: Region[r], l: List[a]): Collection[a, r] \ { Write(r) } with Marshal[a] =
        let step = xs -> match xs {
            case Nil     => None
            case x :: rs => Some((x, rs))
        };
        unfoldCollection(r, step, l)

}
