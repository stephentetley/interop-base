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
    /// Represents a Java SortedMap.
    /// Interface
    ///
    pub enum SortedMap[_k: Type, _v: Type, _r: Region](##java.util.SortedMap)

    instance Scoped[SortedMap[k, v]] {
        pub def regionOf(_: SortedMap[k, v, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpMapZ[SortedMap] {
        pub def toMapZ(t: SortedMap[k, v, r]): MapZ[k, v, r] = 
            let SortedMap(t1) = t;
            MapZ(t1 as ##java.util.Map)

        pub def fromMapZ(t: MapZ[k, v, r]): SortedMap[k, v, r] = 
            let MapZ(t1) = t;
            SortedMap(t1 as ##java.util.SortedMap) 
    }


}

namespace Interop/Util/SortedMap {

    use Interop/Util.SortedMap;
    use Interop/Util.SortedMap.{SortedMap};
    use Interop/Util/Map.Entry;
    use Interop/Util/Map.Entry.{Entry};
    use Interop/Util.SetZ;
    use Interop/Util.SetZ.{SetZ};
    use Interop/Flix.Marshal;


    pub def getHH(m: SortedMap[k, v, r]): ##java.util.SortedMap = 
        let SortedMap(m1) = m;
        m1

    pub def wrapHH(_: Region[r], prim: ##java.util.SortedMap): SortedMap[k, v, r] \ Write(r) =
        SortedMap(prim) as \ Write(r)
        

    // pub def hhToMap(m: ##java.util.SortedMap): Map[k, v] with Order[k], Marshal[k], Marshal[v] = 
    //     hhToMapWith(Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, m)

    // /// via entrySet and set iterator...
    // pub def hhToMapWith(kcast: ##java.lang.Object -> k, vcast: ##java.lang.Object -> v, m: ##java.util.SortedMap): Map[k, v] with Order[k] = 
    //     region r { 
    //         import java.util.SortedMap.entrySet(): ##java.util.Set \ Write(r) as entrySet1;
    //         let step = (acc, o) -> {
    //             let entry = Interop/Util/Map/Entry.castObject(r, o);
    //             let (k, v) = Interop/Util/Map/Entry.toKeyValueWith(kcast, vcast, entry);
    //             Map.insert(k, v, acc)
    //         };
    //         if (Object.isNull(m))
    //             Map.empty()
    //         else {
    //             let s1 = entrySet1(m);
    //             Interop/Util/SetZ.hhToIterator(r, identity, s1) |> Iterator.foldLeft(step, Map.empty())
    //         }
    //     }


    /// Can't guaranteed `Ord[k]` at this point...
    pub def entrySet(m: SortedMap[k, v, r]): SetZ[Entry[k, v, r], r] \ {Write(r)}= 
        import java.util.SortedMap.entrySet(): ##java.util.Set \ Write(r);
        let SortedMap(m1) = m;
        let sz = entrySet(m1);
        SetZ(sz)




    pub def foldMap(f: (b, (k, v)) -> b & ef, s: b, m: SortedMap[k, v, r]): b \ { Read(r), ef} with Order[k], Marshal[k], Marshal[v] = 
        iterator(m) |> Iterator.foldLeft(f, s)

        


    pub def unfoldViaTreeMap(_: Region[r], f: s -> Option[(k, v, s)] & ef, st: s): SortedMap[k, v, r] \ { Write(r), ef } with Marshal[k], Marshal[v] =
        import new java.util.TreeMap(): ##java.util.TreeMap & r as newTreeMap;
        import java.util.TreeMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object & r as put; 
        def loop(st1, ac) = match f(st1) {
            case None            => SortedMap(ac as ##java.util.SortedMap)
            case Some(k, v, st2) => { discard put(ac, Interop/Flix/Marshal.toJavaObject(k), Interop/Flix/Marshal.toJavaObject(v)); loop(st2, ac) }
        };
        loop(st, newTreeMap())

    pub def fromMapViaTreeMap(r: Region[r], m: Map[k, v]): SortedMap[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let step = iter -> match Iterator.next(iter) {
            case Some(k, v)   => Some((k, v, iter))
            case None         => None
        };
        unfoldViaTreeMap(r, step, Map.iterator(r, m))


    ///
    /// Returns an iterator over all key-value pairs in `m`.
    ///
    pub def iterator(m: SortedMap[k, v, r]): Iterator[(k, v), r] \ { Write(r) } with Marshal[k], Marshal[v] =
        toIterator(Scoped.regionOf(m), Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, m)
    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def toIterator(r2: Region[r2],
                        kcast: ##java.lang.Object -> k, 
                        vcast: ##java.lang.Object -> v,  
                        m: SortedMap[k, v, r]): Iterator[(k, v), r2] \ { Read(r), Write(r2) } =
        import java.util.SortedMap.entrySet(): ##java.util.Set \ r;
        import java.util.Set.iterator(): ##java.util.Iterator \ {r, r2};
        import java.util.Iterator.hasNext(): Bool \ r2;
        import java.util.Iterator.next(): ##java.lang.Object \ r2;
        let set1 = entrySet(getHH(m));
        let iter = iterator(set1);
        let isDone = () -> { 
            let ans = hasNext(iter);
            not ans
        };
        let getNext = () -> {
            let entry = next(iter) |> Interop/Util/Map/Entry.castObject(r2);
            Interop/Util/Map/Entry.toKeyValueWith(kcast, vcast, entry)
        };
        Iterator(isDone, getNext)


    pub def fromListViaHashMap(r: Region[r], l: List[(k, v)]): SortedMap[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let step = xs -> match xs {
            case kv :: rs => let (k,v) = kv; Some((k, v, rs))
            case Nil      => None
        };
        unfoldViaTreeMap(r, step, l)
    
    
    pub def toFlixMap(m: SortedMap[k, v, r]): Map[k, v] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] =
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        iterator(m) |> Iterator.foldLeft(step, Map.empty())

    pub def toFlixList(m: SortedMap[k, v, r]): List[(k, v)] \ { Read(r) } with Marshal[k], Marshal[v] =
        iterator(m) |> Iterator.toList

}
