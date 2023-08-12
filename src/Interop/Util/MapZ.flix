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

    ///
    /// Represents a Java Map.
    /// Iterface / Mutable (some implementations may not be mutable)
    ///
    pub enum MapZ[_k: Type, _v: Type, r: Region]{ 
        case MapZ(Region[r], ##java.util.Map)
    }


    pub class ImpMapZ[t: Type -> Type -> Region -> Type] {
        pub def toMapZ(m: t[k, v, r]): MapZ[k, v, r]
        pub def fromMapZ(m: MapZ[k, v, r]): t[k, v, r]

        pub def toMapHH(m: t[k, v, r]): ##java.util.Map = 
            ImpMapZ.toMapZ(m) |> Interop.Util.MapZ.getHH

    }



}

mod Interop.Util.MapZ {

    use Interop.Util.MapZ
    use Interop.Util.MapZ.{MapZ}
    use Interop.Util.MapEntry
    use Interop.Util.MapEntry.{MapEntry}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.SetZ
    use Interop.Util.SetZ.{SetZ}
    use Interop.Util.ImpMapZ
    use Interop.Util.Function.BiConsumer
    use Interop.Util.Function.BiConsumer.{BiConsumer}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava

    pub def getHH(m: MapZ[k, v, r]): ##java.util.Map = 
        let MapZ(_, m1) = m;
        m1


