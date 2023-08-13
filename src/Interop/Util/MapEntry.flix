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


    /// Interface 
    /// Mutable - see `java.util.Map.Entry.setValue`, no alloc
    pub enum MapEntry[_k: Type, _v: Type, _r: Region](##java.util.Map$Entry)
    

}

mod Interop.Util.MapEntry {

    use Interop.Util.MapEntry
    use Interop.Util.MapEntry.{MapEntry}

    pub def getHH(e: MapEntry[k, v, r]): ##java.util.Map$Entry = 
        let MapEntry(e1) = e;
        e1

    pub def wrapHH(_: Region[r], prim: ##java.util.Map$Entry): MapEntry[k, v, r] = 
        MapEntry(prim)


    /// MapEntry cannot be an instance of Marshal because it carries a region.
    pub def castObject(_: Region[r], o: ##java.lang.Object): MapEntry[k, v, r] = 
        MapEntry(unchecked_cast(o as ##java.util.Map$Entry))


    pub def equals(x: MapEntry[k, v, r], y: MapEntry[k, v, r]): Bool \ r =
        import java.util.Map$Entry.equals(##java.lang.Object): Bool \ r;
        let MapEntry(x1) = x;
        let MapEntry(y1) = y;
        equals(x1, checked_cast(y1))

    pub def hashCode(e: MapEntry[k, v, r]): Int32 \ r = 
        import java.util.Map$Entry.hashCode(): Int32 \ r;
        let MapEntry(e1) = e;
        hashCode(e1) 

    pub def getKey(getterKey: ##java.lang.Object -> k1 \ ef, e: MapEntry[k, v, r]): k1 \ {ef, r} = 
        import java.util.Map$Entry.getKey(): ##java.lang.Object \ r;
        let MapEntry(e1) = e;
        getKey(e1) |> getterKey

    pub def getValue(getterVal: ##java.lang.Object -> v1 \ ef, e: MapEntry[k, v, r]): v1 \ {ef, r} = 
        import java.util.Map$Entry.getValue(): ##java.lang.Object \ r;
        let MapEntry(e1) = e;
        getValue(e1) |> getterVal

    pub def copyOf(_: Region[r1], e: MapEntry[k, v, r]): Result[String, MapEntry[k, v, r1]] \ { r, r1 } = 
        Result.tryCatch(_ -> {
            import static java.util.Map$Entry.copyOf(##java.util.Map$Entry): ##java.util.Map$Entry \ { r, r1 };
            let MapEntry(e1) = e;
            MapEntry(copyOf(e1))
        })

    ///
    /// We don't need the inverse function "MapEntry from (k,v)" because Java's API for building maps is `m.put(k, v)`
    /// so we never need to create a MapEntry.
    ///
    pub def toKeyValue(getterKey: ##java.lang.Object -> k1 \ ef1, 
                        getterVal: ##java.lang.Object -> v1 \ ef2, 
                        e: MapEntry[k, v, r]): (k1, v1) \ {ef1, ef2, r} =
        import java.util.Map$Entry.getKey(): ##java.lang.Object \ r;
        import java.util.Map$Entry.getValue(): ##java.lang.Object \ r;
        let MapEntry(e1) = e;
        let k = getKey(e1);
        let v = getValue(e1);                
        let k1 = getterKey(k);
        let v1 = getterVal(v);
        (k1, v1)

}
