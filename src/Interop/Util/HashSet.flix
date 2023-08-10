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

    use Interop.Util.HashSet
    use Interop.Util.HashSet.{HashSet}
    
    use Interop.Lang.IterableZ
    use Interop.Lang.IterableZ.{IterableZ}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.SetZ
    use Interop.Util.SetZ.{SetZ}

    ///
    /// Represents a Java HashSet.
    /// Class / Mutable
    ///
    pub enum HashSet[_a: Type, r: Region] {
        case HashSet(Region[r], ##java.util.HashSet)
    }

    // instance Interop.Flix.ColMarshal[HashSet] {
    //     pub def colToJavaObject(x: HashSet[a, r]): ##java.lang.Object = 
    //         let HashSet(_, t1) = x;
    //         unchecked_cast(t1 as ##java.lang.Object)

    //     pub def colFromJavaObject(rc: Region[r], o: ##java.lang.Object): HashSet[a, r] = 
    //         HashSet(rc, unchecked_cast(o as ##java.util.HashSet))
    // }

    instance Interop.Util.ImpCollection[HashSet] {
        pub def toCollection(t: HashSet[a, r]): Collection[a, r] = 
            let HashSet(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): HashSet[a, r] = 
            let Collection(rc, t1) = t;
            HashSet(rc, unchecked_cast(t1 as ##java.util.HashSet))
    }

    instance Interop.Util.ImpSetZ[HashSet] {
        pub def toSetZ(t: HashSet[a, r]): SetZ[a, r] = 
            let HashSet(rc, t1) = t;
            SetZ(rc, unchecked_cast(t1 as ##java.util.Set))

        pub def fromSetZ(t: SetZ[a, r]): HashSet[a, r] = 
            let SetZ(rc, t1) = t;
            HashSet(rc, unchecked_cast(t1 as ##java.util.HashSet))
    }

    instance Interop.Lang.ImpIterable[HashSet] {
        pub def toIterable(t: HashSet[a, r]): IterableZ[a, r] = 
            let HashSet(rc, t1) = t;
            IterableZ(rc, unchecked_cast(t1 as ##java.lang.Iterable))

        pub def fromIterable(t: IterableZ[a, r]): HashSet[a, r] = 
            let IterableZ(rc, t1) = t;
            HashSet(rc, unchecked_cast(t1 as ##java.util.HashSet))
    }
}

mod Interop.Util.HashSet {

    use Interop.Util.HashSet
    use Interop.Util.HashSet.{HashSet}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.ImpSetZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava


    pub def getHH(s: HashSet[a, r]): ##java.util.HashSet = 
        let HashSet(_, s1) = s;
        s1

    pub def wrapHH(rc: Region[r], prim: ##java.util.HashSet): HashSet[a, r] =
        HashSet(rc, prim)

    ///
    /// Returns a new mutable HashSet.
    ///
    pub def new(rc: Region[r]): HashSet[a, r] \ r =
        import new java.util.HashSet(): ##java.util.HashSet \ r as newHashSet;
        HashSet(rc, newHashSet())

    pub def toString(s: HashSet[a, r]): String \ r = 
        import java.util.HashSet.toString(): String \ r;
        let HashSet(_, s1) = s;
        toString(s1)

    pub def equals(s1: HashSet[a, r], s2: HashSet[a, r]): Bool \ r =
        import java.util.HashSet.equals(##java.lang.Object): Bool \ r; 
        let HashSet(_, ss1) = s1;
        let HashSet(_, ss2) = s2;
        equals(ss1, checked_cast(ss2))


    pub def hashCode(s: HashSet[a, r]): Int32 \ r = 
        import java.util.HashSet.hashCode(): Int32 \ r;
        let HashSet(_, s1) = s;
        hashCode(s1)

    pub def isEmpty(s: HashSet[a, r]): Bool \ r = 
        import java.util.HashSet.isEmpty(): Bool \ r;
        let HashSet(_, s1) = s;
        isEmpty(s1)

    pub def size(s: HashSet[a, r]): Int32 \ r = 
        import java.util.HashSet.size(): Int32 \ r;
        let HashSet(_, s1) = s;
        size(s1)


    pub def add!(x: a, s: HashSet[a, r]): Bool \ r with GoesToJava[a] =
        import java.util.HashSet.add(##java.lang.Object): Bool \ r; 
        let HashSet(_, s1) = s;
        let x1 = Interop.Flix.GoesToJava.toJavaObject(x);
        add(s1, x1)

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, s: HashSet[a, r]): Bool \ { r } = 
        import java.util.HashSet.add(##java.lang.Object): Bool \ r;
        let HashSet(_, s1) = s;
        add(s1, ocast(x))


    pub def clear!(s: HashSet[a, r]): Unit \ r = 
        import java.util.HashSet.clear(): Unit \ r;
        let HashSet(_, s1) = s;
        clear(s1)

    /// Use Result - `s` could be null...
    pub def remove!(x: a, s: HashSet[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.HashSet.remove(##java.lang.Object): Bool \ r; 
            let HashSet(_, s1) = s;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            remove(s1, x1)
        })

    pub def removeAll!(c: Collection[a, r1], s: HashSet[a, r]): Result[String, Bool] \ {r, r1} with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.HashSet.removeAll(##java.util.Collection): Bool \ {r, r1}; 
            let HashSet(_, s1) = s;
            let Collection(_, c1) = c;
            removeAll(s1, c1)
        })

    
    pub def removeIf![a: Type, ef: Eff, r: Region]
                        (f: a -> Bool \ ef, s: HashSet[a, r]): Result[String, Bool] \  {ef, r} with ComesFromJava[a] =
        Result.tryCatch(_ -> {
            import java.util.HashSet.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let HashSet(_, s1) = s;
            let PredicateZ(f1) = Interop.Util.Function.PredicateZ.makePredicateZ(f);
            unchecked_cast(removeIf(s1, f1) as _ \ {ef, r})
        })

    pub def retainAll!(c: Collection[a, r1], s: HashSet[a, r]): Result[String, Bool] \ {r, r1} =
        Result.tryCatch(_ -> {
            import java.util.HashSet.retainAll(##java.util.Collection): Bool \ {r, r1}; 
            let HashSet(_, s1) = s;
            let Collection(_, c1) = c;
            retainAll(s1, c1)
        })

    pub def fromFoldable(r: Region[r], t: t[a]): HashSet[a, r] \ r with Foldable[t], GoesToJava[a] =
        let set1 = new(r);
        Foldable.forEach(x -> discard add!(x, set1), t);
        set1

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): HashSet[a, r] \ { r } with Foldable[t] =
        let set1 = new(r);
        Foldable.forEach(x -> discard addWith!(x, ocast, set1), t);
        set1
    

    pub def toFlixIterator(rc: Region[r1], 
                            fromJava: ##java.lang.Object -> a,
                            s: HashSet[a, r]): Iterator[a, r1, r1] \ r =
        Interop.Util.SetZ.toFlixIterator(rc, fromJava, ImpSetZ.toSetZ(s))

    pub def toFlixList(fromJava: ##java.lang.Object -> a, l: HashSet[a, r]): List[a] \ r = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toList
    }

    pub def toFlixSet(fromJava: ##java.lang.Object -> a, l: HashSet[a, r]): Set[a] \ r with Order[a] = region rc {
        toFlixIterator(rc, fromJava, l) |> Iterator.toSet
    }

}