    pub def wrapHH(rc: Region[r], prim: ##java.util.Map): MapZ[k, v, r] =
        MapZ(rc, prim)




    pub def of0(rc: Region[r]): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        import static java.util.Map.of(): ##java.util.Map \ r;
        MapZ(rc, of())

    pub def of1(rc: Region[r], k1: k, v1: v): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop.Flix.GoesToJava.toJavaObject(k1);
        let vo1 = Interop.Flix.GoesToJava.toJavaObject(v1);
        MapZ(rc, of(ko1, vo1))

    pub def of2(rc: Region[r], k1: k, v1: v, k2: k, v2: v): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop.Flix.GoesToJava.toJavaObject(k1);
        let vo1 = Interop.Flix.GoesToJava.toJavaObject(v1);
        let ko2 = Interop.Flix.GoesToJava.toJavaObject(k2);
        let vo2 = Interop.Flix.GoesToJava.toJavaObject(v2);
        MapZ(rc, of(ko1, vo1, ko2, vo2))


    pub def of3(rc: Region[r], k1: k, v1: v, k2: k, v2: v, k3: k, v3: v): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop.Flix.GoesToJava.toJavaObject(k1);
        let vo1 = Interop.Flix.GoesToJava.toJavaObject(v1);
        let ko2 = Interop.Flix.GoesToJava.toJavaObject(k2);
        let vo2 = Interop.Flix.GoesToJava.toJavaObject(v2);
        let ko3 = Interop.Flix.GoesToJava.toJavaObject(k3);
        let vo3 = Interop.Flix.GoesToJava.toJavaObject(v3);
        MapZ(rc, of(ko1, vo1, ko2, vo2, ko3, vo3))

    pub def of4(rc: Region[r], k1: k, v1: v, k2: k, v2: v, k3: k, v3: v, k4: k, v4: v): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, 
                                        ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop.Flix.GoesToJava.toJavaObject(k1);
        let vo1 = Interop.Flix.GoesToJava.toJavaObject(v1);
        let ko2 = Interop.Flix.GoesToJava.toJavaObject(k2);
        let vo2 = Interop.Flix.GoesToJava.toJavaObject(v2);
        let ko3 = Interop.Flix.GoesToJava.toJavaObject(k3);
        let vo3 = Interop.Flix.GoesToJava.toJavaObject(v3);
        let ko4 = Interop.Flix.GoesToJava.toJavaObject(k4);
        let vo4 = Interop.Flix.GoesToJava.toJavaObject(v4);
        MapZ(rc, of(ko1, vo1, ko2, vo2, ko3, vo3, ko4, vo4))

    pub def of5(rc: Region[r], k1: k, v1: v, k2: k, v2: v, k3: k, v3: v, k4: k, v4: v, k5: k, v5: v): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, 
                                        ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop.Flix.GoesToJava.toJavaObject(k1);
        let vo1 = Interop.Flix.GoesToJava.toJavaObject(v1);
        let ko2 = Interop.Flix.GoesToJava.toJavaObject(k2);
        let vo2 = Interop.Flix.GoesToJava.toJavaObject(v2);
        let ko3 = Interop.Flix.GoesToJava.toJavaObject(k3);
        let vo3 = Interop.Flix.GoesToJava.toJavaObject(v3);
        let ko4 = Interop.Flix.GoesToJava.toJavaObject(k4);
        let vo4 = Interop.Flix.GoesToJava.toJavaObject(v4);
        let ko5 = Interop.Flix.GoesToJava.toJavaObject(k5);
        let vo5 = Interop.Flix.GoesToJava.toJavaObject(v5);
        MapZ(rc, of(ko1, vo1, ko2, vo2, ko3, vo3, ko4, vo4, ko5, vo5))


    pub def equals(m1: MapZ[k, v, r], m2: MapZ[k, v, r]): Bool \ r =
        import java.util.Map.equals(##java.lang.Object): Bool \ r; 
        let MapZ(_, mm1) = m1;
        let MapZ(_, mm2) = m2;
        equals(mm1, checked_cast(mm2))

    pub def size(m: MapZ[k, v, r]): Int32 \ r =
        import java.util.Map.size(): Int32 \ r;
        let MapZ(_, m1) = m;
        size(m1)

    pub def isEmpty(m: MapZ[k, v, r]): Bool \ r =
        import java.util.Map.isEmpty(): Bool \ r;
        let MapZ(_, m1) = m;
        isEmpty(m1)

    pub def hashCode(m: MapZ[k, v, r]): Int32 \ r =
        import java.util.Map.hashCode(): Int32 \ r;
        let MapZ(_, m1) = m;
        hashCode(m1)

    pub def clear!(m: MapZ[k, v, r]): Unit \ r =
        import java.util.Map.clear(): Unit \ r; 
        let MapZ(_, m1) = m;
        clear(m1)

    /// Gets a `v1` not a `v`!
    pub def get(getterVal: ##java.lang.Object -> v1 \ ef, k: k, m: MapZ[k, v, r]): Result[String, Option[v1]] \ {ef, r} with GoesToJava[k] =
        Result.tryCatch(_ -> {
            import java.util.Map.get(##java.lang.Object): ##java.lang.Object \ {ef, r}; 
            let MapZ(_, m1) = m;
            let k1 = Interop.Flix.GoesToJava.toJavaObject(k);
            get(m1, k1) |> Object.toOption |> Option.map(getterVal)
        })

    pub def put!(getterVal: ##java.lang.Object -> v1 \ ef, k: k, v: v, m: MapZ[k, v, r]): Result[String, Option[v1]] \ {ef, r} with GoesToJava[k], GoesToJava[v] =
        Result.tryCatch(_ -> {
            import java.util.Map.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
            let MapZ(_, m1) = m;
            let k1 = Interop.Flix.GoesToJava.toJavaObject(k);
            let v1 = Interop.Flix.GoesToJava.toJavaObject(v);
            put(m1, k1, v1) |> Object.toOption |> Option.map(getterVal)
        })

    pub def containsKey(k: k, m: MapZ[k, v, r]): Result[String, Bool] \ r with GoesToJava[k] =
        Result.tryCatch(_ -> {
            import java.util.Map.containsKey(##java.lang.Object): Bool \ r; 
            let MapZ(_, m1) = m;
            let k1 = Interop.Flix.GoesToJava.toJavaObject(k);
            containsKey(m1, k1)
        })

    pub def containsValue(v: v, m: MapZ[k, v, r]): Result[String, Bool] \ r with GoesToJava[v] =
        Result.tryCatch(_ -> {
            import java.util.Map.containsValue(##java.lang.Object): Bool \ r; 
            let MapZ(_, m1) = m;
            let v1 = Interop.Flix.GoesToJava.toJavaObject(v);
            containsValue(m1, v1)
        })

    /// Can't guarantee `Ord[k]` at this point...
    pub def entrySet(rc: Region[r1], m: MapZ[k, v, r]): SetZ[MapEntry[k, v, r], r1] \ { r, r1 }= 
        import java.util.Map.entrySet(): ##java.util.Set \ { r, r1 };
        let MapZ(_, m1) = m;
        let sz = entrySet(m1);
        SetZ(rc, sz)


    pub def values(rc: Region[r1], m: MapZ[k, v, r]): Collection[k, r1] \ { r, r1 } = 
        import java.util.Map.values(): ##java.util.Collection \ { r, r1 };
        let MapZ(_, m1) = m;
        Collection(rc, values(m1))

    pub def remove!(getterVal: ##java.lang.Object -> v1 \ ef, k: k, m: MapZ[k, v, r]): Result[String, Option[v1]] \ {ef, r} with GoesToJava[k] =
        Result.tryCatch(_ -> {
            import java.util.Map.remove(##java.lang.Object): ##java.lang.Object \ {ef, r}; 
            let MapZ(_, m1) = m;
            let k1 = Interop.Flix.GoesToJava.toJavaObject(k);        
            remove(m1, k1) |> Object.toOption |> Option.map(getterVal)
        })

    /// Note - needs kinds specifying...
    pub def forEach(f: BiConsumer[k, v, ef], m: MapZ[k, v, r]): Result[String, Unit] \ {ef, r} with GoesToJava[v] =
        Result.tryCatch(_ -> {
            import java.util.Map.forEach(##java.util.function.BiConsumer): Unit \ {ef, r}; 
            let MapZ(_, m1) = m;
            let BiConsumer(f1) = f;
            forEach(m1, f1)
        })

    pub def fromFlixMapViaHashMap(rc: Region[r], t: Map[k, v]): MapZ[k, v, r] \ r with GoesToJava[k], GoesToJava[v], ComesFromJava[v] =
        Interop.Util.HashMap.fromFlixMap(rc, t) |> Interop.Util.ImpMapZ.toMapZ

    /// Note - this is useful even though it breaks abstraction...
    pub def fromFlixMapViaHashMapHH(t: Map[k, v]): ##java.util.Map with GoesToJava[k], GoesToJava[v], ComesFromJava[v] = region rc {
        Interop.Util.HashMap.fromFlixMap(rc, t) |> Interop.Util.ImpMapZ.toMapHH
    }


    pub def fromFlixMapViaHashMapWith(rc: Region[r], 
                                        kcast: k -> ##java.lang.Object, 
                                        vcast: v -> ##java.lang.Object, 
                                        t: Map[k, v]): MapZ[k, v, r] \ { r } =
        Interop.Util.HashMap.fromFlixMapWith(rc, kcast, vcast, t) |> Interop.Util.ImpMapZ.toMapZ

    pub def fromFlixMapViaHashMapHHWith(kcast: k -> ##java.lang.Object, 
                                        vcast: v -> ##java.lang.Object, 
                                        t: Map[k, v]): ##java.util.Map = region rc {
        Interop.Util.HashMap.fromFlixMapWith(rc, kcast, vcast, t) |> Interop.Util.ImpMapZ.toMapHH
    }


    pub def fromFoldableViaHashMap(rc: Region[r], t: t[(k, v)]): MapZ[k, v, r] \ { r } with Foldable[t], GoesToJava[k], GoesToJava[v], ComesFromJava[v] =
        Interop.Util.HashMap.fromFoldable(rc, t) |> Interop.Util.ImpMapZ.toMapZ

    pub def fromFoldableViaHashMapHH(t: t[(k, v)]): ##java.util.Map with Foldable[t], GoesToJava[k], GoesToJava[v], ComesFromJava[v] = region rc {
        Interop.Util.HashMap.fromFoldable(rc, t) |> Interop.Util.ImpMapZ.toMapHH
    }


    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            getterKey: ##java.lang.Object -> k1 \ ef1, 
                            getterVal: ##java.lang.Object -> v1 \ ef2, 
                            m: MapZ[k, v, r]): Iterator[(k1, v1), ef1 + ef2 + r1, r1] \ r =
        import java.util.Map.entrySet(): ##java.util.Set \ r;
        import java.util.Set.iterator(): ##java.util.Iterator \ r;
        import java.util.Iterator.hasNext(): Bool \ r1;
        import java.util.Iterator.next(): ##java.lang.Object \ r1;
        let set1 = getHH(m) |> entrySet;
        let iter = iterator(set1);
        let getNext = () -> match hasNext(iter) {
            case true  => {
                let entry = next(iter) |> Interop.Util.MapEntry.castObject(rc);
                Interop.Util.MapEntry.toKeyValue(getterKey, getterVal, entry) |> Some
            }
            case false => None
        };
        Iterator.iterate(rc, getNext)


    
    pub def toFlixMap(fromJavaKey: ##java.lang.Object -> k, 
                        fromJavaValue: ##java.lang.Object -> v,
                        m: MapZ[k, v, r]): Map[k, v] \ r with Order[k] = region rc {
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        toFlixIterator(rc, fromJavaKey, fromJavaValue, m) |> Iterator.foldLeft(step, Map.empty())
    } 

    pub def toFlixList(fromJavaKey: ##java.lang.Object -> k, 
                        fromJavaValue: ##java.lang.Object -> v,
                        m: MapZ[k, v, r]): List[(k, v)] \ r = region rc {
        toFlixIterator(rc, fromJavaKey, fromJavaValue, m) |> Iterator.toList
    }

}
