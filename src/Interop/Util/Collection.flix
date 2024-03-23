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

mod Interop.Util {

    use Interop.Util.Collection.{Collection}
    
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
           ImpCollection.toCollection(s) |> Interop.Util.Collection.getHH

    }

    instance Interop.Flix.GoesToJava[Collection[a, r]] with Interop.Flix.GoesToJava[a] {
        pub def toJavaObject(x: Collection[a, r]): ##java.lang.Object = 
            let Collection(_, t1) = x;
            unchecked_cast(t1 as ##java.lang.Object)
    }

}

mod Interop.Util.Collection {

    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.ImpCollection
    use Interop.Util.Stream.Stream
    use Interop.Util.Stream.Stream.{Stream}
    use Interop.Util.Function.ConsumerZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.GoesToJava


    pub def getHH(c: Collection[a, r]): ##java.util.Collection = 
        let Collection(_, c1) = c;
        c1


    pub def wrapHH(rc: Region[r], col: ##java.util.Collection): Collection[a, r] = 
        Collection(rc, col)

    pub def fromJavaObject(rc: Region[r], o: ##java.lang.Object): Collection[a, r] = 
        Collection(rc, unchecked_cast(o as ##java.util.Collection))


    pub def size(c: Collection[a, r]): Int32 \ r =
        import java.util.Collection.size(): Int32 \ r;
        let Collection(_, c1) = c;
        size(c1)

    pub def isEmpty(c: Collection[a, r]): Bool \ r =
        import java.util.Collection.isEmpty(): Bool \ r;
        let Collection(_, c1) = c;
        isEmpty(c1)

    pub def hashCode(c: Collection[a, r]): Int32 \ r =
        import java.util.Collection.hashCode(): Int32 \ r;
        let Collection(_, c1) = c;
        hashCode(c1)

    pub def clear!(c: Collection[a, r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.util.Collection.clear(): Unit \ r;
            let Collection(_, c1) = c;
            clear(c1)
        })

    pub def add!(x: a, c: Collection[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Collection.add(##java.lang.Object): Bool \ r; 
            let Collection(_, c1) = c;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            add(c1, x1)
        })

    pub def remove!(x: a, c: Collection[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Collection.remove(##java.lang.Object): Bool \ r; 
            let Collection(_, c1) = c;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            remove(c1, x1)
        })


    pub def removeIf!(f: PredicateZ[a, ef], c: Collection[a, r]): Result[String, Bool] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.Collection.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let Collection(_, c1) = c;
            let PredicateZ(f1) = f;
            removeIf(c1, f1)
        })

    pub def forEach(f: ConsumerZ[a, ef], c: Collection[a, r]): Result[String, Unit] \ {ef, r}  =
        Result.tryCatch(_ -> {
            import java.util.Collection.forEach(##java.util.function.Consumer): Unit \ {ef, r}; 
            let Collection(_, c1) = c;
            let ConsumerZ(f1) = f;
            forEach(c1, f1)
        })


    // Uses `Object.equals` for comparing.
    pub def contains(x: a, c: Collection[a, r]): Result[String, Bool] \  r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Collection.contains(##java.lang.Object): Bool \ r; 
            let Collection(_, c1) = c;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            contains(c1, x1)
        })

    pub def stream(rc: Region[r1], c: Collection[a, r]): Stream[a, ef + r, r1] =
        import java.util.Collection.stream(): ##java.util.stream.Stream \ {}; 
        let Collection(_, c1) = c;
        Stream(rc, stream(c1))


    pub def fromFoldableViaArrayList(rc: Region[r], t: t[a]): Collection[a, r] \ { r } with Foldable[t], GoesToJava[a] =
        Interop.Util.ArrayList.fromFoldable(rc, t) |> Interop.Util.ImpCollection.toCollection

    pub def fromFoldableViaArrayListHH(t: t[a]): ##java.util.Collection with Foldable[t], GoesToJava[a] = region rc {
        Interop.Util.ArrayList.fromFoldable(rc, t) |> Interop.Util.ImpCollection.toCollectionHH
    }

    pub def fromFoldableViaLinkedList(rc: Region[r], t: t[a]): Collection[a, r] \ { r } with Foldable[t], GoesToJava[a] =
        Interop.Util.LinkedList.fromFoldable(rc, t) |> Interop.Util.ImpCollection.toCollection

    pub def fromFoldableViaLinkedListHH(t: t[a]): ##java.util.Collection with Foldable[t], GoesToJava[a] = region rc {
        Interop.Util.LinkedList.fromFoldable(rc, t) |> Interop.Util.ImpCollection.toCollectionHH
    }

        

    pub def toFlixIterator(rc: Region[r1], 
                            fromJava: ##java.lang.Object -> a,
                            c: Collection[a, r]): Iterator[a, r1, r1] \ r =
        import java.util.Collection.iterator(): ##java.util.Iterator \ r as iterator;
        let Collection(_, c1) = c;
        if (Object.isNull(c1))
            Iterator.empty(rc)
        else 
            iterator(c1) 
                |> Interop.Util.IteratorZ.wrapHH(rc)
                |> Interop.Util.IteratorZ.toFlixIterator(rc, fromJava)


    pub def toFlixList(fromJava: ##java.lang.Object -> a, l: Collection[a, r]): List[a] \ r = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toList
    }

    pub def toFlixSet(fromJava: ##java.lang.Object -> a, l: Collection[a, r]): Set[a] \ r with Order[a] = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toSet
    }

    /// remove...
    pub def unfoldCollection(rc: Region[r], f: s -> Option[(a, s)] \ ef, st: s): Collection[a, r] \ {ef,  r} with GoesToJava[a] =
        import java_new java.util.LinkedList(): ##java.util.LinkedList \ r as newCollection;
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => Collection(rc, unchecked_cast(acc as ##java.util.Collection))
            case Some(o, st2) => {discard add1(acc, Interop.Flix.GoesToJava.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, newCollection())



}
