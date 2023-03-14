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

    use Interop/Util.ArrayList
    use Interop/Util.ArrayList.{ArrayList}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.ListZ
    use Interop/Util.ListZ.{ListZ}

    ///
    /// Represents a ArrayList.
    /// Class / Mutable
    ///
    pub enum ArrayList[_a: Type, r: Region] {
        case ArrayList(Region[r], ##java.util.ArrayList)
    }

    // instance Interop/Flix.MutMarshal[ArrayList] {
    //     pub def mmToJavaObject(x: ArrayList[a, r]): ##java.lang.Object =
    //         let ArrayList(x1) = x;
    //         checked_cast(x1)

    //     pub def mmFromJavaObject(_: Region[r], o: ##java.lang.Object): ArrayList[a, r] = 
    //         ArrayList(unchecked_cast(o as ##java.util.ArrayList))
    // }


    instance Interop/Util.ImpCollection[ArrayList] {
        pub def toCollection(t: ArrayList[a, r]): Collection[a, r] = 
            let ArrayList(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): ArrayList[a, r] = 
            let Collection(rc, t1) = t;
            ArrayList(rc, unchecked_cast(t1 as ##java.util.ArrayList))
    }


    instance Interop/Util.ImpListZ[ArrayList] {
        pub def toListZ(t: ArrayList[a, r]): ListZ[a, r] = 
            let ArrayList(rc, t1) = t;
            ListZ(rc, unchecked_cast(t1 as ##java.util.List))

        pub def fromListZ(t: ListZ[a, r]): ArrayList[a, r] = 
            let ListZ(rc, t1) = t;
            ArrayList(rc, unchecked_cast(t1 as ##java.util.ArrayList))
    }

}

namespace Interop/Util/ArrayList {

    use Interop/Util.ArrayList
    use Interop/Util.ArrayList.{ArrayList}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.Comparator
    use Interop/Util.ImpCollection
    use Interop/Flix.Marshal;

    
    pub def getHH(l: ArrayList[a, r]): ##java.util.ArrayList = 
        let ArrayList(_, l1) = l;
        l1

    pub def wrapHH(rc: Region[r], prim: ##java.util.ArrayList): ArrayList[a, r] =
        ArrayList(rc, prim)

    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(rc: Region[r]): ArrayList[a, r] \ Write(r) =
        import new java.util.ArrayList(): ##java.util.ArrayList \ r as newArrayList;
        ArrayList(rc, newArrayList())

    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def newWithCapacity(rc: Region[r], initialCapacity: Int32): Result[String, ArrayList[a, r]] \ Write(r) =
        Result.tryCatch(_ -> {
            import new java.util.ArrayList(Int32): ##java.util.ArrayList \ r as newArrayList;
            ArrayList(rc, newArrayList(initialCapacity))
        })

    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def newWithCollection(rc: Region[r1], c: Collection[a, r]): Result[String, ArrayList[a, r1]] \ {Read(r), Write(r1) } =
        Result.tryCatch(_ -> {
            import new java.util.ArrayList(##java.util.Collection): ##java.util.ArrayList \ {r, r1} as newArrayList;
            let Collection(_, c1) = c;
            ArrayList(rc, newArrayList(c1))
        })


    pub def toString(l: ArrayList[a, r]): String \ Read(r) = 
        import java.util.ArrayList.toString(): String \ r;
        let ArrayList(_, l1) = l;
        toString(l1)

    pub def hashCode(l: ArrayList[a, r]): Int32 \ Read(r) = 
        import java.util.ArrayList.hashCode(): Int32 \ r;
        let ArrayList(_, l1) = l;
        hashCode(l1)

    pub def equals(l1: ArrayList[a, r], l2: ArrayList[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.ArrayList.equals(##java.lang.Object): Bool \ r; 
        let ArrayList(_, ll1) = l1;
        let ArrayList(_, ll2) = l2;
        equals(ll1, checked_cast(ll2))

    pub def isEmpty(l: ArrayList[a, r]): Bool \ Read(r) = 
        import java.util.ArrayList.isEmpty(): Bool \ r;
        let ArrayList(_, l1) = l;
        isEmpty(l1)

    pub def size(l: ArrayList[a, r]): Int32 \ Read(r) = 
        import java.util.ArrayList.size(): Int32 \ r;
        let ArrayList(_, l1) = l;
        size(l1)


    pub def get(ix: Int32, l: ArrayList[a, r]): a \ Read(r) with Marshal[a] = 
        import java.util.ArrayList.get(Int32): ##java.lang.Object \ r;
        let ArrayList(_, l1) = l;
        get(l1, ix) |> Interop/Flix/Marshal.fromJavaObject

    pub def add!(x: a, l: ArrayList[a, r]): Bool \ { Write(r) } with Marshal[a] = 
        import java.util.ArrayList.add(##java.lang.Object): Bool \ r;
        let ArrayList(_, l1) = l;
        add(l1, Interop/Flix/Marshal.toJavaObject(x))

    pub def addAt!(ix: Int32, x: a, l: ArrayList[a, r]): Result[String, Unit] \ { Write(r) } with Marshal[a] = 
        Result.tryCatch(_ -> {
            import java.util.ArrayList.add(Int32, ##java.lang.Object): Unit \ r;
            let ArrayList(_, l1) = l;
            add(l1, ix, Interop/Flix/Marshal.toJavaObject(x))
        })

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, l: ArrayList[a, r]): Bool \ Write(r) = 
        import java.util.ArrayList.add(##java.lang.Object): Bool \ r;
        let ArrayList(_, l1) = l;
        add(l1, ocast(x))

    pub def addAll!(c: Collection[a, r1], l: ArrayList[a, r]): Result[String, Bool] \ { Read(r1), Write(r) }= 
        Result.tryCatch(_ -> {
            import java.util.ArrayList.addAll(##java.util.Collection): Bool \ {r, r1};
            let ArrayList(_, l1) = l;
            let Collection(_, c1) = c;
            addAll(l1, c1)
        })


    pub def remove!(x: a, l: ArrayList[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.remove(##java.lang.Object): Bool \ r; 
            let ArrayList(_, l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(l1, x1)
        })

    pub def removeAll!(c: Collection[a, r1], l: ArrayList[a, r]): Result[String, Bool] \ { Read(r1), Write(r) } with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.removeAll(##java.util.Collection): Bool \ {r, r1}; 
            let ArrayList(_, l1) = l;
            let Collection(_, c1) = c;
            removeAll(l1, c1)
        })

    pub def removeIf!(f: a -> Bool \ ef, l: ArrayList[a, r]): Result[String, Bool] \  {ef, Write(r)} with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let ArrayList(_, l1) = l;            
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            unchecked_cast(removeIf(l1, f1) as _ \ {ef, Write(r)})
        })



    pub def retainAll!(c: Collection[a, r1], l: ArrayList[a, r]): Result[String, Bool] \ { Read(r1), Write(r) } with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.retainAll(##java.util.Collection): Bool \ {r, r1}; 
            let ArrayList(_, l1) = l;
            let Collection(_, c1) = c;
            retainAll(l1, c1)
        })



    pub def forEach(f: a -> Unit \ ef, l: ArrayList[a, r]): Result[String, Unit] \  {ef, Read(r)} with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.forEach(##java.util.function.Consumer): Unit \ r; 
            let ArrayList(_, l1) = l;
            let f1 = Interop/Util/Function/Consumer.makeConsumer(f);
            forEach(l1, f1)
        })


    pub def sort!(f: (a, a) -> Int32, l: ArrayList[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        let f1 = Interop/Util/Comparator.makeComparator(f);
        sortWithComparator!(f1, l)


    pub def sortWithComparator!(c: Comparator[a], l: ArrayList[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.sort(##java.util.Comparator): Unit \ r; 
            let ArrayList(_, l1) = l;
            sort(l1, c)
        })


    // pub def fromIterable[a: Type, t: Type -> Region -> Type, r: Region, r2: Region]
    //                     (r: Region[r2], t: t[a, r]): ArrayList[a, r2] \ { Read(r), Write(r2) } with Iterable[t], Marshal[a] =
    //     let als = new(r);
    //     let iter1 = Iterable.iterator(t);
    //     Iterator.forEach(x -> discard add!(x, als), iter1);
    //     als

    pub def fromFoldable(rc: Region[r], t: t[a]): ArrayList[a, r] \ { Write(r) } with Foldable[t], Marshal[a] =
        let als = new(rc);
        Foldable.forEach(x -> discard add!(x, als), t);
        als

    pub def fromFoldableWith(rc: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): ArrayList[a, r] \ { Write(r) } with Foldable[t] =
        let als = new(rc);
        Foldable.forEach(x -> discard addWith!(x, ocast, als), t);
        als


    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(rc: Region[r1], l: ArrayList[a, r]): Iterator[a, r1, r1] \ { Read(r) } with Marshal[a] =
        toFlixIterator(rc, Interop/Flix/Marshal.fromJavaObject, l)

    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            ocast: ##java.lang.Object -> a, 
                            l: ArrayList[a, r]): Iterator[a, r1, r1] \ { Read(r) } =
        import java.util.ArrayList.iterator(): ##java.util.Iterator \ { Read(r) } as iterator;
        let ArrayList(_, l1) = l;
        if (Object.isNull(l1))
            Iterator.empty(rc)
        else 
            iterator(l1) 
                |> Interop/Util/IteratorZ.wrapHH(rc) 
                |> Interop/Util/IteratorZ.toFlixIterator(rc, ocast)



    ///
    /// Returns an iterator over `l`.
    ///
    pub def enumerator(rc: Region[r1], l: ArrayList[a, r]): Iterator[(Int32, a), r1, r1] \ { Read(r), Write(r1) } with Marshal[a] =
        iterator(rc, l) |> Iterator.enumerator


    pub def unfoldArrayList(rc: Region[r], f: s -> Option[(a, s)] \ ef, st: s): ArrayList[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.ArrayList(): ##java.util.ArrayList \ r as new1;
        import java.util.ArrayList.add(##java.lang.Object): Bool \ r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => ArrayList(rc, acc)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())

    pub def foldArrayList(f: (b, a) -> b \ ef, s: b, l: ArrayList[a, r]): b \ { Read(r), ef } with Marshal[a] = region r {
        iterator(r, l) |> Iterator.foldLeft(f, s)
    }

    pub def toFlixList(l: ArrayList[a, r]): List[a] \ { Read(r) } with Marshal[a] = region r {
        iterator(r, l) |> Iterator.toList
    }

    pub def toFlixSet(l: ArrayList[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] = region r1 {
        let step = (acc, a) -> Set.insert(a, acc);
        iterator(r1, l) |> Iterator.foldLeft(step, Set.empty())
    }

    pub def toArray(r1: Region[r1], l: ArrayList[a, r2]): Array[a, r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        let len = size(l);
        if (len < 1) 
            Array#{} @ r1
        else {
            /// let head = get(0, l);
            let aout = Array.new(r1, len);
            let step = (ix, a) -> {Array.put(a, ix, aout); ix+1};
            discard foldArrayList(step, 0, l);
            aout
        }


}
