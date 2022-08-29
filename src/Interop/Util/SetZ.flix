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
    /// Represents a Java Set.
    /// Interface
    ///
    pub enum SetZ[_a: Type, _r: Region](##java.util.Set)

    pub class ImpSetZ[t: Type -> Region -> Type] {
        pub def toSetZ[a: Type, r: Region](s: t[a, r]): SetZ[a, r]
        pub def fromSetZ[a: Type, r: Region](s: SetZ[a, r]): t[a, r]
    }


    instance Scoped[SetZ[a]] {
        pub def regionOf(_: SetZ[a, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpCollection[SetZ] {
        pub def toCollection(t: SetZ[a, r]): Collection[a, r] = 
            let SetZ(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): SetZ[a, r] = 
            let Collection(t1) = t;
            SetZ(t1 as ##java.util.Set) 
    }


}

namespace Interop/Util/SetZ {

    use Interop/Util.SetZ;
    use Interop/Util.SetZ.{SetZ};
    use Interop/Util.ImpSetZ;
    use Interop/Flix.Marshal;


    pub def getHH(m: SetZ[a, r]): ##java.util.Set = 
        let SetZ(m1) = m;
        m1
        
    pub def wrapHH(_: Region[r], prim: ##java.util.Set): SetZ[a, r] \ Write(r) = 
        SetZ(prim) as \ Write(r)


    pub def toSetHH[t: Type -> Region -> Type, a: Type, r: Region](s: t[a, r]): ##java.util.Set with ImpSetZ[t] = 
        Interop/Util/ImpSetZ.toSetZ(s) |> getHH


    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(s: SetZ[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        toFlixIterator(Scoped.regionOf(s), Interop/Flix/Marshal.fromJavaObject, s)


    pub def foldSetZ(f: (b, a) -> b & ef, st: b, s: SetZ[a, r]): b \ { Read(r), ef } with Marshal[a] =
        let iter = iterator(s);
        Iterator.foldLeft(f, st, iter)
        

    pub def unfoldViaHashSet(_: Region[r], f: s -> Option[(a, s)] & ef, st: s): SetZ[a, r] \ { Write(r), ef } with Marshal[a] =
        import new java.util.HashSet(): ##java.util.HashSet & r as newHashSet;
        import java.util.HashSet.add(##java.lang.Object): Bool & r as put; 
        def loop(st1, ac) = match f(st1) {
            case None           => SetZ(ac as ##java.util.Set)
            case Some((a, st2)) => { discard put(ac, Interop/Flix/Marshal.toJavaObject(a)); loop(st2, ac) }
        };
        loop(st, newHashSet())


    pub def fromSetViaHashSet(_: Region[r], s: Set[a]): SetZ[a, r] \ { Write(r) } with Order[a], Marshal[a] =
        import new java.util.HashSet(): ##java.util.HashSet & r as newHashSet;
        import java.util.HashSet.add(##java.lang.Object): Bool & r as put;
        let s1 = newHashSet();
        Set.foreach(a -> discard put(s1, Interop/Flix/Marshal.toJavaObject(a)), s);
        SetZ(s1 as ##java.util.Set)


    /// Shouldn't need Order instance in Flix but must be hashable in Java...
    pub def fromListViaHashSet(r: Region[r], l: List[a]): SetZ[a, r] \ { Write(r) } with Marshal[a] =
        let step = st -> match st {
            case a :: rs => Some((a, rs))
            case Nil     => None
        };
        unfoldViaHashSet(r, step, l)

    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(r2: Region[r2], 
                            ocast: ##java.lang.Object -> a, 
                            s: SetZ[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } =
        import java.util.Set.iterator(): ##java.util.Iterator \ Write(r);
        let SetZ(s1) = s;
        if (Object.isNull(s1))
            Iterator.new(r2)
        else 
            iterator(s1) 
                |> Interop/Util/IteratorZ.wrapHH(r2)
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)

    pub def toFlixSet(s: SetZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, s) |> Iterator.toSet
        }

    pub def toFlixList(s: SetZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, s) |> Iterator.toList
        }

}
