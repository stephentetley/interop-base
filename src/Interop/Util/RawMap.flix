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
    /// Represents a Java Map.
    ///
    pub enum RawMap[_k: Type, _v: Type, _r: Region](##java.util.Map)


}

namespace Interop/Util/RawMap {

    use Interop/Util.RawMap;
    use Interop/Util.RawMap.{RawMap};
    use Interop/Flix.Marshal;

    pub enum MapEntry[_k: Type, _v: Type, _: Region](##java.util.Map$Entry)



    pub def getRawMap(m: RawMap[k, v, r]): ##java.util.Map = 
        let RawMap(m1) = m;
        m1

    pub def new(_: Region[r], prim: ##java.util.Map): RawMap[k, v, r] = RawMap(prim)

    pub def getRegionOf(_: RawMap[k, v, r]): Region[r] = () as Region[r]

    ///
    /// We don't need the inverse function `marshalMapEntry` because Java's API for building maps is `m.put(k, v)`
    /// so we never need to create a MapEntry.
    ///
    pub def unmarshalMapEntry(entry: MapEntry[k, v, r]): (k, v) \ Read(r) with Marshal[k], Marshal[v] =
        unmarshalMapEntryWith(Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, entry)

    pub def unmarshalMapEntryWith(kcast:  ##java.lang.Object -> k, 
                                    vcast: ##java.lang.Object -> v,
                                    entry: MapEntry[k, v, r]): (k, v) \ Read(r) with Marshal[k], Marshal[v] =
        import java.util.Map$Entry.getKey(): ##java.lang.Object & r;
        import java.util.Map$Entry.getValue(): ##java.lang.Object & r;
        let MapEntry(entry1) = entry;
        let k = getKey(entry1);
        let v = getValue(entry1);                
        let k1 = kcast(k);
        let v1 = vcast(v);
        (k1, v1)


    pub def foldRawMap(f: (b, (k, v)) -> b & ef, s: b, m: RawMap[k, v, r]): b \ { Read(r), ef} with Order[k], Marshal[k], Marshal[v] = 
        region r1 {
            let iter = iterator(r1, m);
            Iterator.foldLeft(f, s, iter)
        }
        


    pub def unfoldViaHashMap(_: Region[r], f: s -> Option[(k, v, s)] & ef, st: s): RawMap[k, v, r] \ { Write(r), ef } with Marshal[k], Marshal[v] =
        import new java.util.HashMap(): ##java.util.HashMap & r as newHashMap;
        import java.util.HashMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object & r as put; 
        def loop(st1, ac) = match f(st1) {
            case None            => RawMap(ac as ##java.util.Map)
            case Some(k, v, st2) => { discard put(ac, Interop/Flix/Marshal.toJavaObject(k), Interop/Flix/Marshal.toJavaObject(v)); loop(st2, ac) }
        };
        loop(st, newHashMap())

    pub def fromMapViaHashMap(r: Region[r], m: Map[k, v]): RawMap[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let step = iter -> match Iterator.next(iter) {
            case Some(k, v)   => Some((k, v, iter))
            case None         => None
        };
        unfoldViaHashMap(r, step, Map.iterator(r, m))

    pub def toMap(m: RawMap[k, v, r]): Map[k, v] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] =
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        foldRawMap(step, Map.empty(), m)

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def iterator(r1: Region[r1], m: RawMap[k, v, r2]): Iterator[(k, v), r1] \ { Read(r2), Write(r1) } with Order[k], Marshal[k], Marshal[v] =
        iteratorWith(r1, Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, m)

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def iteratorWith(_r1: Region[r1], 
                            kcast: ##java.lang.Object -> k, 
                            vcast: ##java.lang.Object -> v, 
                            m: RawMap[k, v, r2]): Iterator[(k, v), r1] \ { Read(r2), Write(r1) } with Order[k], Marshal[k], Marshal[v] =
        import java.util.Map.entrySet(): ##java.util.Set & r2;
        import java.util.Set.iterator(): ##java.util.Iterator & (r2 and r1);
        import java.util.Iterator.hasNext(): Bool & r1;
        import java.util.Iterator.next(): ##java.lang.Object & r1;
        let set1 = entrySet(getRawMap(m));
        let iter = iterator(set1);
        let isDone = () -> { 
            let ans = hasNext(iter);
            not ans
        };
        let getNext = () -> {
            let o = next(iter);
            unmarshalMapEntryWith(kcast, vcast, MapEntry(o as ##java.util.Map$Entry))
        };
        Iterator(isDone, getNext)


    pub def fromListViaHashMap(r: Region[r], l: List[(k, v)]): RawMap[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let step = xs -> match xs {
            case kv :: rs => let (k,v) = kv; Some((k, v, rs))
            case Nil      => None
        };
        unfoldViaHashMap(r, step, l)
    
    pub def toList(m: RawMap[k, v, r]): List[(k, v)] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] =
        let step = (k, entry) -> ks -> k(entry :: ks);
        foldRawMap(step, ks -> ks, m) |> f -> f(Nil)

}
