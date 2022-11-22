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

    instance Scoped[HashSet[a]] {
        pub def regionOf(_: HashSet[a, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpCollection[HashSet] {
        pub def toCollection(t: HashSet[a, r]): Collection[a, r] = 
            let HashSet(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): HashSet[a, r] = 
            let Collection(t1) = t;
            HashSet(t1 as ##java.util.HashSet) 
    }

    instance Interop/Util.ImpSetZ[HashSet] {
        pub def toSetZ(t: HashSet[a, r]): SetZ[a, r] = 
            let HashSet(t1) = t;
            SetZ(t1 as ##java.util.Set)

        pub def fromSetZ(t: SetZ[a, r]): HashSet[a, r] = 
            let SetZ(t1) = t;
            HashSet(t1 as ##java.util.HashSet) 
    }

}

namespace Interop/Util/HashSet {

    use Interop/Util.HashSet;
    use Interop/Util.HashSet.{HashSet};
    use Interop/Util.ImpSetZ;
    use Interop/Flix.Marshal;


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

    pub def add!(x: a, s: HashSet[a, r]): Bool \  Write(r) with Marshal[a] =
        import java.util.HashSet.add(##java.lang.Object): Bool \ r; 
        let HashSet(s1) = s;
        let x1 = Interop/Flix/Marshal.toJavaObject(x);
        add(s1, x1)

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, s: HashSet[a, r]): Bool \ { Write(r) } = 
        import java.util.HashSet.add(##java.lang.Object): Bool \ r;
        let HashSet(s1) = s;
        add(s1, ocast(x))

    pub def isEmpty(s: HashSet[a, r]): Bool \ Read(r) = 
        import java.util.HashSet.isEmpty(): Bool \ r;
        let HashSet(s1) = s;
        isEmpty(s1)

    pub def size(s: HashSet[a, r]): Int32 \ Read(r) = 
        import java.util.HashSet.size(): Int32 \ r;
        let HashSet(s1) = s;
        size(s1)

    pub def clear!(s: HashSet[a, r]): Unit \ Read(r) = 
        import java.util.HashSet.clear(): Unit \ r;
        let HashSet(s1) = s;
        clear(s1)


    pub def fromFoldable(r: Region[r], t: t[a]): HashSet[a, r] \ Write(r) with Foldable[t], Marshal[a] =
        let set1 = new(r);
        Foldable.forEach(x -> discard add!(x, set1), t);
        set1

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): HashSet[a, r] \ { Write(r) } with Foldable[t] =
        let set1 = new(r);
        Foldable.forEach(x -> discard addWith!(x, ocast, set1), t);
        set1

}
