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
    pub enum ListZ[_: Type, r: Region] { 
        case ListZ(Region[r], ##java.util.List)
    }

    pub class ImpListZ[t: Type -> Region -> Type] {
        pub def toListZ[a: Type, r: Region, r1: Region](rc: Region[r1], s: t[a, r]): ListZ[a, r1]
        pub def fromListZ[a: Type, r: Region, r1: Region](rc: Region[r1], s: ListZ[a, r]): t[a, r1]
    }


    instance Interop/Util.ImpCollection[ListZ] {
        pub def toCollection(rc: Region[r1], t: ListZ[a, r]): Collection[a, r1] = 
            let ListZ(_, t1) = t;
            Collection(rc, unsafe_cast t1 as ##java.util.Collection)

        pub def fromCollection(rc: Region[r1], t: Collection[a, r]): ListZ[a, r1] = 
            let Collection(_, t1) = t;
            ListZ(rc, unsafe_cast t1 as ##java.util.List) 
    }

}

namespace Interop/Util/ListZ {

    use Interop/Util.ListZ
    use Interop/Util.ListZ.{ListZ}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.Comparator
    use Interop/Util.ImpListZ
    use Interop/Flix.Marshal


    pub def getHH(l: ListZ[a, r]): ##java.util.List = 
        let ListZ(_, l1) = l;
        l1

    pub def wrapHH(rc: Region[r], prim: ##java.util.List): ListZ[a, r] =
        ListZ(rc, prim)


    pub def toListHH[t: Type -> Region -> Type, a: Type, r: Region, r1: Region](rc: Region[r1], l: t[a, r]): ##java.util.List with ImpListZ[t] = 
        Interop/Util/ImpListZ.toListZ(rc, l) |> getHH


    pub def of0(rc: Region[r]): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(): ##java.util.List \ r;
        ListZ(rc, of())

    pub def of1(rc: Region[r], e1: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        ListZ(rc, of(eo1))

    pub def of2(rc: Region[r], e1: a, e2: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        ListZ(rc, of(eo1, eo2))

    pub def of3(rc: Region[r], e1: a, e2: a, e3: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        ListZ(rc, of(eo1, eo2, eo3))

    pub def of4(rc: Region[r], e1: a, e2: a, e3: a, e4: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        let eo4 = Interop/Flix/Marshal.toJavaObject(e4);
        ListZ(rc, of(eo1, eo2, eo3, eo4))

    pub def of5(rc: Region[r], e1: a, e2: a, e3: a, e4: a, e5: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        let eo4 = Interop/Flix/Marshal.toJavaObject(e4);
        let eo5 = Interop/Flix/Marshal.toJavaObject(e5);
        ListZ(rc, of(eo1, eo2, eo3, eo4, eo5))

    pub def equals(l1: ListZ[a, r], l2: ListZ[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.List.equals(##java.lang.Object): Bool \ r; 
        let ListZ(_, ll1) = l1;
        let ListZ(_, ll2) = l2;
        equals(ll1, unsafe_cast ll2 as ##java.lang.Object)


    pub def hashCode(l: ListZ[a, r]): Int32 \ Read(r) = 
        import java.util.List.hashCode(): Int32 \ r;
        let ListZ(_, l1) = l;
        hashCode(l1)

    pub def isEmpty(l: ListZ[a, r]): Bool \ Read(r) = 
        import java.util.List.isEmpty(): Bool \ r;
        let ListZ(_, l1) = l;
        isEmpty(l1)

    pub def size(l: ListZ[a, r]): Int32 \ Read(r) = 
        import java.util.List.size(): Int32 \ r;
        let ListZ(_, l1) = l;
        size(l1)

    pub def add!(x: a, l: ListZ[a, r]): Result[String, Bool] \ Write(r) with Marshal[a] =
        try {
            import java.util.List.add(##java.lang.Object): Bool \ r;
            let ListZ(_, l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            add(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def addAll!(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ { Read(r1), Write(r) } with Marshal[a] =
        try {
            import java.util.List.addAll(##java.util.Collection): Bool \ {r1, r}; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            addAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def contains(x: a, l: ListZ[a, r]): Result[String, Bool] \  Read(r) with Marshal[a] =
        try {
            import java.util.List.contains(##java.lang.Object): Bool \ r; 
            let ListZ(_, l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            contains(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def containsAll(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ { Read(r1), Read(r) } with Marshal[a] =
        try {
            import java.util.List.containsAll(##java.util.Collection): Bool \ {r1, r}; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            containsAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def clear!(l: ListZ[a, r]): Result[String, Unit] \ Read(r) = 
        try {
            import java.util.List.clear(): Unit \ r;
            let ListZ(_, l1) = l;
            clear(l1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def remove!(x: a, l: ListZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.List.remove(##java.lang.Object): Bool \ r; 
            let ListZ(_, l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def removeAll!(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ { Read(r1), Write(r) } with Marshal[a] =
        try {
            import java.util.List.removeAll(##java.util.Collection): Bool \ { Read(r1), Write(r) }; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            removeAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    
    pub def removeIf!(f: a -> Bool \ ef, l: ListZ[a, r]): Result[String, Bool] \ { ef, Write(r) } with Marshal[a] =
        try {
            import java.util.List.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let ListZ(_, l1) = l;        
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            (unsafe_cast removeIf(l1, f1) as _ \ {ef, Write(r)}) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def retainAll!(c: Collection[a, r1], l: ListZ[a, r]): Result[String, Bool] \ { Read(r1), Write(r) } with Marshal[a] =
        try {
            import java.util.List.retainAll(##java.util.Collection): Bool \ { Read(r1), Write(r) }; 
            let ListZ(_, l1) = l;
            let Collection(_, c1) = c;
            retainAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def forEach(f: a -> Unit \ ef, l: ListZ[a, r]): Result[String, Unit] \  {ef, Read(r)} with Marshal[a] =
        try {
            import java.util.List.forEach(##java.util.function.Consumer): Unit \ r; 
            let ListZ(_, l1) = l;
            let f1 = Interop/Util/Function/Consumer.makeConsumer(f);
            forEach(l1, f1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def sort!(f: (a, a) -> Int32, l: ListZ[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        let f1 = Interop/Util/Comparator.makeComparator(f);
        sortWithComparator!(f1, l)


    pub def sortWithComparator!(c: Comparator[a], l: ListZ[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        try {
            import java.util.List.sort(##java.util.Comparator): Unit \ r; 
            let ListZ(_, l1) = l;
            sort(l1, c) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(rc: Region[r1], l: ListZ[a, r]): Iterator[a, r1, r1] \ { Read(r) } with Marshal[a] =
        toFlixIterator(rc, Interop/Flix/Marshal.fromJavaObject, l)

    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[r1], ocast: ##java.lang.Object -> a, l: ListZ[a, r]): Iterator[a, r1, r1] \ { Read(r)} =
        import java.util.List.iterator(): ##java.util.Iterator \ { Read(r) };
        let ListZ(_, l1) = l;
        if (Object.isNull(l1))
            Iterator.empty(rc)
        else 
            iterator(l1) 
                |> Interop/Util/IteratorZ.wrapHH(rc)
                |> Interop/Util/IteratorZ.toFlixIterator(rc, ocast)



    pub def toFlixList(l: ListZ[a, r]): List[a] \ { Read(r) } with Marshal[a] = region r {
        toFlixIterator(r, Interop/Flix/Marshal.fromJavaObject, l) |> Iterator.toList
    }

    pub def toSet(l: ListZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] = region r {
        toFlixIterator(r, Interop/Flix/Marshal.fromJavaObject, l) |> Iterator.toSet
    }


    /// TEMP ...

    pub def fromArrayOfObject(rc: Region[r1], arr: Array[##java.lang.Object, r]): Result[String, ListZ[##java.lang.Object, r1]] \ { Read(r), Write(r1) } =
        try {
            import static java.util.Arrays.asList(Array[##java.lang.Object, r]): ##java.util.List \ { Read(r), Write(r1) };
            ListZ(rc, asList(arr)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def toArrayOfString(rc: Region[r1], l: ListZ[String, r]): Result[String, Array[String, r1]] \ { Read(r), Write(r1) } =
        try {
            import java.util.List.toArray(): Array[String, r1] \ { Read(r), Write(r1) };
            let _ = Array#{} @ rc;
            let ListZ(_, l1) = l;
            toArray(l1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
