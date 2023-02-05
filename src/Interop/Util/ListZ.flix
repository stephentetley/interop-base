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

    pub class ImpListZ[t: Type -> Region -> Type] {
        pub def toListZ[a: Type, r: Region](s: t[a, r]): ListZ[a, r]
        pub def fromListZ[a: Type, r: Region](s: ListZ[a, r]): t[a, r]
    }


    instance Interop/Util.ImpCollection[ListZ] {
        pub def toCollection(t: ListZ[a, r]): Collection[a, r] = 
            let ListZ(t1) = t;
            Collection(unsafe_cast t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): ListZ[a, r] = 
            let Collection(t1) = t;
            ListZ(unsafe_cast t1 as ##java.util.List) 
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


    pub def getHH(m: ListZ[a, r]): ##java.util.List = 
        let ListZ(m1) = m;
        m1

    pub def wrapHH(_: Region[r], prim: ##java.util.List): ListZ[a, r] =
        ListZ(prim)


    pub def toListHH[t: Type -> Region -> Type, a: Type, r: Region](list: t[a, r]): ##java.util.List with ImpListZ[t] = 
        Interop/Util/ImpListZ.toListZ(list) |> getHH


    pub def of0(_: Region[r]): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(): ##java.util.List \ r;
        of() |> ListZ

    pub def of1(_: Region[r], e1: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        of(eo1) |> ListZ

    pub def of2(_: Region[r], e1: a, e2: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        of(eo1, eo2) |> ListZ

    pub def of3(_: Region[r], e1: a, e2: a, e3: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        of(eo1, eo2, eo3) |> ListZ

    pub def of4(_: Region[r], e1: a, e2: a, e3: a, e4: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        let eo4 = Interop/Flix/Marshal.toJavaObject(e4);
        of(eo1, eo2, eo3, eo4) |> ListZ

    pub def of5(_: Region[r], e1: a, e2: a, e3: a, e4: a, e5: a): ListZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.List.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.List \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        let eo4 = Interop/Flix/Marshal.toJavaObject(e4);
        let eo5 = Interop/Flix/Marshal.toJavaObject(e5);
        of(eo1, eo2, eo3, eo4, eo5) |> ListZ

    pub def equals(l1: ListZ[a, r], l2: ListZ[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.List.equals(##java.lang.Object): Bool \ r; 
        let ListZ(jl1) = l1;
        let ListZ(jl2) = l2;
        equals(jl1, unsafe_cast jl2 as ##java.lang.Object)


    pub def hashCode(l: ListZ[a, r]): Int32 \ Read(r) = 
        import java.util.List.hashCode(): Int32 \ r;
        let ListZ(l1) = l;
        hashCode(l1)

    pub def isEmpty(l: ListZ[a, r]): Bool \ Read(r) = 
        import java.util.List.isEmpty(): Bool \ r;
        let ListZ(l1) = l;
        isEmpty(l1)

    pub def size(l: ListZ[a, r]): Int32 \ Read(r) = 
        import java.util.List.size(): Int32 \ r;
        let ListZ(l1) = l;
        size(l1)

    pub def add!(x: a, l: ListZ[a, r]): Result[String, Bool] \ Write(r) with Marshal[a] =
        try {
            import java.util.List.add(##java.lang.Object): Bool \ r;
            let ListZ(l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            add(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def addAll!(c: Collection[a, r], l: ListZ[a, r]): Result[String, Bool] \ Write(r) with Marshal[a] =
        try {
            import java.util.List.addAll(##java.util.Collection): Bool \ r; 
            let ListZ(l1) = l;
            let Collection(c1) = c;
            addAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def contains(x: a, l: ListZ[a, r]): Result[String, Bool] \  Read(r) with Marshal[a] =
        try {
            import java.util.List.contains(##java.lang.Object): Bool \ r; 
            let ListZ(l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            contains(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def containsAll(c: Collection[a, r], l: ListZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.List.containsAll(##java.util.Collection): Bool \ r; 
            let ListZ(l1) = l;
            let Collection(c1) = c;
            containsAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def clear!(l: ListZ[a, r]): Result[String, Unit] \ Read(r) = 
        try {
            import java.util.List.clear(): Unit \ r;
            let ListZ(l1) = l;
            clear(l1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def remove!(x: a, l: ListZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.List.remove(##java.lang.Object): Bool \ r; 
            let ListZ(l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def removeAll!(c: Collection[a, r], l: ListZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.List.removeAll(##java.util.Collection): Bool \ r; 
            let ListZ(l1) = l;
            let Collection(c1) = c;
            removeAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    
    pub def removeIf!(f: a -> Bool \ ef, l: ListZ[a, r]): Result[String, Bool] \  {ef, Write(r)} with Marshal[a] =
        try {
            import java.util.List.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let ListZ(l1) = l;        
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            (unsafe_cast removeIf(l1, f1) as _ \ {ef, Write(r)}) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def retainAll!(c: Collection[a, r], l: ListZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.List.retainAll(##java.util.Collection): Bool \ r; 
            let ListZ(l1) = l;
            let Collection(c1) = c;
            retainAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def forEach(f: a -> Unit \ ef, l: ListZ[a, r]): Result[String, Unit] \  {ef, Read(r)} with Marshal[a] =
        try {
            import java.util.List.forEach(##java.util.function.Consumer): Unit \ r; 
            let ListZ(l1) = l;
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
            let ListZ(l1) = l;
            sort(l1, c) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(rh: Region[rh], l: ListZ[a, r]): Iterator[a, ef, rh] \ { Read(r), Write(rh) } with Marshal[a] =
        toFlixIterator(rh, Interop/Flix/Marshal.fromJavaObject, l)
    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(rc: Region[rh], ocast: ##java.lang.Object -> a, l: ListZ[a, r]): Iterator[a, ef, rh] \ { Read(r), Write(rh) } =
        import java.util.List.iterator(): ##java.util.Iterator \ { Read(r), Write(rh) };
        let ListZ(l1) = l;
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

    pub def fromArrayOfObject(arr: Array[##java.lang.Object, r1]): Result[String, ListZ[##java.lang.Object, r1]] \ { Read(r1), Write(r1) } =
        try {
            import static java.util.Arrays.asList(Array[##java.lang.Object, r1]): ##java.util.List \ { Read(r1), Write(r1) };
            asList(arr) |> ListZ |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def toArrayOfString(r1: Region[r1], l: ListZ[String, r2]): Result[String, Array[String, r1]] \ { Read(r2), Write(r1) } =
        try {
            import java.util.List.toArray(): Array[String, r1] \ { Read(r2), Write(r1) };
            let _ = Array#{} @ r1;
            let ListZ(l1) = l;
            toArray(l1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
