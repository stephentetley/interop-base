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
    pub enum HashMap[_k: Type, _v: Type, r: Region] {
        case HashMap(Region[r], ##java.util.HashMap)
    }

    instance Newable[HashMap[k, v]] {
        pub def new(r: Region[r]): HashMap[k, v, r] \ Write(r) = Interop/Util/HashMap.new(r)
    }


    instance Interop/Util.ImpMapZ[HashMap] {
        pub def toMapZ(rc: Region[r1], t: HashMap[k, v, r]): MapZ[k, v, r1] = 
            let HashMap(_, t1) = t;
            MapZ(rc, unsafe_cast t1 as ##java.util.Map)

        pub def fromMapZ(rc: Region[r1], t: MapZ[k, v, r]): HashMap[k, v, r1] = 
            let MapZ(_, t1) = t;
            HashMap(rc, unsafe_cast t1 as ##java.util.HashMap) 
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
        let HashMap(_, m1) = m;
        m1

    pub def wrapHH(rc: Region[r], prim: ##java.util.HashMap): HashMap[k, v, r] =
        HashMap(rc, prim)

    ///
    /// Returns a new mutable HashMap.
    ///
    pub def new(rc: Region[r]): HashMap[k, v, r] \ Write(r) =
        import new java.util.HashMap(): ##java.util.HashMap & r as newHashMap;
        HashMap(rc, newHashMap())


    pub def equals(m1: HashMap[k, v, r], m2: HashMap[k, v, r]): Bool \ Read(r) =
        import java.util.HashMap.equals(##java.lang.Object): Bool \ r; 
        let HashMap(_, mm1) = m1;
        let HashMap(_, mm2) = m2;
        equals(mm1, unsafe_cast mm2 as ##java.lang.Object)

    pub def size(m: HashMap[k, v, r]): Int32 \ Read(r) =
        import java.util.HashMap.size(): Int32 \ r;
        let HashMap(_, m1) = m;
        size(m1)

    pub def isEmpty(m: HashMap[k, v, r]): Bool \ Write(r) =
        import java.util.HashMap.isEmpty(): Bool \ r; 
        let HashMap(_, m1) = m;
        isEmpty(m1)

    pub def hashCode(m: HashMap[k, v, r]): Int32 \ Read(r) =
        import java.util.HashMap.hashCode(): Int32 \ r;
        let HashMap(_, m1) = m;
        hashCode(m1)

    pub def get(k: k, m: HashMap[k, v, r]): Result[String, Option[v]] \ Write(r) with Marshal[k], Marshal[v] =
        try {
            import java.util.HashMap.get(##java.lang.Object): ##java.lang.Object \ r; 
            let HashMap(_, m1) = m;
            let k1 = Interop/Flix/Marshal.toJavaObject(k);
            get(m1, k1) |> Object.toOption |> Option.map(Interop/Flix/Marshal.fromJavaObject) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def put!(k: k, v: v, m: HashMap[k, v, r]): v \ Write(r) with Marshal[k], Marshal[v] =
        import java.util.HashMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
        let HashMap(_, m1) = m;
        let k1 = Interop/Flix/Marshal.toJavaObject(k);
        let v1 = Interop/Flix/Marshal.toJavaObject(v);
        put(m1, k1, v1) |> Interop/Flix/Marshal.fromJavaObject

    pub def putWith!(k: k, v: v, 
                        kcast: k -> ##java.lang.Object, 
                        vcast: v -> ##java.lang.Object, 
                        m: HashMap[k, v, r]): Unit \  Write(r) =
        import java.util.HashMap.put(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ r; 
        let HashMap(_, m1) = m;
        let k1 = kcast(k);
        let v1 = vcast(v);
        discard put(m1, k1, v1)


    pub def clear!(m: HashMap[k, v, r]): Unit \ Write(r) =
        import java.util.HashMap.clear(): Unit \ r; 
        let HashMap(_, m1) = m;
        clear(m1)

    pub def entrySet(rc: Region[r1], m: HashMap[k, v, r]): SetZ[Entry[k, v, r], r1] \ {Write(r)}= 
        import java.util.HashMap.entrySet(): ##java.util.Set \ Write(r);
        let HashMap(_, m1) = m;
        SetZ(rc, entrySet(m1))


    pub def keySet(rc: Region[r1], m: HashMap[k, v, r]): SetZ[k, r1] \ {Write(r)}= 
        import java.util.HashMap.keySet(): ##java.util.Set \ Write(r);
        let HashMap(_, m1) = m;
        SetZ(rc, keySet(m1))

    pub def values(rc: Region[r1], m: HashMap[k, v, r]): Collection[k, r1] \ { Read(r), Write(r1) } = 
        import java.util.HashMap.values(): ##java.util.Collection \ {r1, r};
        let HashMap(_, m1) = m;
        Collection(rc, values(m1))


    pub def remove!(k: k, m: HashMap[k, v, r]): Option[v] \  Write(r) with Marshal[k], Marshal[v] =
        import java.util.HashMap.remove(##java.lang.Object): ##java.lang.Object \ r; 
        let HashMap(_, m1) = m;
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
