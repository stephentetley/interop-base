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
    pub enum MapZ[_k: Type, _v: Type, _r: Region](##java.util.Map)


    pub class ImpMapZ[t: Type -> Type -> Region -> Type] {
        pub def toMapZ[k: Type, v: Type, r: Region](m: t[k, v, r]): MapZ[k, v, r]
        pub def fromMapZ[k: Type, v: Type, r: Region](m: MapZ[k, v, r]): t[k, v, r]
    }



}

namespace Interop/Util/MapZ {

    use Interop/Util.MapZ;
    use Interop/Util.MapZ.{MapZ};
    use Interop/Util.MapEntry;
    use Interop/Util.MapEntry.{MapEntry};

    use Interop/Util.ImpMapZ;
    use Interop/Flix.Marshal;

    pub def getHH(m: MapZ[k, v, r]): ##java.util.Map = 
        let MapZ(m1) = m;
        m1


    pub def toMapHH[t: Type -> Type -> Region -> Type, k: Type, v: Type, r: Region](s: t[k, v, r]): ##java.util.Map with ImpMapZ[t] = 
        Interop/Util/ImpMapZ.toMapZ(s) |> getHH

    pub def hhToMap(prim: ##java.util.Map): Map[k, v] with Order[k], Marshal[k], Marshal[v] = 
        hhToMapWith(Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, prim)

    /// via entrySet and set iterator...
    pub def hhToMapWith(kcast: ##java.lang.Object -> k, vcast: ##java.lang.Object -> v, prim: ##java.util.Map): Map[k, v] with Order[k] = 
        let step = (acc, o) -> {
            let me = o as ##java.util.Map$Entry;
            let k = Interop/Util/MapEntry.hhToKeyWith(kcast, me);
            let v = Interop/Util/MapEntry.hhToValueWith(vcast, me);
            Map.insert(k, v, acc)
        };
        region r { 
            import java.util.Map.entrySet(): ##java.util.Set \ Write(r) as entrySet1;
            if (Object.isNull(prim))
                Map.empty()
            else 
                entrySet1(prim) |> Interop/Util/SetZ.hhToIterator(r, identity) |> Iterator.foldLeft(step, Map.empty())
        }


    pub def new(_: Region[r], prim: ##java.util.Map): MapZ[k, v, r] = MapZ(prim)

    pub def getRegionOf(_: MapZ[k, v, r]): Region[r] = () as Region[r]

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


    pub def foldMapZ(f: (b, (k, v)) -> b & ef, s: b, m: MapZ[k, v, r]): b \ { Read(r), ef} with Order[k], Marshal[k], Marshal[v] = 
        region r1 {
            let iter = iterator(r1, m);
            Iterator.foldLeft(f, s, iter)
        }
        


    pub def unfoldViaHashMap(_: Region[r], f: s -> Option[(k, v, s)] & ef, st: s): MapZ[k, v, r] \ { Write(r), ef } with Marshal[k], Marshal[v] =
        import new java.util.HashMap(): ##java.util.HashMap & r as newHashMap;
        import java.util.HashMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object & r as put; 
        def loop(st1, ac) = match f(st1) {
            case None            => MapZ(ac as ##java.util.Map)
            case Some(k, v, st2) => { discard put(ac, Interop/Flix/Marshal.toJavaObject(k), Interop/Flix/Marshal.toJavaObject(v)); loop(st2, ac) }
        };
        loop(st, newHashMap())

    pub def fromMapViaHashMap(r: Region[r], m: Map[k, v]): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let step = iter -> match Iterator.next(iter) {
            case Some(k, v)   => Some((k, v, iter))
            case None         => None
        };
        unfoldViaHashMap(r, step, Map.iterator(r, m))

    pub def toMap(m: MapZ[k, v, r]): Map[k, v] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] =
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        foldMapZ(step, Map.empty(), m)

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def iterator(r1: Region[r1], m: MapZ[k, v, r2]): Iterator[(k, v), r1] \ { Read(r2), Write(r1) } with Order[k], Marshal[k], Marshal[v] =
        iteratorWith(r1, Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, m)

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def iteratorWith(_r1: Region[r1], 
                            kcast: ##java.lang.Object -> k, 
                            vcast: ##java.lang.Object -> v, 
                            m: MapZ[k, v, r2]): Iterator[(k, v), r1] \ { Read(r2), Write(r1) } with Order[k], Marshal[k], Marshal[v] =
        import java.util.Map.entrySet(): ##java.util.Set & r2;
        import java.util.Set.iterator(): ##java.util.Iterator & (r2 and r1);
        import java.util.Iterator.hasNext(): Bool & r1;
        import java.util.Iterator.next(): ##java.lang.Object & r1;
        let set1 = entrySet(getHH(m));
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


    pub def fromListViaHashMap(r: Region[r], l: List[(k, v)]): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let step = xs -> match xs {
            case kv :: rs => let (k,v) = kv; Some((k, v, rs))
            case Nil      => None
        };
        unfoldViaHashMap(r, step, l)
    
    pub def toList(m: MapZ[k, v, r]): List[(k, v)] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] =
        let step = (k, entry) -> ks -> k(entry :: ks);
        foldMapZ(step, ks -> ks, m) |> f -> f(Nil)

}
