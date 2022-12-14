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

    ///
    /// Represents a Java HashSet.
    /// Class / Mutable
    ///
    pub enum HashSet[_a: Type, _r: Region](##java.util.HashSet)


    instance Newable[HashSet[a]] {
        pub def new(r: Region[r]): HashSet[a, r] \ Write(r) = Interop/Util/HashSet.new(r)
    }

    instance Interop/Util.ImpCollection[HashSet] {
        pub def toCollection(t: HashSet[a, r]): Collection[a, r] = 
            let HashSet(t1) = t;
            Collection(unsafe_cast t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): HashSet[a, r] = 
            let Collection(t1) = t;
            HashSet(unsafe_cast t1 as ##java.util.HashSet) 
    }

    instance Interop/Util.ImpSetZ[HashSet] {
        pub def toSetZ(t: HashSet[a, r]): SetZ[a, r] = 
            let HashSet(t1) = t;
            SetZ(unsafe_cast t1 as ##java.util.Set)

        pub def fromSetZ(t: SetZ[a, r]): HashSet[a, r] = 
            let SetZ(t1) = t;
            HashSet(unsafe_cast t1 as ##java.util.HashSet) 
    }

}

namespace Interop/Util/HashSet {

    use Interop/Util.HashSet
    use Interop/Util.HashSet.{HashSet}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.ImpSetZ
    use Interop/Flix.Marshal


    pub def getHH(s: HashSet[a, r]): ##java.util.HashSet = 
        let HashSet(s1) = s;
        s1

    pub def wrapHH(_: Region[r], prim: ##java.util.HashSet): HashSet[a, r] =
        HashSet(prim)

    ///
    /// Returns a new mutable HashSet.
    ///
    pub def new(_: Region[r]): HashSet[a, r] \ Write(r) =
        import new java.util.HashSet(): ##java.util.HashSet \ r as newHashSet;
        newHashSet() |> HashSet

    pub def toString(s: HashSet[a, r]): String \ Read(r) = 
        import java.util.HashSet.toString(): String \ r;
        let HashSet(s1) = s;
        toString(s1)

    pub def equals(s1: HashSet[a, r], s2: HashSet[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.HashSet.equals(##java.lang.Object): Bool \ r; 
        let HashSet(js1) = s1;
        let HashSet(js2) = s2;
        equals(js1, unsafe_cast js2 as ##java.lang.Object)


    pub def hashCode(s: HashSet[a, r]): Int32 \ Read(r) = 
        import java.util.HashSet.hashCode(): Int32 \ r;
        let HashSet(s1) = s;
        hashCode(s1)

    pub def isEmpty(s: HashSet[a, r]): Bool \ Read(r) = 
        import java.util.HashSet.isEmpty(): Bool \ r;
        let HashSet(s1) = s;
        isEmpty(s1)

    pub def size(s: HashSet[a, r]): Int32 \ Read(r) = 
        import java.util.HashSet.size(): Int32 \ r;
        let HashSet(s1) = s;
        size(s1)


    pub def add!(x: a, s: HashSet[a, r]): Bool \  Write(r) with Marshal[a] =
        import java.util.HashSet.add(##java.lang.Object): Bool \ r; 
        let HashSet(s1) = s;
        let x1 = Interop/Flix/Marshal.toJavaObject(x);
        add(s1, x1)

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, s: HashSet[a, r]): Bool \ { Write(r) } = 
        import java.util.HashSet.add(##java.lang.Object): Bool \ r;
        let HashSet(s1) = s;
        add(s1, ocast(x))


    pub def clear!(s: HashSet[a, r]): Unit \ Read(r) = 
        import java.util.HashSet.clear(): Unit \ r;
        let HashSet(s1) = s;
        clear(s1)

    /// Use Result - `s` could be null...
    pub def remove!(x: a, s: HashSet[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.HashSet.remove(##java.lang.Object): Bool \ r; 
            let HashSet(s1) = s;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(s1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
        

    pub def removeAll!(c: Collection[a, r], s: HashSet[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.HashSet.removeAll(##java.util.Collection): Bool \ r; 
            let HashSet(s1) = s;
            let Collection(c1) = c;
            removeAll(s1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    
    pub def removeIf!(f: a -> Bool \ ef, s: HashSet[a, r]): Result[String, Bool] \  {ef, Write(r)} with Marshal[a] =
        try {
            import java.util.HashSet.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let HashSet(s1) = s;        
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            (unsafe_cast removeIf(s1, f1) as _ \ {ef, Write(r)}) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def retainAll!(c: Collection[a, r], s: HashSet[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.HashSet.retainAll(##java.util.Collection): Bool \ r; 
            let HashSet(s1) = s;
            let Collection(c1) = c;
            retainAll(s1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def fromFoldable(r: Region[r], t: t[a]): HashSet[a, r] \ Write(r) with Foldable[t], Marshal[a] =
        let set1 = new(r);
        Foldable.forEach(x -> discard add!(x, set1), t);
        set1

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): HashSet[a, r] \ { Write(r) } with Foldable[t] =
        let set1 = new(r);
        Foldable.forEach(x -> discard addWith!(x, ocast, set1), t);
        set1

}
