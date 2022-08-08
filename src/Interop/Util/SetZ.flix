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


}

namespace Interop/Util/SetZ {

    use Interop/Util.SetZ;
    use Interop/Util.SetZ.{SetZ};
    use Interop/Flix.Marshal;


    pub def getHH(m: SetZ[a, r]): ##java.util.Set = 
        let SetZ(m1) = m;
        m1



    pub def new(_: Region[r], prim: ##java.util.Set): SetZ[a, r] = SetZ(prim)

    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(r1: Region[r1], s: SetZ[a, r2]): Iterator[a, r1] \ { Read(r2), Read(r1) } with Marshal[a] =
        iteratorWith(r1, Interop/Flix/Marshal.fromJavaObject, s)

    ///
    /// Returns an iterator over `s`.
    ///
    pub def iteratorWith(r1: Region[r1], 
                            ocast: ##java.lang.Object -> a, 
                            s: SetZ[a, r2]): Iterator[a, r1] \ { Read(r2), Read(r1) } with Marshal[a] =
        import java.util.Set.iterator(): ##java.util.Iterator & (r2 and r1) as iterator1;
        let SetZ(s1) = s;
        Interop/Util/IteratorZ.new(r1, iterator1(s1)) |> Interop/Util/IteratorZ.iteratorWith(ocast)

    pub def foldSetZ(f: (b, a) -> b & ef, s: b, rs: SetZ[a, r]): b \ { Read(r), ef } with Marshal[a] =
        region r1 {
            let iter = iterator(r1, rs);
            Iterator.foldLeft(f, s, iter)
        }

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
