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

    use Interop.Util.LinkedList
    use Interop.Util.LinkedList.{LinkedList}
    
    use Interop.Lang.IterableZ
    use Interop.Lang.IterableZ.{IterableZ}
    use Interop.Util.Collection;
    use Interop.Util.Collection.{Collection};
    use Interop.Util.ListZ;
    use Interop.Util.ListZ.{ListZ};
    use Interop.Util.Function.ConsumerZ.{ConsumerZ};

    ///
    /// Represents a LinkedList.
    /// Class / Mutable
    ///
    pub enum LinkedList[_: Type, r: Region] { 
        case LinkedList(Region[r], ##java.util.LinkedList)
    }

    instance Interop.Util.ImpCollection[LinkedList] {
        pub def toCollection(t: LinkedList[a, r]): Collection[a, r] = 
            let LinkedList(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): LinkedList[a, r] = 
            let Collection(rc, t1) = t;
            LinkedList(rc, unchecked_cast(t1 as ##java.util.LinkedList))
    }


    instance Interop.Util.ImpListZ[LinkedList] {
        pub def toListZ(t: LinkedList[a, r]): ListZ[a, r] = 
            let LinkedList(rc, t1) = t;
            ListZ(rc, unchecked_cast(t1 as ##java.util.List))

        pub def fromListZ(t: ListZ[a, r]): LinkedList[a, r] = 
            let ListZ(rc, t1) = t;
            LinkedList(rc, unchecked_cast(t1 as ##java.util.LinkedList))
    }

    instance Interop.Lang.ImpIterable[LinkedList] {
        pub def toIterable(t: LinkedList[a, r]): IterableZ[a, r] = 
            let LinkedList(rc, t1) = t;
            IterableZ(rc, unchecked_cast(t1 as ##java.lang.Iterable))

        pub def fromIterable(t: IterableZ[a, r]): LinkedList[a, r] = 
            let IterableZ(rc, t1) = t;
            LinkedList(rc, unchecked_cast(t1 as ##java.util.LinkedList))
    }

}

mod Interop.Util.LinkedList {

    use Interop.Util.LinkedList
    use Interop.Util.LinkedList.{LinkedList}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.Comparator
    use Interop.Util.Comparator.{Comparator}
    use Interop.Util.ImpCollection
    use Interop.Util.Function.ConsumerZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.GoesToJava

    
    pub def getHH(l: LinkedList[a, r]): ##java.util.LinkedList = 
        let LinkedList(_, l1) = l;
        l1

    pub def wrapHH(rc: Region[r], prim: ##java.util.LinkedList): LinkedList[a, r] =
        LinkedList(rc, prim)

    ///
    /// Returns a new mutable LinkedList.
    ///
    pub def empty(rc: Region[r]): LinkedList[a, r] \ r =
        import java_new java.util.LinkedList(): ##java.util.LinkedList \ r as newLinkedList;
        LinkedList(rc, newLinkedList())


    pub def toString(l: LinkedList[a, r]): String \ r = 
        import java.util.LinkedList.toString(): String \ r;
        let LinkedList(_, l1) = l;
        toString(l1)

    pub def hashCode(l: LinkedList[a, r]): Int32 \ r = 
        import java.util.LinkedList.hashCode(): Int32 \ r;
        let LinkedList(_, l1) = l;
        hashCode(l1)

    pub def equals(l1: LinkedList[a, r], l2: LinkedList[a, r]): Bool \ r =
        import java.util.LinkedList.equals(##java.lang.Object): Bool \ r; 
        let LinkedList(_, ll1) = l1;
        let LinkedList(_, ll2) = l2;
        equals(ll1, checked_cast(ll2))

    pub def isEmpty(l: LinkedList[a, r]): Bool \ r =
        import java.util.LinkedList.isEmpty(): Bool \ r;
        let LinkedList(_, l1) = l;
        isEmpty(l1)

    pub def size(l: LinkedList[a, r]): Int32 \ r = 
        import java.util.LinkedList.size(): Int32 \ r;
        let LinkedList(_, l1) = l;
        size(l1)


    pub def get(getter: ##java.lang.Object -> b \ ef, ix: Int32, l: LinkedList[a, r]): Result[String, b] \ {ef, r} = 
        Result.tryCatch(_ -> {
            import java.util.LinkedList.get(Int32): ##java.lang.Object \ {ef, r};
            let LinkedList(_, l1) = l;
            get(l1, ix) |> getter
        })

    pub def add!(x: a, l: LinkedList[a, r]): Bool \ r with GoesToJava[a] = 
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r;
        let LinkedList(_, l1) = l;
        add(l1, Interop.Flix.GoesToJava.toJavaObject(x))

    pub def addAt!(ix: Int32, x: a, l: LinkedList[a, r]): Result[String, Unit] \ r with GoesToJava[a] = 
        Result.tryCatch(_ -> {
            import java.util.LinkedList.add(Int32, ##java.lang.Object): Unit \ r;
            let LinkedList(_, l1) = l;
            add(l1, ix, Interop.Flix.GoesToJava.toJavaObject(x))
        })

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, l: LinkedList[a, r]): Bool \ r = 
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r;
        let LinkedList(_, l1) = l;
        add(l1, ocast(x))

    pub def addAll!(c: Collection[a, r1], l: LinkedList[a, r]): Result[String, Bool] \ {r, r1} = 
        Result.tryCatch(_ -> {
            import java.util.LinkedList.addAll(##java.util.Collection): Bool \ {r, r1};
            let LinkedList(_, l1) = l;
            let Collection(_, c1) = c;
            addAll(l1, c1)
        })
        


    pub def remove!(x: a, l: LinkedList[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.remove(##java.lang.Object): Bool \ r; 
            let LinkedList(_, l1) = l;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            remove(l1, x1)
        })

    pub def removeAll!(c: Collection[a, r1], l: LinkedList[a, r]): Result[String, Bool] \ {r, r1} with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.removeAll(##java.util.Collection): Bool \ {r, r1}; 
            let LinkedList(_, l1) = l;
            let Collection(_, c1) = c;
            removeAll(l1, c1)
        })

    pub def removeIf!(f: PredicateZ[a, ef], l: LinkedList[a, r]): Result[String, Bool] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let LinkedList(_, l1) = l;
            let PredicateZ(f1) = f;
            removeIf(l1, f1)
        })



    pub def retainAll!(c: Collection[a, r1], l: LinkedList[a, r]): Result[String, Bool] \ {r, r1} =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.retainAll(##java.util.Collection): Bool \ {r, r1}; 
            let LinkedList(_, l1) = l;
            let Collection(_, c1) = c;
            retainAll(l1, c1)
        })


    pub def forEach(f: ConsumerZ[a, ef], l: LinkedList[a, r]): Result[String, Unit] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.forEach(##java.util.function.Consumer): Unit \ {ef, r}; 
            let LinkedList(_, l1) = l;
            let ConsumerZ(f1) = f;
            forEach(l1, f1)
        })


    pub def sort!(c: Comparator[a, ef], l: LinkedList[a, r]): Result[String, Unit] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.sort(##java.util.Comparator): Unit \ {ef, r}; 
            let LinkedList(_, l1) = l;
            let Comparator(c1) = c;
            sort(l1, c1)
        })

    // pub def fromIterable[a: Type, t: Type -> Region -> Type, r: Region, r2: Region]
    //                     (r: Region[r2], t: t[a, r]): LinkedList[a, r2] \ { r, Write(r2) } with Iterable[t], Marshal[a] =
    //     let als = empty(r);
    //     let iter1 = Iterable.iterator(t);
    //     Iterator.forEach(x -> discard add!(x, als), iter1);
    //     als

    pub def fromFoldable(r: Region[r], t: t[a]): LinkedList[a, r] \ r with Foldable[t], GoesToJava[a] =
        let als = empty(r);
        Foldable.forEach(x -> discard add!(x, als), t);
        als

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): LinkedList[a, r] \ r with Foldable[t] =
        let als = empty(r);
        Foldable.forEach(x -> discard addWith!(x, ocast, als), t);
        als


    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            fromJava: ##java.lang.Object -> a, 
                            l: LinkedList[a, r]): Iterator[a, r1, r1] \ r =
        import java.util.LinkedList.iterator(): ##java.util.Iterator \ r as iterator;
        let LinkedList(_, l1) = l;
        if (Object.isNull(l1))
            Iterator.empty(rc)
        else 
            iterator(l1) 
                |> Interop.Util.IteratorZ.wrapHH(rc) 
                |> Interop.Util.IteratorZ.toFlixIterator(rc, fromJava)



    pub def unfoldLinkedList(rc: Region[r], f: s -> Option[(a, s)] \ ef, st: s): LinkedList[a, r] \ {ef, r} with GoesToJava[a] =
        import java_new java.util.LinkedList(): ##java.util.LinkedList \ r as newLinkedList;
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => LinkedList(rc, acc)
            case Some(o, st2) => {discard add1(acc, Interop.Flix.GoesToJava.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, newLinkedList())


    pub def toFlixList(fromJava: ##java.lang.Object -> a, l: LinkedList[a, r]): List[a] \ r = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toList
    }

    pub def toFlixSet(fromJava: ##java.lang.Object -> a, l: LinkedList[a, r]): Set[a] \ r with Order[a] = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toSet
    }

    pub def toFlixArray(r1: Region[r1], fromJava: ##java.lang.Object -> a, l: LinkedList[a, r2]): Array[a, r1] \ {r1, r2} = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toArray(r1)
    }


}
