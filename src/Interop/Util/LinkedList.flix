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

}

mod Interop.Util.LinkedList {

    use Interop.Util.LinkedList
    use Interop.Util.LinkedList.{LinkedList}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.Comparator
    use Interop.Util.ImpCollection
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.Marshal;

    
    pub def getHH(l: LinkedList[a, r]): ##java.util.LinkedList = 
        let LinkedList(_, l1) = l;
        l1

    pub def wrapHH(rc: Region[r], prim: ##java.util.LinkedList): LinkedList[a, r] =
        LinkedList(rc, prim)

    ///
    /// Returns a new mutable LinkedList.
    ///
    pub def new(rc: Region[r]): LinkedList[a, r] \ r =
        import new java.util.LinkedList(): ##java.util.LinkedList \ r as newLinkedList;
        LinkedList(rc, newLinkedList())


    pub def toString(l: LinkedList[a, r]): String \ r = 
        import java.util.LinkedList.toString(): String \ r;
        let LinkedList(_, l1) = l;
        toString(l1)

    pub def hashCode(l: LinkedList[a, r]): Int32 \ r = 
        import java.util.LinkedList.hashCode(): Int32 \ r;
        let LinkedList(_, l1) = l;
        hashCode(l1)

    pub def equals(l1: LinkedList[a, r], l2: LinkedList[a, r]): Bool \  r with Marshal[a] =
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


    pub def get(ix: Int32, l: LinkedList[a, r]): a \ r with Marshal[a] = 
        import java.util.LinkedList.get(Int32): ##java.lang.Object \ r;
        let LinkedList(_, l1) = l;
        get(l1, ix) |> Interop.Flix.Marshal.fromJavaObject

    pub def add!(x: a, l: LinkedList[a, r]): Bool \ { r } with Marshal[a] = 
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r;
        let LinkedList(_, l1) = l;
        add(l1, Interop.Flix.Marshal.toJavaObject(x))

    pub def addAt!(ix: Int32, x: a, l: LinkedList[a, r]): Result[String, Unit] \ { r } with Marshal[a] = 
        Result.tryCatch(_ -> {
            import java.util.LinkedList.add(Int32, ##java.lang.Object): Unit \ r;
            let LinkedList(_, l1) = l;
            add(l1, ix, Interop.Flix.Marshal.toJavaObject(x))
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
        


    pub def remove!(x: a, l: LinkedList[a, r]): Result[String, Bool] \  r with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.remove(##java.lang.Object): Bool \ r; 
            let LinkedList(_, l1) = l;
            let x1 = Interop.Flix.Marshal.toJavaObject(x);        
            remove(l1, x1)
        })

    pub def removeAll!(c: Collection[a, r1], l: LinkedList[a, r]): Result[String, Bool] \ {r, r1} with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.removeAll(##java.util.Collection): Bool \ {r, r1}; 
            let LinkedList(_, l1) = l;
            let Collection(_, c1) = c;
            removeAll(l1, c1)
        })

    pub def removeIf![a: Type, ef: Eff, r: Region]
                        (f: a -> Bool \ ef, l: LinkedList[a, r]): Result[String, Bool] \  {ef, r} with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let LinkedList(_, l1) = l;
            let PredicateZ(f1) = Interop.Util.Function.PredicateZ.makePredicateZ(f);
            checked_ecast(removeIf(l1, f1))
        })



