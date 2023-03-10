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
    /// Interface / Mutable (some implementations may not be mutable)
    ///
    pub enum Collection[_: Type, r: Region] { 
        case Collection(Region[r], ##java.util.Collection)
    }


    pub class ImpCollection[t: Type -> Region -> Type] {
        pub def toCollection(s: t[a, r]): Collection[a, r]
        pub def fromCollection(s: Collection[a, r]): t[a, r]

        pub def toCollectionHH(s: t[a, r]): ##java.util.Collection = 
           ImpCollection.toCollection(s) |> Interop/Util/Collection.getHH

    }


}

namespace Interop/Util/Collection {

    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.ImpCollection
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}

    use Interop/Flix.Marshal


    pub def getHH(c: Collection[a, r]): ##java.util.Collection = 
        let Collection(_, c1) = c;
        c1


    pub def wrapHH(rc: Region[r], col: ##java.util.Collection): Collection[a, r] = 
        Collection(rc, col)



    pub def size(c: Collection[a, r]): Int32 \ Read(r) =
        import java.util.Collection.size(): Int32 \ r;
        let Collection(_, c1) = c;
        size(c1)

    pub def isEmpty(c: Collection[a, r]): Bool \ Read(r) =
        import java.util.Collection.isEmpty(): Bool \ r;
        let Collection(_, c1) = c;
        isEmpty(c1)

    pub def hashCode(c: Collection[a, r]): Int32 \ Read(r) =
        import java.util.Collection.hashCode(): Int32 \ r;
        let Collection(_, c1) = c;
        hashCode(c1)

    pub def clear!(c: Collection[a, r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Collection.clear(): Unit \ r;
            let Collection(_, c1) = c;
            clear(c1)
        })

    pub def add!(x: a, c: Collection[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        Interop/Flix/Util.try(_ -> {
            import java.util.Collection.add(##java.lang.Object): Bool \ r; 
            let Collection(_, c1) = c;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            add(c1, x1)
        })

    pub def remove!(x: a, c: Collection[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        Interop/Flix/Util.try(_ -> {
            import java.util.Collection.remove(##java.lang.Object): Bool \ r; 
            let Collection(_, c1) = c;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(c1, x1)
        })


    pub def removeIf!(f: a -> Bool \ ef, c: Collection[a, r]): Result[String, Bool] \  {ef, Write(r)} with Marshal[a] =
        Interop/Flix/Util.try(_ -> {
            import java.util.Collection.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let Collection(_, c1) = c;            
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            unsafe_cast removeIf(c1, f1) as _ \ {ef, Write(r)}
        })

    pub def forEach(f: a -> Unit \ ef, c: Collection[a, r]): Result[String, Unit] \  {ef, Read(r)} with Marshal[a] =
        Interop/Flix/Util.try(_ -> {
            import java.util.Collection.forEach(##java.util.function.Consumer): Unit \ r; 
            let Collection(_, c1) = c;
            let f1 = Interop/Util/Function/Consumer.makeConsumer(f);
            forEach(c1, f1)
        })


    // Uses `Object.equals` for comparing.
    pub def contains(x: a, c: Collection[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        Interop/Flix/Util.try(_ -> {
            import java.util.Collection.contains(##java.lang.Object): Bool \ r; 
            let Collection(_, c1) = c;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            contains(c1, x1)
        })

    pub def stream(rc: Region[r1], c: Collection[a, r]): Stream[a, r1] \ { Read(r) }  with Marshal[a] =
        import java.util.Collection.stream(): ##java.util.stream.Stream \ r; 
        let Collection(_, c1) = c;
        Stream(rc, stream(c1))

    pub def iterator(rc: Region[r1], c: Collection[a, r]): Iterator[a, r1, r1] \ { Read(r) } with Marshal[a] =
        toFlixIterator(rc, Interop/Flix/Marshal.fromJavaObject, c)
        

    pub def toFlixIterator(rc: Region[r1], 
                            ocast: ##java.lang.Object -> a,
                            c: Collection[a, r]): Iterator[a, r1, r1] \ { Read(r) } with Marshal[a] =
        import java.util.Collection.iterator(): ##java.util.Iterator \ { Read(r) } as iterator;
        let Collection(_, c1) = c;
        if (Object.isNull(c1))
            Iterator.empty(rc)
        else 
            iterator(c1) 
                |> Interop/Util/IteratorZ.wrapHH(rc)
                |> Interop/Util/IteratorZ.toFlixIterator(rc, ocast)

    /// pub def enumerator(r: Region[r1], c: Collection[a, r2]): Iterator[(a, Int32), r] \ { Read(r2), Write(r1) }  with Marshal[a] =
    ///     iterator(r, c) |> Iterator.enumerator

    pub def unfoldCollection(rc: Region[r], f: s -> Option[(a, s)] & ef, st: s): Collection[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.LinkedList(): ##java.util.LinkedList & r as new1;
        import java.util.LinkedList.add(##java.lang.Object): Bool & r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => Collection(rc, unsafe_cast acc as ##java.util.Collection)
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
