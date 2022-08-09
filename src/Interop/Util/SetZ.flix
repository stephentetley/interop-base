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
    ///
    pub enum SetZ[_a: Type, _r: Region](##java.util.Set)

    instance Scoped[SetZ[a]] {
        pub def regionOf(_: SetZ[a, r]): Region[r] = () as Region[r]
    }

}

namespace Interop/Util/SetZ {

    use Interop/Util.SetZ;
    use Interop/Util.SetZ.{SetZ};
    use Interop/Flix.Marshal;


    pub def getHH(m: SetZ[a, r]): ##java.util.Set = 
        let SetZ(m1) = m;
        m1

    /// via entrySet and set iterator...
    /// cast must be Pure
    pub def hhToSet(ocast: ##java.lang.Object -> a, s: ##java.util.Set): Set[a] with Order[a] = 
        region r { 
            let iter = hhToIterator(r, ocast, s);
            Iterator.toSet(iter)
        }

    pub def hhToIterator(r: Region[r], ocast: ##java.lang.Object -> a, s: ##java.util.Set): Iterator[a, r] \ { Write(r) } =
        import java.util.Set.iterator(): ##java.util.Iterator \ Write(r) as iterator;
        Interop/Util/IteratorZ.hhToIterator(r, ocast, iterator(s))



    pub def new(_: Region[r], prim: ##java.util.Set): SetZ[a, r] = SetZ(prim)

    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(s: SetZ[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        iteratorWith(Interop/Flix/Marshal.fromJavaObject, s)

    ///
    /// Returns an iterator over `s`.
    ///
    pub def iteratorWith(ocast: ##java.lang.Object -> a, 
                            s: SetZ[a, r]): Iterator[a, r] \ { Write(r) } =
        import java.util.Set.iterator(): ##java.util.Iterator \ Write(r) as iterator;
        let SetZ(s1) = s;
        let r = Scoped.regionOf(s);
        Interop/Util/IteratorZ.hhToIterator(r, ocast, iterator(s1))




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

    pub def toSet(rs: SetZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        let step = (acc, a) -> Set.insert(a, acc);
        foldSetZ(step, Set.empty(), rs)

    /// Shouldn't need Order instance in Flix but must be hashable in Java...
    pub def fromListViaHashSet(r: Region[r], l: List[a]): SetZ[a, r] \ { Write(r) } with Marshal[a] =
        let step = st -> match st {
            case a :: rs => Some((a, rs))
            case Nil     => None
        };
        unfoldViaHashSet(r, step, l)


    pub def toList(rs: SetZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        let step = (k, a) -> ks -> k(a :: ks);
        foldSetZ(step, ks -> ks, rs) |> f -> f(Nil)

}
