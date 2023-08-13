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

    use Interop.Util.ArrayList
    use Interop.Util.ArrayList.{ArrayList}
    use Interop.Lang.IterableZ
    use Interop.Lang.IterableZ.{IterableZ}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.ListZ
    use Interop.Util.ListZ.{ListZ}
    

    ///
    /// Represents a ArrayList.
    /// Class / Mutable
    ///
    pub enum ArrayList[_a: Type, r: Region] {
        case ArrayList(Region[r], ##java.util.ArrayList)
    }


    instance Interop.Flix.GoesToJava[ArrayList[a, r]] with Interop.Flix.GoesToJava[a] {
        pub def toJavaObject(x: ArrayList[a, r]): ##java.lang.Object = 
            let ArrayList(_, t1) = x;
            unchecked_cast(t1 as ##java.lang.Object)
    }

    instance Interop.Flix.ColMarshal[ArrayList] {
        pub def colFromJavaObject(rc: Region[r], o: ##java.lang.Object): ArrayList[a, r] = 
            ArrayList(rc, unchecked_cast(o as ##java.util.ArrayList))
    }

    instance Interop.Util.ImpCollection[ArrayList] {
        pub def toCollection(t: ArrayList[a, r]): Collection[a, r] = 
            let ArrayList(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): ArrayList[a, r] = 
            let Collection(rc, t1) = t;
            ArrayList(rc, unchecked_cast(t1 as ##java.util.ArrayList))
    }


    instance Interop.Util.ImpListZ[ArrayList] {
        pub def toListZ(t: ArrayList[a, r]): ListZ[a, r] = 
            let ArrayList(rc, t1) = t;
            ListZ(rc, unchecked_cast(t1 as ##java.util.List))

        pub def fromListZ(t: ListZ[a, r]): ArrayList[a, r] = 
            let ListZ(rc, t1) = t;
            ArrayList(rc, unchecked_cast(t1 as ##java.util.ArrayList))
    }


    instance Interop.Lang.ImpIterable[ArrayList] {
        pub def toIterable(t: ArrayList[a, r]): IterableZ[a, r] = 
            let ArrayList(rc, t1) = t;
            IterableZ(rc, unchecked_cast(t1 as ##java.lang.Iterable))

        pub def fromIterable(t: IterableZ[a, r]): ArrayList[a, r] = 
            let IterableZ(rc, t1) = t;
            ArrayList(rc, unchecked_cast(t1 as ##java.util.ArrayList))
    }


}

mod Interop.Util.ArrayList {

    use Interop.Util.ArrayList
    use Interop.Util.ArrayList.{ArrayList}
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

    
    pub def getHH(l: ArrayList[a, r]): ##java.util.ArrayList = 
        let ArrayList(_, l1) = l;
        l1

    pub def wrapHH(rc: Region[r], prim: ##java.util.ArrayList): ArrayList[a, r] =
        ArrayList(rc, prim)

    pub def fromJavaObject(rc: Region[r], o: ##java.lang.Object): ArrayList[a, r] = 
        ArrayList(rc, unchecked_cast(o as ##java.util.ArrayList))


    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(rc: Region[r]): ArrayList[a, r] \ r =
        import new java.util.ArrayList(): ##java.util.ArrayList \ r as newArrayList;
        ArrayList(rc, newArrayList())

    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def newWithCapacity(rc: Region[r], initialCapacity: Int32): Result[String, ArrayList[a, r]] \ r =
        Result.tryCatch(_ -> {
            import new java.util.ArrayList(Int32): ##java.util.ArrayList \ r as newArrayList;
            ArrayList(rc, newArrayList(initialCapacity))
        })

    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def newWithCollection(rc: Region[r1], c: Collection[a, r]): Result[String, ArrayList[a, r1]] \ {r, r1 } =
        Result.tryCatch(_ -> {
            import new java.util.ArrayList(##java.util.Collection): ##java.util.ArrayList \ {r, r1} as newArrayList;
            let Collection(_, c1) = c;
            ArrayList(rc, newArrayList(c1))
        })


    pub def toString(l: ArrayList[a, r]): String \ r = 
        import java.util.ArrayList.toString(): String \ r;
        let ArrayList(_, l1) = l;
        toString(l1)

    pub def hashCode(l: ArrayList[a, r]): Int32 \ r = 
        import java.util.ArrayList.hashCode(): Int32 \ r;
        let ArrayList(_, l1) = l;
        hashCode(l1)

    pub def equals(l1: ArrayList[a, r], l2: ArrayList[a, r]): Bool \ r =
        import java.util.ArrayList.equals(##java.lang.Object): Bool \ r; 
        let ArrayList(_, ll1) = l1;
        let ArrayList(_, ll2) = l2;
        equals(ll1, checked_cast(ll2))

    pub def isEmpty(l: ArrayList[a, r]): Bool \ r = 
        import java.util.ArrayList.isEmpty(): Bool \ r;
        let ArrayList(_, l1) = l;
        isEmpty(l1)

    pub def size(l: ArrayList[a, r]): Int32 \ r = 
        import java.util.ArrayList.size(): Int32 \ r;
        let ArrayList(_, l1) = l;
        size(l1)


    pub def getAt(ix: Int32, l: ArrayList[a, r]): ##java.lang.Object \ r = 
        import java.util.ArrayList.get(Int32): ##java.lang.Object \ r as get1;
        let ArrayList(_, l1) = l;
        get1(l1, ix)

    pub def add!(x: a, l: ArrayList[a, r]): Bool \ r with GoesToJava[a] = 
        import java.util.ArrayList.add(##java.lang.Object): Bool \ r;
        let ArrayList(_, l1) = l;
        add(l1, Interop.Flix.GoesToJava.toJavaObject(x))

    pub def addAt!(ix: Int32, x: a, l: ArrayList[a, r]): Result[String, Unit] \ r with GoesToJava[a] = 
        Result.tryCatch(_ -> {
            import java.util.ArrayList.add(Int32, ##java.lang.Object): Unit \ r;
            let ArrayList(_, l1) = l;
            add(l1, ix, Interop.Flix.GoesToJava.toJavaObject(x))
        })

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, l: ArrayList[a, r]): Bool \ r = 
        import java.util.ArrayList.add(##java.lang.Object): Bool \ r;
        let ArrayList(_, l1) = l;
        add(l1, ocast(x))

    pub def addAll!(c: Collection[a, r1], l: ArrayList[a, r]): Result[String, Bool] \ {r, r1} = 
        Result.tryCatch(_ -> {
            import java.util.ArrayList.addAll(##java.util.Collection): Bool \ {r, r1};
            let ArrayList(_, l1) = l;
            let Collection(_, c1) = c;
            addAll(l1, c1)
        })


    pub def remove!(x: a, l: ArrayList[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.remove(##java.lang.Object): Bool \ r; 
            let ArrayList(_, l1) = l;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            remove(l1, x1)
        })

    pub def removeAll!(c: Collection[a, r1], l: ArrayList[a, r]): Result[String, Bool] \ { r1, r } =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.removeAll(##java.util.Collection): Bool \ {r, r1}; 
            let ArrayList(_, l1) = l;
            let Collection(_, c1) = c;
            removeAll(l1, c1)
        })

    pub def removeIf!(f: PredicateZ[a, ef], l: ArrayList[a, r]): Result[String, Bool] \  {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let ArrayList(_, l1) = l;
            let PredicateZ(f1) = f;
            checked_ecast(removeIf(l1, f1))
        })



    pub def retainAll!(c: Collection[a, r1], l: ArrayList[a, r]): Result[String, Bool] \ { r1, r } =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.retainAll(##java.util.Collection): Bool \ {r, r1}; 
            let ArrayList(_, l1) = l;
            let Collection(_, c1) = c;
            retainAll(l1, c1)
        })



    pub def forEach(f: ConsumerZ[a, ef], l: ArrayList[a, r]): Result[String, Unit] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.forEach(##java.util.function.Consumer): Unit \ {ef, r}; 
            let ArrayList(_, l1) = l;
            let ConsumerZ(f1) = f;
            forEach(l1, f1)
        })


    pub def sort!(c: Comparator[a, ef], l: ArrayList[a, r]): Result[String, Unit] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.ArrayList.sort(##java.util.Comparator): Unit \ {ef, r}; 
            let ArrayList(_, l1) = l;
            let Comparator(c1) = c;
            sort(l1, c1)
        })


    // pub def fromIterable[a: Type, t: Type -> Region -> Type, r: Region, r2: Region]
    //                     (r: Region[r2], t: t[a, r]): ArrayList[a, r2] \ { r, Write(r2) } with Iterable[t], Marshal[a] =
    //     let als = new(r);
    //     let iter1 = Iterable.iterator(t);
    //     Iterator.forEach(x -> discard add!(x, als), iter1);
    //     als

    pub def fromFoldable(rc: Region[r], t: t[a]): ArrayList[a, r] \ r with Foldable[t], GoesToJava[a] =
        let als = new(rc);
        Foldable.forEach(x -> discard add!(x, als), t);
        als

    pub def fromFoldableWith(rc: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): ArrayList[a, r] \ r with Foldable[t] =
        let als = new(rc);
        Foldable.forEach(x -> discard addWith!(x, ocast, als), t);
        als


    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            getter: ##java.lang.Object -> b \ ef, 
                            l: ArrayList[a, r]): Iterator[b, ef + r1, r1] \ r =
        import java.util.ArrayList.iterator(): ##java.util.Iterator \ r as iterator;
        let ArrayList(_, l1) = l;
        if (Object.isNull(l1))
            Iterator.iterate(rc, _ -> checked_ecast(None))
        else 
            iterator(l1) 
                |> Interop.Util.IteratorZ.wrapHH(rc) 
                |> Interop.Util.IteratorZ.toFlixIterator(rc, getter)


    pub def toFlixList(getter: ##java.lang.Object -> b \ ef, l: ArrayList[a, r]): List[b] \ {ef, r} = region rc {
        toFlixIterator(rc, getter, l) |> Iterator.toList
    }

    pub def toFlixSet(getter: ##java.lang.Object -> b \ ef, l: ArrayList[a, r]): Set[b] \ {ef, r} with Order[b] = region rc {
        toFlixIterator(rc, getter, l) |> Iterator.toSet
    }

    pub def toArray(r1: Region[r1], getter: ##java.lang.Object -> b \ ef, l: ArrayList[a, r]): Array[b, r1] \ {ef, r, r1} = region rc {
        toFlixIterator(rc, getter, l) |> Iterator.toArray(r1)
    }


    pub def unfoldArrayList(rc: Region[r], f: s -> Option[(a, s)] \ ef, st: s): ArrayList[a, r] \ {ef, r} with GoesToJava[a] =
        import new java.util.ArrayList(): ##java.util.ArrayList \ r as new1;
        import java.util.ArrayList.add(##java.lang.Object): Bool \ r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => ArrayList(rc, acc)
            case Some(o, st2) => {discard add1(acc, Interop.Flix.GoesToJava.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())


}
