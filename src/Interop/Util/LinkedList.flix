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

    use Interop/Util.Collection;
    use Interop/Util.Collection.{Collection};
    use Interop/Util.ListZ;
    use Interop/Util.ListZ.{ListZ};

    ///
    /// Represents a LinkedList.
    /// Class / Mutable
    ///
    pub enum LinkedList[_: Type, _: Region](##java.util.LinkedList)

    instance Scoped[LinkedList[a]] {
        pub def regionOf(_: LinkedList[a, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpCollection[LinkedList] {
        pub def toCollection(t: LinkedList[a, r]): Collection[a, r] = 
            let LinkedList(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): LinkedList[a, r] = 
            let Collection(t1) = t;
            LinkedList(t1 as ##java.util.LinkedList) 
    }


    instance Interop/Util.ImpListZ[LinkedList] {
        pub def toListZ(t: LinkedList[a, r]): ListZ[a, r] = 
            let LinkedList(t1) = t;
            ListZ(t1 as ##java.util.List)

        pub def fromListZ(t: ListZ[a, r]): LinkedList[a, r] = 
            let ListZ(t1) = t;
            LinkedList(t1 as ##java.util.LinkedList) 
    }

}

namespace Interop/Util/LinkedList {

    use Interop/Util.LinkedList
    use Interop/Util.LinkedList.{LinkedList}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.Comparator
    use Interop/Util.ImpCollection
    use Interop/Flix.Marshal;

    
    pub def getHH(l: LinkedList[a, r]): ##java.util.LinkedList = 
        let LinkedList(l1) = l;
        l1

    pub def wrapHH(_: Region[r], prim: ##java.util.LinkedList): LinkedList[a, r] =
        LinkedList(prim)

    ///
    /// Returns a new mutable LinkedList.
    ///
    pub def new(_: Region[r]): LinkedList[a, r] \ Write(r) =
        import new java.util.LinkedList(): ##java.util.LinkedList \ r as newLinkedList;
        LinkedList(newLinkedList())


    pub def toString(l: LinkedList[a, r]): String \ Read(r) = 
        import java.util.LinkedList.toString(): String \ r;
        let LinkedList(l1) = l;
        toString(l1)

    pub def hashCode(l: LinkedList[a, r]): Int32 \ Read(r) = 
        import java.util.LinkedList.hashCode(): Int32 \ r;
        let LinkedList(l1) = l;
        hashCode(l1)

    pub def equals(l1: LinkedList[a, r], l2: LinkedList[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.LinkedList.equals(##java.lang.Object): Bool \ r; 
        let LinkedList(jl1) = l1;
        let LinkedList(jl2) = l2;
        equals(jl1, jl2 as ##java.lang.Object)

    pub def isEmpty(l: LinkedList[a, r]): Bool \ Read(r) = 
        import java.util.LinkedList.isEmpty(): Bool \ r;
        let LinkedList(l1) = l;
        isEmpty(l1)

    pub def size(l: LinkedList[a, r]): Int32 \ Read(r) = 
        import java.util.LinkedList.size(): Int32 \ r;
        let LinkedList(l1) = l;
        size(l1)


    pub def get(ix: Int32, l: LinkedList[a, r]): a \ Read(r) with Marshal[a] = 
        import java.util.LinkedList.get(Int32): ##java.lang.Object \ r;
        let LinkedList(l1) = l;
        get(l1, ix) |> Interop/Flix/Marshal.fromJavaObject

    pub def add!(x: a, l: LinkedList[a, r]): Bool \ { Write(r) } with Marshal[a] = 
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r;
        let LinkedList(l1) = l;
        add(l1, Interop/Flix/Marshal.toJavaObject(x))

    pub def addAt!(ix: Int32, x: a, l: LinkedList[a, r]): Result[Unit, String] \ { Write(r) } with Marshal[a] = 
        try {
            import java.util.LinkedList.add(Int32, ##java.lang.Object): Unit \ r;
            let LinkedList(l1) = l;
            add(l1, ix, Interop/Flix/Marshal.toJavaObject(x)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, l: LinkedList[a, r]): Bool \ Write(r) = 
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r;
        let LinkedList(l1) = l;
        add(l1, ocast(x))

    pub def addAll!(c: Collection[a, r], l: LinkedList[a, r]): Result[Bool, String] \ Write(r) = 
        try { 
            import java.util.LinkedList.addAll(##java.util.Collection): Bool \ r;
            let LinkedList(l1) = l;
            let Collection(c1) = c;
            addAll(l1, c1) |> Ok 
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
        


    pub def remove!(x: a, l: LinkedList[a, r]): Result[Bool, String] \  Write(r) with Marshal[a] =
        try {
            import java.util.LinkedList.remove(##java.lang.Object): Bool \ r; 
            let LinkedList(l1) = l;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(l1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def removeAll!(c: Collection[a, r], l: LinkedList[a, r]): Result[Bool, String] \  Write(r) with Marshal[a] =
        try {
            import java.util.LinkedList.removeAll(##java.util.Collection): Bool \ r; 
            let LinkedList(l1) = l;
            let Collection(c1) = c;
            removeAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def removeIf!(f: a -> Bool \ ef, l: LinkedList[a, r]): Result[Bool, String] \  {ef, Write(r)} with Marshal[a] =
        try {
            import java.util.LinkedList.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let LinkedList(l1) = l;            
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            (removeIf(l1, f1) as \  {ef, Write(r)}) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }



    pub def retainAll!(c: Collection[a, r], l: LinkedList[a, r]): Result[Bool, String] \  Write(r) with Marshal[a] =
        try {
            import java.util.LinkedList.retainAll(##java.util.Collection): Bool \ r; 
            let LinkedList(l1) = l;
            let Collection(c1) = c;
            retainAll(l1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def forEach(f: a -> Unit \ ef, l: LinkedList[a, r]): Result[Unit, String] \  {ef, Read(r)} with Marshal[a] =
        try {
            import java.util.LinkedList.forEach(##java.util.function.Consumer): Unit \ r; 
            let LinkedList(l1) = l;
            let f1 = Interop/Util/Function/Consumer.makeConsumer(f);
            forEach(l1, f1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def sort!(f: (a, a) -> Int32, l: LinkedList[a, r]): Result[Unit, String] \ Write(r) with Marshal[a] =
        let f1 = Interop/Util/Comparator.makeComparator(f);
        sortWithComparator!(f1, l)


    pub def sortWithComparator!(c: Comparator[a], l: LinkedList[a, r]): Result[Unit, String] \ Write(r) with Marshal[a] =
        try {
            import java.util.LinkedList.sort(##java.util.Comparator): Unit \ r; 
            let LinkedList(l1) = l;
            sort(l1, c) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def fromIterable[a: Type, t: Type -> Region -> Type, r: Region, r2: Region]
                        (r: Region[r2], t: t[a, r]): LinkedList[a, r2] \ { Read(r), Write(r2) } with Iterable[t], Marshal[a] =
        let als = new(r);
        let iter1 = Iterable.iterator(t);
        Iterator.forEach(x -> discard add!(x, als), iter1);
        als

    pub def fromFoldable(r: Region[r], t: t[a]): LinkedList[a, r] \ { Write(r) } with Foldable[t], Marshal[a] =
        let als = new(r);
        Foldable.forEach(x -> discard add!(x, als), t);
        als

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): LinkedList[a, r] \ { Write(r) } with Foldable[t] =
        let als = new(r);
        Foldable.forEach(x -> discard addWith!(x, ocast, als), t);
        als


    ///
    /// Returns an iterator over `l`.
    ///
    pub def iterator(l: LinkedList[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        toFlixIterator(Scoped.regionOf(l), Interop/Flix/Marshal.fromJavaObject, l)

    ///
    /// Returns an iterator over `l`.
    ///
    pub def toFlixIterator(r2: Region[r2], 
                            ocast: ##java.lang.Object -> a, 
                            l: LinkedList[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } =
        import java.util.LinkedList.iterator(): ##java.util.Iterator \ {r, r2} as iterator;
        let LinkedList(l1) = l;
        if (Object.isNull(l1))
            Iterator.new(r2)
        else 
            iterator(l1) 
                |> Interop/Util/IteratorZ.wrapHH(r2) 
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)



    ///
    /// Returns an iterator over `l`.
    ///
    pub def enumerator(l: LinkedList[a, r]): Iterator[(a, Int32), r] \ { Write(r) } with Marshal[a] =
        iterator(l) |> Iterator.enumerator


    pub def unfoldLinkedList(_: Region[r], f: s -> Option[(a, s)] \ ef, st: s): LinkedList[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.LinkedList(): ##java.util.LinkedList \ r as new1;
        import java.util.LinkedList.add(##java.lang.Object): Bool \ r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => LinkedList(acc)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())

    pub def foldLinkedList(f: (b, a) -> b \ ef, s: b, l: LinkedList[a, r]): b \ { Read(r), ef } with Marshal[a] =
        iterator(l) |> Iterator.foldLeft(f, s)

    pub def toFlixList(l: LinkedList[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        iterator(l) |> Iterator.toList

    pub def toFlixSet(l: LinkedList[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        let step = (acc, a) -> Set.insert(a, acc);
        iterator(l) |> Iterator.foldLeft(step, Set.empty())


    pub def toArray(r1: Region[r1], l: LinkedList[a, r2]): Array[a, r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        let len = size(l);
        if (len < 1) 
            [] @ r1
        else {
            let head = get(0, l);
            let aout = Array.new(r1, head, len);
            let step = (ix, a) -> {aout[ix] = a; ix+1};
            discard foldLinkedList(step, 0, l);
            aout
        }


}
