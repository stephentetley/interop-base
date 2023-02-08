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


    instance Interop/Util.ImpMapZ[SortedMap] {
        pub def toMapZ(t: SortedMap[k, v, r]): MapZ[k, v, r] = 
            let SortedMap(t1) = t;
            MapZ(unsafe_cast t1 as ##java.util.Map)

        pub def fromMapZ(t: MapZ[k, v, r]): SortedMap[k, v, r] = 
            let MapZ(t1) = t;
            SortedMap(unsafe_cast t1 as ##java.util.SortedMap) 
    }


}

namespace Interop/Util/SortedMap {

    use Interop/Util.SortedMap
    use Interop/Util.SortedMap.{SortedMap}
    use Interop/Util/Map.Entry
    use Interop/Util/Map.Entry.{Entry}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.SetZ
    use Interop/Util.SetZ.{SetZ}
    use Interop/Flix.Marshal


    pub def getHH(m: SortedMap[k, v, r]): ##java.util.SortedMap = 
        let SortedMap(m1) = m;
        m1

    pub def wrapHH(_: Region[r], prim: ##java.util.SortedMap): SortedMap[k, v, r] =
        SortedMap(prim)
        

    pub def equals(m1: SortedMap[k, v, r], m2: SortedMap[k, v, r]): Bool \ Read(r) =
        import java.util.SortedMap.equals(##java.lang.Object): Bool \ r; 
        let SortedMap(jm1) = m1;
        let SortedMap(jm2) = m2;
        equals(jm1, unsafe_cast jm2 as ##java.lang.Object)

    pub def size(m: SortedMap[k, v, r]): Int32 \ Read(r) =
        import java.util.SortedMap.size(): Int32 \ r;
        let SortedMap(m1) = m;
        size(m1)

    pub def isEmpty(m: SortedMap[k, v, r]): Bool \ Read(r) =
        import java.util.SortedMap.isEmpty(): Bool \ r;
        let SortedMap(m1) = m;
        isEmpty(m1)

    pub def hashCode(m: SortedMap[k, v, r]): Int32 \ Read(r) =
        import java.util.SortedMap.hashCode(): Int32 \ r;
        let SortedMap(m1) = m;
        hashCode(m1)

    pub def get(k: k, m: SortedMap[k, v, r]): Result[String, Option[v]] \ Write(r) with Marshal[k], Marshal[v] =
        try {
            import java.util.SortedMap.get(##java.lang.Object): ##java.lang.Object \ r; 
            let SortedMap(m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);
            get(m1, k1) |> Object.toOption |> Option.map(Interop/Flix/Marshal.fromJavaObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def put!(k: k, v: v, m: SortedMap[k, v, r]): v \ Write(r) with Marshal[k], Marshal[v] =
        import java.util.SortedMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
        let SortedMap(m1) = m;
        let k1 = Interop/Flix/Marshal.toJavaObject(k);
        let v1 = Interop/Flix/Marshal.toJavaObject(v);
        put(m1, k1, v1) |> Interop/Flix/Marshal.fromJavaObject

    /// Can't guarantee `Ord[k]` at this point...
    pub def entrySet(_: Region[rh], m: SortedMap[k, v, r]): SetZ[Entry[k, v, rh], rh] \ { Read(r), Write(rh) } = 
        import java.util.SortedMap.entrySet(): ##java.util.Set \ { Read(r), Write(rh) };
        let SortedMap(m1) = m;
        let sz = entrySet(m1);
        SetZ(sz)


    pub def values(_: Region[rh], m: SortedMap[k, v, r]): Collection[k, rh] \ { Read(r), Write(rh) } = 
        import java.util.SortedMap.values(): ##java.util.Collection \ { Read(r), Write(rh) };
        let SortedMap(m1) = m;
        values(m1) |> Collection


    pub def foldMap(f: (b, (k, v)) -> b & ef, s: b, m: SortedMap[k, v, r]): b \ { Read(r), ef} with Order[k], Marshal[k], Marshal[v] = region r {
        iterator(r, m) |> Iterator.foldLeft(f, s)
    }
        


    pub def unfoldViaTreeMap(_: Region[r], f: s -> Option[(k, v, s)] & ef, st: s): SortedMap[k, v, r] \ { Write(r), ef } with Marshal[k], Marshal[v] =
        import new java.util.TreeMap(): ##java.util.TreeMap & r as newTreeMap;
        import java.util.TreeMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object & r as put; 
        def loop(st1, ac) = match f(st1) {
            case None            => SortedMap(unsafe_cast ac as ##java.util.SortedMap)
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
    pub def iterator(rc: Region[r1], m: SortedMap[k, v, r]): Iterator[(k, v), r1, r1] \ { Read(r) } with Marshal[k], Marshal[v] =
        toIterator(rc, Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, m)

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def toIterator(rc: Region[r1],
                        kcast: ##java.lang.Object -> k, 
                        vcast: ##java.lang.Object -> v,  
                        m: SortedMap[k, v, r]): Iterator[(k, v), r1, r1] \ { Read(r) } =
        import java.util.SortedMap.entrySet(): ##java.util.Set \ r;
        import java.util.Set.iterator(): ##java.util.Iterator \ r;
        import java.util.Iterator.hasNext(): Bool \ r1;
        import java.util.Iterator.next(): ##java.lang.Object \ r1;
        let set1 = entrySet(getHH(m));
        let iter = iterator(set1);
        let getNext = () -> match hasNext(iter) {
            case true  => {
                let entry = next(iter) |> Interop/Util/Map/Entry.castObject(rc);
                Interop/Util/Map/Entry.toKeyValueWith(kcast, vcast, entry) |> Some
            }
            case false => None
        };
        Iterator.iterate(rc, getNext)

    
    
    pub def toFlixMap(m: SortedMap[k, v, r]): Map[k, v] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] = region r {
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        iterator(r, m) |> Iterator.foldLeft(step, Map.empty())
    }

    pub def toFlixList(m: SortedMap[k, v, r]): List[(k, v)] \ { Read(r) } with Marshal[k], Marshal[v] = region r {
        iterator(r, m) |> Iterator.toList
    }

}
