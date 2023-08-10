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

    use Interop.Util.ListZ
    use Interop.Util.ListZ.{ListZ}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}

    ///
    /// Represents a Java List.
    /// Interface / Mutable
    ///
    pub enum ListZ[_: Type, r: Region] { 
        case ListZ(Region[r], ##java.util.List)
    }

    pub class ImpListZ[t: Type -> Region -> Type] {
        pub def toListZ(s: t[a, r]): ListZ[a, r]
        pub def fromListZ(s: ListZ[a, r]): t[a, r]

        pub def toListHH(s: t[a, r]): ##java.util.List = 
           ImpListZ.toListZ(s) |> Interop.Util.ListZ.getHH        
    }

    instance Interop.Flix.GoesToJava[ListZ[a, r]] with Interop.Flix.GoesToJava[a] {
        pub def toJavaObject(x: ListZ[a, r]): ##java.lang.Object = 
            let ListZ(_, t1) = x;
            unchecked_cast(t1 as ##java.lang.Object)
    }

    instance Interop.Flix.ColMarshal[ListZ] {
        pub def colFromJavaObject(rc: Region[r], o: ##java.lang.Object): ListZ[a, r] = 
            ListZ(rc, unchecked_cast(o as ##java.util.List))
    }

    instance Interop.Util.ImpCollection[ListZ] {
        pub def toCollection(t: ListZ[a, r]): Collection[a, r] = 
            let ListZ(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): ListZ[a, r] = 
            let Collection(rc, t1) = t;
            ListZ(rc, unchecked_cast(t1 as ##java.util.List))
    }

}

mod Interop.Util.ListZ {

    use Interop.Util.ListZ
    use Interop.Util.ListZ.{ListZ}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.Comparator
    use Interop.Util.ImpListZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava


    pub def getHH(l: ListZ[a, r]): ##java.util.List = 
        let ListZ(_, l1) = l;
        l1

    pub def wrapHH(rc: Region[r], prim: ##java.util.List): ListZ[a, r] =
        ListZ(rc, prim)


    pub def of0(rc: Region[r]): ListZ[a, r] \ r with GoesToJava[a] =
        import static java.util.List.of(): ##java.util.List \ r;
        ListZ(rc, of())

    pub def of1(rc: Region[r], e1: a): ListZ[a, r] \ r with GoesToJava[a] =
        import static java.util.List.of(##java.lang.Object): ##java.util.List \ r;
        let o1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        ListZ(rc, of(o1))

    pub def of2(rc: Region[r], e1: a, e2: a): ListZ[a, r] \ r with GoesToJava[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let o1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let o2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        ListZ(rc, of(o1, o2))

    pub def of3(rc: Region[r], e1: a, e2: a, e3: a): ListZ[a, r] \ r with GoesToJava[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let o1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let o2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        let o3 = Interop.Flix.GoesToJava.toJavaObject(e3);
        ListZ(rc, of(o1, o2, o3))

    pub def of4(rc: Region[r], e1: a, e2: a, e3: a, e4: a): ListZ[a, r] \ r with GoesToJava[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let o1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let o2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        let o3 = Interop.Flix.GoesToJava.toJavaObject(e3);
        let o4 = Interop.Flix.GoesToJava.toJavaObject(e4);
        ListZ(rc, of(o1, o2, o3, o4))

    pub def of5(rc: Region[r], e1: a, e2: a, e3: a, e4: a, e5: a): ListZ[a, r] \ r with GoesToJava[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let o1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let o2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        let o3 = Interop.Flix.GoesToJava.toJavaObject(e3);
        let o4 = Interop.Flix.GoesToJava.toJavaObject(e4);
        let o5 = Interop.Flix.GoesToJava.toJavaObject(e5);
        ListZ(rc, of(o1, o2, o3, o4, o5))

    pub def equals(l1: ListZ[a, r], l2: ListZ[a, r]): Bool \ r =
        import java.util.List.equals(##java.lang.Object): Bool \ r; 
        let ListZ(_, ll1) = l1;
        let ListZ(_, ll2) = l2;
        equals(ll1, checked_cast(ll2))


    pub def hashCode(l: ListZ[a, r]): Int32 \ r =
        import java.util.List.hashCode(): Int32 \ r;
        let ListZ(_, l1) = l;
        hashCode(l1)

    pub def isEmpty(l: ListZ[a, r]): Bool \ r = 
        import java.util.List.isEmpty(): Bool \ r;
        let ListZ(_, l1) = l;
        isEmpty(l1)

    pub def size(l: ListZ[a, r]): Int32 \ r = 
        import java.util.List.size(): Int32 \ r;
        let ListZ(_, l1) = l;
        size(l1)

    pub def add!(x: a, l: ListZ[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.add(##java.lang.Object): Bool \ r;
            let ListZ(_, l1) = l;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            add(l1, x1)
        })

    pub def addAll!(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ {r, r1} with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.addAll(##java.util.Collection): Bool \ {r, r1}; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            addAll(l1, c1)
        })

    pub def contains(x: a, l: ListZ[a, r]): Result[String, Bool] \  r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.contains(##java.lang.Object): Bool \ r; 
            let ListZ(_, l1) = l;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            contains(l1, x1)
        })

    pub def containsAll(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ {r, r1} =
        Result.tryCatch(_ -> {
            import java.util.List.containsAll(##java.util.Collection): Bool \ {r, r1}; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            containsAll(l1, c1)
        })

    pub def clear!(l: ListZ[a, r]): Result[String, Unit] \ r = 
        Result.tryCatch(_ -> {
            import java.util.List.clear(): Unit \ r;
            let ListZ(_, l1) = l;
            clear(l1)
        })


    pub def remove!(x: a, l: ListZ[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.remove(##java.lang.Object): Bool \ r; 
            let ListZ(_, l1) = l;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            remove(l1, x1)
        })

    pub def removeAll!(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ {r, r1} =
        Result.tryCatch(_ -> {
            import java.util.List.removeAll(##java.util.Collection): Bool \ {r, r1}; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            removeAll(l1, c1)
        })
    
    pub def removeIf![a: Type, ef: Eff, r: Region]
                        (f: a -> Bool \ ef, l: ListZ[a, r]): Result[String, Bool] \ {ef, r} with ComesFromJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let ListZ(_, l1) = l;
            let PredicateZ(f1) = Interop.Util.Function.PredicateZ.makePredicateZ(f);
            checked_ecast(removeIf(l1, f1))
        })

    pub def retainAll!(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ {r, r1} =
        Result.tryCatch(_ -> {
            import java.util.List.retainAll(##java.util.Collection): Bool \ {r, r1}; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            retainAll(l1, c1)
        })

    pub def forEach[a: Type, ef: Eff, r: Region]
                    (f: a -> Unit \ ef, l: ListZ[a, r]): Result[String, Unit] \  {ef, r} with ComesFromJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.forEach(##java.util.function.Consumer): Unit \ {ef, r}; 
            let ListZ(_, l1) = l;
            let ConsumerZ(f1) = Interop.Util.Function.ConsumerZ.makeConsumerZ(f);
            forEach(l1, f1)
        })


    pub def sort!(f: (a, a) -> Int32, l: ListZ[a, r]): Result[String, Unit] \ r with ComesFromJava[a] =
        let f1 = Interop.Util.Comparator.makeComparator(f);
        sortWithComparator!(f1, l)


    pub def sortWithComparator!(c: Comparator[a], l: ListZ[a, r]): Result[String, Unit] \ r with ComesFromJava[a] =
        Result.tryCatch(_ -> {
            import java.util.List.sort(##java.util.Comparator): Unit \ r; 
            let ListZ(_, l1) = l;
            sort(l1, c)
        })

    pub def fromFoldableViaArrayList(rc: Region[r], t: t[a]): ListZ[a, r] \ { r } with Foldable[t], GoesToJava[a] =
        Interop.Util.ArrayList.fromFoldable(rc, t) |> Interop.Util.ImpListZ.toListZ

    pub def fromFoldableViaArrayListHH(t: t[a]): ##java.util.List with Foldable[t], GoesToJava[a] = region rc {
        Interop.Util.ArrayList.fromFoldable(rc, t) |> Interop.Util.ImpListZ.toListHH
    }

    pub def fromFoldableViaLinkedList(rc: Region[r], t: t[a]): ListZ[a, r] \ r with Foldable[t], GoesToJava[a] =
        Interop.Util.LinkedList.fromFoldable(rc, t) |> Interop.Util.ImpListZ.toListZ

    pub def fromFoldableViaLinkedListHH(t: t[a]): ##java.util.List with Foldable[t], GoesToJava[a] = region rc {
        Interop.Util.LinkedList.fromFoldable(rc, t) |> Interop.Util.ImpListZ.toListHH
    }



    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[r1], fromJava: ##java.lang.Object -> a, l: ListZ[a, r]): Iterator[a, r1, r1] \ { r} =
        import java.util.List.iterator(): ##java.util.Iterator \ r;
        let ListZ(_, l1) = l;
        if (Object.isNull(l1))
            Iterator.empty(rc)
        else 
            iterator(l1) 
                |> Interop.Util.IteratorZ.wrapHH(rc)
                |> Interop.Util.IteratorZ.toFlixIterator(rc, fromJava)



    pub def toFlixList(fromJava: ##java.lang.Object -> a, l: ListZ[a, r]): List[a] \ r = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toList
    }


    pub def toFlixSet(fromJava: ##java.lang.Object -> a, l: ListZ[a, r]): Set[a] \ r with Order[a] = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toSet
    }


    /// TEMP ...

    pub def fromArrayOfObject(rc: Region[r1], arr: Array[##java.lang.Object, r]): Result[String, ListZ[##java.lang.Object, r1]] \ { r, r1 } =
        Result.tryCatch(_ -> {
            import static java.util.Arrays.asList(Array[##java.lang.Object, r]): ##java.util.List \ { r, r1 };
            ListZ(rc, asList(arr))
        })

    pub def toArrayOfString(rc: Region[r1], l: ListZ[String, r]): Result[String, Array[String, r1]] \ { r, r1 } =
        Result.tryCatch(_ -> {
            import java.util.List.toArray(): Array[String, r1] \ { r, r1 };
            let _ = Array#{} @ rc;
            let ListZ(_, l1) = l;
            toArray(l1)
        })


}
