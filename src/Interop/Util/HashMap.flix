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
    /// Represents a Java HashMap.
    /// Mutable / Class
    ///
    pub enum HashMap[_k: Type, _v: Type, _r: Region](##java.util.HashMap)

    instance Newable[HashMap[k, v]] {
        pub def new(r: Region[r]): HashMap[k, v, r] \ Write(r) = Interop/Util/HashMap.new(r)
    }

    instance Scoped[HashMap[k, v]] {
        pub def regionOf(_: HashMap[k, v, r]): Region[r] = () as Region[r]
    }


    instance Interop/Util.ImpMapZ[HashMap] {
        pub def toMapZ(t: HashMap[k, v, r]): MapZ[k, v, r] = 
            let HashMap(t1) = t;
            MapZ(t1 as ##java.util.Map)

        pub def fromMapZ(t: MapZ[k, v, r]): HashMap[k, v, r] = 
            let MapZ(t1) = t;
            HashMap(t1 as ##java.util.HashMap) 
    }

}

namespace Interop/Util/HashMap {

    use Interop/Util.HashMap
    use Interop/Util.HashMap.{HashMap}
    use Interop/Util.ImpMapZ
    use Interop/Util/Map.Entry
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.SetZ
    use Interop/Util.SetZ.{SetZ}
    use Interop/Flix.Marshal


    pub def getHH(m: HashMap[k, v, r]): ##java.util.HashMap = 
        let HashMap(m1) = m;
        m1

    pub def wrapHH(_: Region[r], prim: ##java.util.HashMap): HashMap[k, v, r] =
        HashMap(prim)

    ///
    /// Returns a new mutable HashMap.
    ///
    pub def new(_: Region[r]): HashMap[k, v, r] \ Write(r) =
        import new java.util.HashMap(): ##java.util.HashMap & r as newHashMap;
        newHashMap() |> HashMap


    pub def equals(m1: HashMap[k, v, r], m2: HashMap[k, v, r]): Bool \ Read(r) =
        import java.util.HashMap.equals(##java.lang.Object): Bool \ r; 
        let HashMap(jm1) = m1;
        let HashMap(jm2) = m2;
        equals(jm1, jm2 as ##java.lang.Object)

    pub def size(m: HashMap[k, v, r]): Int32 \ Read(r) =
        import java.util.HashMap.size(): Int32 \ r;
        let HashMap(m1) = m;
        size(m1)

    pub def isEmpty(m: HashMap[k, v, r]): Bool \ Write(r) =
        import java.util.HashMap.isEmpty(): Bool \ r; 
        let HashMap(m1) = m;
        isEmpty(m1)

    pub def hashCode(m: HashMap[k, v, r]): Int32 \ Read(r) =
        import java.util.HashMap.hashCode(): Int32 \ r;
        let HashMap(m1) = m;
        hashCode(m1)

    pub def get(k: k, m: HashMap[k, v, r]): Result[Option[v], String] \ Write(r) with Marshal[k], Marshal[v] =
        try {
            import java.util.HashMap.get(##java.lang.Object): ##java.lang.Object \ r; 
            let HashMap(m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);
            get(m1, k1) |> Object.toOption |> Option.map(Interop/Flix/Marshal.fromJavaObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def put!(k: k, v: v, m: HashMap[k, v, r]): v \ Write(r) with Marshal[k], Marshal[v] =
        import java.util.HashMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
        let HashMap(m1) = m;
        let k1 = Interop/Flix/Marshal.toJavaObject(k);
        let v1 = Interop/Flix/Marshal.toJavaObject(v);
        put(m1, k1, v1) |> Interop/Flix/Marshal.fromJavaObject

    pub def putWith!(k: k, v: v, 
                        kcast: k -> ##java.lang.Object, 
                        vcast: v -> ##java.lang.Object, 
                        m: HashMap[k, v, r]): Unit \  Write(r) =
        import java.util.HashMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
        let HashMap(m1) = m;
        let k1 = kcast(k);
        let v1 = vcast(v);
        discard put(m1, k1, v1)


    pub def clear!(m: HashMap[k, v, r]): Unit \ Write(r) =
        import java.util.HashMap.clear(): Unit \ r; 
        let HashMap(m1) = m;
        clear(m1)

    pub def entrySet(m: HashMap[k, v, r]): SetZ[Entry[k, v, r], r] \ {Write(r)}= 
        import java.util.HashMap.entrySet(): ##java.util.Set \ Write(r);
        let HashMap(m1) = m;
        entrySet(m1) |> SetZ


    pub def keySet(m: HashMap[k, v, r]): SetZ[k, r] \ {Write(r)}= 
        import java.util.HashMap.keySet(): ##java.util.Set \ Write(r);
        let HashMap(m1) = m;
        keySet(m1) |> SetZ

    pub def values(m: HashMap[k, v, r]): Collection[k, r] \ {Write(r)}= 
        import java.util.HashMap.values(): ##java.util.Collection \ Write(r);
        let HashMap(m1) = m;
        values(m1) |> Collection


    pub def remove!(k: k, m: HashMap[k, v, r]): Option[v] \  Write(r) with Marshal[k], Marshal[v] =
        import java.util.HashMap.remove(##java.lang.Object): ##java.lang.Object \ r; 
        let HashMap(m1) = m;
        let k1 = Interop/Flix/Marshal.toJavaObject(k);        
        remove(m1, k1) |> Object.toOption |>  Option.map(Interop/Flix/Marshal.fromJavaObject)


    pub def fromFlixMap(r: Region[r], t: Map[k, v]): HashMap[k, v, r] \ Write(r) with Marshal[k], Marshal[v] =
        let map1 = new(r);
        Map.forEach((k, v) -> discard put!(k, v, map1), t);
        map1


    pub def fromFoldable(r: Region[r], t: t[(k, v)]): HashMap[k, v, r] \ Write(r) with Foldable[t], Marshal[k], Marshal[v] =
        let map1 = new(r);
        Foldable.forEach(match (k, v) -> discard put!(k, v, map1), t);
        map1

    pub def fromFoldableWith(r: Region[r], 
                                kcast: k -> ##java.lang.Object, 
                                vcast: v -> ##java.lang.Object, 
                                t: t[(k, v)]): HashMap[k, v, r] \ { Write(r) } with Foldable[t] =
        let map1 = new(r);
        Foldable.forEach(match (k, v) -> putWith!(k, v, kcast, vcast, map1), t);
        map1


}
