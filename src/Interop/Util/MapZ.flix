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
    /// Iterface / Mutable (some implementations may not be mutable)
    ///
    pub enum MapZ[_k: Type, _v: Type, _r: Region](##java.util.Map)

    instance Scoped[MapZ[k, v]] {
        pub def regionOf(_: MapZ[k, v, r]): Region[r] = unsafe_cast () as Region[r]
    }

    pub class ImpMapZ[t: Type -> Type -> Region -> Type] {
        pub def toMapZ[k: Type, v: Type, r: Region](m: t[k, v, r]): MapZ[k, v, r]
        pub def fromMapZ[k: Type, v: Type, r: Region](m: MapZ[k, v, r]): t[k, v, r]
    }



}

namespace Interop/Util/MapZ {

    use Interop/Util.MapZ
    use Interop/Util.MapZ.{MapZ}
    use Interop/Util/Map.Entry
    use Interop/Util/Map.Entry.{Entry}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.SetZ
    use Interop/Util.SetZ.{SetZ}
    use Interop/Util.ImpMapZ
    use Interop/Flix.Marshal

    pub def getHH(m: MapZ[k, v, r]): ##java.util.Map = 
        let MapZ(m1) = m;
        m1


    pub def wrapHH(_: Region[r], prim: ##java.util.Map): MapZ[k, v, r] =
        MapZ(prim)


    pub def toMapHH[t: Type -> Type -> Region -> Type, k: Type, v: Type, r: Region](s: t[k, v, r]): ##java.util.Map with ImpMapZ[t] = 
        Interop/Util/ImpMapZ.toMapZ(s) |> getHH

    pub def of0(_: Region[r]): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        import static java.util.Map.of(): ##java.util.Map \ r;
        of() |> MapZ

    pub def of1(_: Region[r], k1: k, v1: v): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop/Flix/Marshal.toJavaObject(k1);
        let vo1 = Interop/Flix/Marshal.toJavaObject(v1);
        of(ko1, vo1) |> MapZ

    pub def of2(_: Region[r], k1: k, v1: v, k2: k, v2: v): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop/Flix/Marshal.toJavaObject(k1);
        let vo1 = Interop/Flix/Marshal.toJavaObject(v1);
        let ko2 = Interop/Flix/Marshal.toJavaObject(k2);
        let vo2 = Interop/Flix/Marshal.toJavaObject(v2);
        of(ko1, vo1, ko2, vo2) |> MapZ


    pub def of3(_: Region[r], k1: k, v1: v, k2: k, v2: v, k3: k, v3: v): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop/Flix/Marshal.toJavaObject(k1);
        let vo1 = Interop/Flix/Marshal.toJavaObject(v1);
        let ko2 = Interop/Flix/Marshal.toJavaObject(k2);
        let vo2 = Interop/Flix/Marshal.toJavaObject(v2);
        let ko3 = Interop/Flix/Marshal.toJavaObject(k3);
        let vo3 = Interop/Flix/Marshal.toJavaObject(v3);
        of(ko1, vo1, ko2, vo2, ko3, vo3) |> MapZ

    pub def of4(_: Region[r], k1: k, v1: v, k2: k, v2: v, k3: k, v3: v, k4: k, v4: v): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, 
                                        ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop/Flix/Marshal.toJavaObject(k1);
        let vo1 = Interop/Flix/Marshal.toJavaObject(v1);
        let ko2 = Interop/Flix/Marshal.toJavaObject(k2);
        let vo2 = Interop/Flix/Marshal.toJavaObject(v2);
        let ko3 = Interop/Flix/Marshal.toJavaObject(k3);
        let vo3 = Interop/Flix/Marshal.toJavaObject(v3);
        let ko4 = Interop/Flix/Marshal.toJavaObject(k4);
        let vo4 = Interop/Flix/Marshal.toJavaObject(v4);
        of(ko1, vo1, ko2, vo2, ko3, vo3, ko4, vo4) |> MapZ

    pub def of5(_: Region[r], k1: k, v1: v, k2: k, v2: v, k3: k, v3: v, k4: k, v4: v, k5: k, v5: v): MapZ[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        import static java.util.Map.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, 
                                        ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Map \ r;
        let ko1 = Interop/Flix/Marshal.toJavaObject(k1);
        let vo1 = Interop/Flix/Marshal.toJavaObject(v1);
        let ko2 = Interop/Flix/Marshal.toJavaObject(k2);
        let vo2 = Interop/Flix/Marshal.toJavaObject(v2);
        let ko3 = Interop/Flix/Marshal.toJavaObject(k3);
        let vo3 = Interop/Flix/Marshal.toJavaObject(v3);
        let ko4 = Interop/Flix/Marshal.toJavaObject(k4);
        let vo4 = Interop/Flix/Marshal.toJavaObject(v4);
        let ko5 = Interop/Flix/Marshal.toJavaObject(k5);
        let vo5 = Interop/Flix/Marshal.toJavaObject(v5);
        of(ko1, vo1, ko2, vo2, ko3, vo3, ko4, vo4, ko5, vo5) |> MapZ


    pub def equals(m1: MapZ[k, v, r], m2: MapZ[k, v, r]): Bool \ Read(r) =
        import java.util.Map.equals(##java.lang.Object): Bool \ r; 
        let MapZ(jm1) = m1;
        let MapZ(jm2) = m2;
        equals(jm1, unsafe_cast jm2 as ##java.lang.Object)

    pub def size(m: MapZ[k, v, r]): Int32 \ Read(r) =
        import java.util.Map.size(): Int32 \ r;
        let MapZ(m1) = m;
        size(m1)

    pub def isEmpty(m: MapZ[k, v, r]): Bool \ Read(r) =
        import java.util.Map.isEmpty(): Bool \ r;
        let MapZ(m1) = m;
        isEmpty(m1)

    pub def hashCode(m: MapZ[k, v, r]): Int32 \ Read(r) =
        import java.util.Map.hashCode(): Int32 \ r;
        let MapZ(m1) = m;
        hashCode(m1)

    pub def clear!(m: MapZ[k, v, r]): Unit \ Write(r) =
        import java.util.Map.clear(): Unit \ r; 
        let MapZ(m1) = m;
        clear(m1)

    pub def get(k: k, m: MapZ[k, v, r]): Result[Option[v], String] \ Write(r) with Marshal[k], Marshal[v] =
        try {
            import java.util.Map.get(##java.lang.Object): ##java.lang.Object \ r; 
            let MapZ(m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);
            get(m1, k1) |> Object.toOption |> Option.map(Interop/Flix/Marshal.fromJavaObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def put!(k: k, v: v, m: MapZ[k, v, r]): Result[Option[v], String] \ Write(r) with Marshal[k], Marshal[v] =
        try {
            import java.util.Map.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
            let MapZ(m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);
            let v1 = Interop/Flix/Marshal.toJavaObject(v);
            put(m1, k1, v1) |> Object.toOption |> Option.map(Interop/Flix/Marshal.fromJavaObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def containsKey(k: k, m: MapZ[k, v, r]): Result[Bool, String] \ Read(r) with Marshal[k] =
        try {
            import java.util.Map.containsKey(##java.lang.Object): Bool \ r; 
            let MapZ(m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);
            containsKey(m1, k1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def containsValue(v: v, m: MapZ[k, v, r]): Result[Bool, String] \ Read(r) with Marshal[v] =
        try {
            import java.util.Map.containsValue(##java.lang.Object): Bool \ r; 
            let MapZ(m1) = m;
            let v1 = Interop/Flix/Marshal.toJavaObject(v);
            containsValue(m1, v1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    /// Can't guarantee `Ord[k]` at this point...
    pub def entrySet(m: MapZ[k, v, r]): SetZ[Entry[k, v, r], r] \ {Write(r)}= 
        import java.util.Map.entrySet(): ##java.util.Set \ Write(r);
        let MapZ(m1) = m;
        let sz = entrySet(m1);
        SetZ(sz)


    pub def values(m: MapZ[k, v, r]): Collection[k, r] \ {Write(r)}= 
        import java.util.Map.values(): ##java.util.Collection \ Write(r);
        let MapZ(m1) = m;
        values(m1) |> Collection

    pub def remove!(k: k, m: MapZ[k, v, r]): Result[Option[v], String] \  Write(r) with Marshal[k], Marshal[v] =
        try {
            import java.util.Map.remove(##java.lang.Object): ##java.lang.Object \ r; 
            let MapZ(m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);        
            remove(m1, k1) |> Object.toOption |> Option.map(Interop/Flix/Marshal.fromJavaObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def forEach(f: (k, v) -> Unit \ ef, m: MapZ[k, v, r]): Result[Unit, String] \  {ef, Read(r)} with Marshal[k], Marshal[v] =
        try {
            import java.util.Map.forEach(##java.util.function.BiConsumer): Unit \ r; 
            let MapZ(m1) = m;
            let f1 = Interop/Util/Function/BiConsumer.makeBiConsumer(f);
            forEach(m1, f1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    ///
    pub def iterator(m: MapZ[k, v, r]): Iterator[(k, v), r] \ { Write(r) } with Marshal[k], Marshal[v] =
        toFlixIterator(Scoped.regionOf(m), Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, m)

    ///
    /// Returns an iterator over all key-value pairs in `m`.
    /// Can't use RawIterator because no Marshal instance for MapEntry
    ///
    pub def toFlixIterator(r2: Region[r2], 
                            kcast: ##java.lang.Object -> k, 
                            vcast: ##java.lang.Object -> v, 
                            m: MapZ[k, v, r]): Iterator[(k, v), r2] \ { Read(r), Write(r2) } with Marshal[k], Marshal[v] =
        import java.util.Map.entrySet(): ##java.util.Set \ r;
        import java.util.Set.iterator(): ##java.util.Iterator \ {r, r2};
        import java.util.Iterator.hasNext(): Bool \ r2;
        import java.util.Iterator.next(): ##java.lang.Object \ r2;
        let set1 = getHH(m) |> entrySet;
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


    
    pub def toFlixMap(m: MapZ[k, v, r]): Map[k, v] \ { Read(r) } with Order[k], Marshal[k], Marshal[v] =
        let step = (acc, entry) -> {
            let (k, v) = entry;
            Map.insert(k, v, acc)
        };
        iterator(m) |> Iterator.foldLeft(step, Map.empty())

    pub def toFlixList(m: MapZ[k, v, r]): List[(k, v)] \ { Read(r) } with Marshal[k], Marshal[v] =
        iterator(m) |> Iterator.toList

}
