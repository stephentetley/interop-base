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

    use Interop.Util.SortedMap
    use Interop.Util.SortedMap.{SortedMap}
    use Interop.Util.MapZ
    use Interop.Util.MapZ.{MapZ}

    ///
    /// Represents a Java SortedMap.
    /// Interface
    ///
    pub enum SortedMap[_k: Type, _v: Type, r: Region] { 
        case SortedMap(Region[r], ##java.util.SortedMap)
    }


    instance Interop.Util.ImpMapZ[SortedMap] {
        pub def toMapZ(t: SortedMap[k, v, r]): MapZ[k, v, r] = 
            let SortedMap(rc, t1) = t;
            MapZ(rc, unchecked_cast(t1 as ##java.util.Map))

        pub def fromMapZ(t: MapZ[k, v, r]): SortedMap[k, v, r] = 
            let MapZ(rc, t1) = t;
            SortedMap(rc, unchecked_cast(t1 as ##java.util.SortedMap))
    }


}

mod Interop.Util.SortedMap {

    use Interop.Util.SortedMap
    use Interop.Util.SortedMap.{SortedMap}
    use Interop.Util.MapEntry
    use Interop.Util.MapEntry.{MapEntry}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.SetZ
    use Interop.Util.SetZ.{SetZ}
    use Interop.Flix.GoesToJava


    pub def getHH(m: SortedMap[k, v, r]): ##java.util.SortedMap = 
        let SortedMap(_, m1) = m;
        m1

    pub def wrapHH(rc: Region[r], prim: ##java.util.SortedMap): SortedMap[k, v, r] =
        SortedMap(rc, prim)
        

    pub def equals(m1: SortedMap[k, v, r], m2: SortedMap[k, v, r]): Bool \ r =
        import java.util.SortedMap.equals(##java.lang.Object): Bool \ r; 
        let SortedMap(_, mm1) = m1;
        let SortedMap(_, mm2) = m2;
        equals(mm1, checked_cast(mm2))

    pub def size(m: SortedMap[k, v, r]): Int32 \ r =
        import java.util.SortedMap.size(): Int32 \ r;
        let SortedMap(_, m1) = m;
        size(m1)

    pub def isEmpty(m: SortedMap[k, v, r]): Bool \ r =
        import java.util.SortedMap.isEmpty(): Bool \ r;
        let SortedMap(_, m1) = m;
        isEmpty(m1)

    pub def hashCode(m: SortedMap[k, v, r]): Int32 \ r =
        import java.util.SortedMap.hashCode(): Int32 \ r;
        let SortedMap(_, m1) = m;
        hashCode(m1)

    /// Gets a `v1` not a `v` !
    pub def get(getterVal: ##java.lang.Object -> v1 \ ef, k: k, m: SortedMap[k, v, r]): Result[String, Option[v1]] \ {ef, r} with GoesToJava[k] =
        Result.tryCatch(_ -> {
            import java.util.SortedMap.get(##java.lang.Object): ##java.lang.Object \ {ef, r}; 
            let SortedMap(_, m1) = m;
            let k1 = Interop.Flix.GoesToJava.toJavaObject(k);
            get(m1, k1) |> Object.toOption |> Option.map(getterVal)
        })

    pub def put!(getterVal: ##java.lang.Object -> v1 \ ef, k: k, v: v, m: SortedMap[k, v, r]): Result[String, v1] \ {ef, r} with GoesToJava[k], GoesToJava[v] =
        Result.tryCatch(_ -> {
            import java.util.SortedMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ {ef, r}; 
            let SortedMap(_, m1) = m;
            let k1 = Interop.Flix.GoesToJava.toJavaObject(k);
            let v1 = Interop.Flix.GoesToJava.toJavaObject(v);
            put(m1, k1, v1) |> getterVal
        })

    /// Can't guarantee `Ord[k]` at this point...
    pub def entrySet(rc: Region[r1], m: SortedMap[k, v, r]): SetZ[MapEntry[k, v, r1], r1] \ { r, r1 } = 
        import java.util.SortedMap.entrySet(): ##java.util.Set \ { r, r1 };
        let SortedMap(_, m1) = m;
        let sz = entrySet(m1);
        SetZ(rc, sz)


    pub def values(rc: Region[r1], m: SortedMap[k, v, r]): Collection[k, r1] \ { r, r1 } = 
        import java.util.SortedMap.values(): ##java.util.Collection \ { r, r1 };
        let SortedMap(_, m1) = m;
        Collection(rc, values(m1))



    pub def unfoldViaTreeMap(rc: Region[r], 
                                f: s -> Option[(k, v, s)] \ ef, 
                                st: s): SortedMap[k, v, r] \ { r, ef } with GoesToJava[k], GoesToJava[v] =
        import java_new java.util.TreeMap(): ##java.util.TreeMap \ r as newTreeMap;
        import java.util.TreeMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r as put; 
        def loop(st1, ac) = match f(st1) {
            case None            => SortedMap(rc, unchecked_cast(ac as ##java.util.SortedMap))
            case Some(k, v, st2) => { discard put(ac, Interop.Flix.GoesToJava.toJavaObject(k), Interop.Flix.GoesToJava.toJavaObject(v)); loop(st2, ac) }
        };
        loop(st, newTreeMap())


    /// TODO - remove and add TreeMap module...
    pub def fromMapViaTreeMap(r: Region[r], m: Map[k, v]): SortedMap[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        let step = iter -> match Iterator.next(iter) {
            case Some(k, v)   => Some((k, v, iter))
            case None         => None
        };
        unfoldViaTreeMap(r, step, Map.iterator(r, m))


    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def toFlixIterator(rc: Region[r1],
                            getterKey: ##java.lang.Object -> k1 \ ef1, 
                            getterVal: ##java.lang.Object -> v1 \ ef2,  
                            m: SortedMap[k, v, r]): Iterator[(k1, v1), ef1 + ef2 + r1, r1] \ r =
        import java.util.SortedMap.entrySet(): ##java.util.Set \ r;
        import java.util.Set.iterator(): ##java.util.Iterator \ r;
        import java.util.Iterator.hasNext(): Bool \ r1;
        import java.util.Iterator.next(): ##java.lang.Object \ r1;
        let set1 = entrySet(getHH(m));
        let iter = iterator(set1);
        let getNext = () -> match hasNext(iter) {
            case true  => {
                let entry = next(iter) |> Interop.Util.MapEntry.castObject(rc);
                Interop.Util.MapEntry.toKeyValue(getterKey, getterVal, entry) |> Some
            }
            case false => None
        };
        Iterator.iterate(rc, getNext)

    
    
    pub def toFlixMap(getterKey: ##java.lang.Object -> k1 \ ef1, 
                        getterVal: ##java.lang.Object -> v1 \ ef2, 
                        m: SortedMap[k, v, r]): Map[k1, v1] \ {ef1, ef2, r} with Order[k1] = region rc {
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        toFlixIterator(rc, getterKey, getterVal, m) |> Iterator.foldLeft(step, Map.empty())
    }

    pub def toFlixList(getterKey: ##java.lang.Object -> k1 \ ef1, 
                        getterVal: ##java.lang.Object -> v1 \ ef2, 
                        m: SortedMap[k, v, r]): List[(k1, v1)] \ {ef1, ef2, r} = region rc {
        toFlixIterator(rc, getterKey, getterVal, m) |> Iterator.toList
    }

}