    pub def retainAll!(c: Collection[a, r1], l: LinkedList[a, r]): Result[String, Bool] \ {r, r1} with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.retainAll(##java.util.Collection): Bool \ {r, r1}; 
            let LinkedList(_, l1) = l;
            let Collection(_, c1) = c;
            retainAll(l1, c1)
        })


    pub def forEach[a: Type, ef: Eff, r: Region]
                    (f: a -> Unit \ ef, l: LinkedList[a, r]): Result[String, Unit] \  {ef, r} with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.forEach(##java.util.function.Consumer): Unit \ {ef, r}; 
            let LinkedList(_, l1) = l;
            let ConsumerZ(f1) = Interop.Util.Function.ConsumerZ.makeConsumerZ(f);
            forEach(l1, f1)
        })


    pub def sort!(f: (a, a) -> Int32, l: LinkedList[a, r]): Result[String, Unit] \ r with Marshal[a] =
        let f1 = Interop.Util.Comparator.makeComparator(f);
        sortWithComparator!(f1, l)


    pub def sortWithComparator!(c: Comparator[a], l: LinkedList[a, r]): Result[String, Unit] \ r with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.LinkedList.sort(##java.util.Comparator): Unit \ r; 
            let LinkedList(_, l1) = l;
            sort(l1, c)
        })

    // pub def fromIterable[a: Type, t: Type -> Region -> Type, r: Region, r2: Region]
    //                     (r: Region[r2], t: t[a, r]): LinkedList[a, r2] \ { r, Write(r2) } with Iterable[t], Marshal[a] =
    //     let als = new(r);
    //     let iter1 = Iterable.iterator(t);
    //     Iterator.forEach(x -> discard add!(x, als), iter1);
    //     als

    pub def fromFoldable(r: Region[r], t: t[a]): LinkedList[a, r] \ { r } with Foldable[t], Marshal[a] =
        let als = new(r);
        Foldable.forEach(x -> discard add!(x, als), t);
        als

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): LinkedList[a, r] \ { r } with Foldable[t] =
        let als = new(r);
        Foldable.forEach(x -> discard addWith!(x, ocast, als), t);
        als


    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(rc: Region[r1], l: LinkedList[a, r]): Iterator[a, r1, r1] \ { r } with Marshal[a] =
        toFlixIterator(rc, Interop.Flix.Marshal.fromJavaObject, l)

    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            ocast: ##java.lang.Object -> a, 
                            l: LinkedList[a, r]): Iterator[a, r1, r1] \ { r } =
        import java.util.LinkedList.iterator(): ##java.util.Iterator \ { r } as iterator;
        let LinkedList(_, l1) = l;
        if (Object.isNull(l1))
            Iterator.empty(rc)
        else 
            iterator(l1) 
                |> Interop.Util.IteratorZ.wrapHH(rc) 
                |> Interop.Util.IteratorZ.toFlixIterator(rc, ocast)



    ///
    /// Returns an iterator over `l`.
    ///
    pub def enumerator(rc: Region[r1], l: LinkedList[a, r]): Iterator[(Int32, a), r1, r1] \ { r, r1 } with Marshal[a] =
        iterator(rc, l) |> Iterator.enumerator


    pub def unfoldLinkedList(rc: Region[r], f: s -> Option[(a, s)] \ ef, st: s): LinkedList[a, r] \ {ef, r} with Marshal[a] =
        import new java.util.LinkedList(): ##java.util.LinkedList \ r as new1;
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => LinkedList(rc, acc)
            case Some(o, st2) => {discard add1(acc, Interop.Flix.Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())

    pub def foldLinkedList(f: (b, a) -> b \ ef, s: b, l: LinkedList[a, r]): b \ { r, ef } with Marshal[a] = region r {
        iterator(r, l) |> Iterator.foldLeft(f, s)
    }

    pub def toFlixList(l: LinkedList[a, r]): List[a] \ { r } with Marshal[a] = region r {
        iterator(r, l) |> Iterator.toList
    }

    pub def toFlixSet(l: LinkedList[a, r]): Set[a] \ { r } with Order[a], Marshal[a] = region r {
        let step = (acc, a) -> Set.insert(a, acc);
        iterator(r, l) |> Iterator.foldLeft(step, Set.empty())
    }

    pub def toArray(r1: Region[r1], l: LinkedList[a, r2]): Array[a, r1] \ {r1, r2} with Marshal[a] =
        let len = size(l);
        if (len < 1) 
            Array#{} @ r1
        else {
            ///let head = get(0, l);
            let aout = Array.new(r1, len);
            let step = (ix, a) -> {Array.put(a, ix, aout); ix+1};
            discard foldLinkedList(step, 0, l);
            aout
        }


}
