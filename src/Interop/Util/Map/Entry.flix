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

namespace Interop/Util/Map {


    /// Mutable - see `java.util.Map.Entry.setValue`
    pub enum Entry[_k: Type, _v: Type, _: Region](##java.util.Map$Entry)
    
    instance Scoped[Entry[k, v]] {
        pub def regionOf(_: Entry[k, v, r]): Region[r] = () as Region[r]
    }


}

namespace Interop/Util/Map/Entry {

    use Interop/Util/Map.Entry;
    use Interop/Util/Map.Entry.{Entry};
    use Interop/Flix.Marshal;

    pub def getHH(m: Entry[k, v, r]): ##java.util.Map$Entry = 
        let Entry(m1) = m;
        m1

    pub def wrapHH(_: Region[r], ent: ##java.util.Map$Entry): Entry[k, v, r] \ Write(r) = 
        Entry(ent) as \ Write(r)


    /// Entry cannot be an instance of Marshal because it carries a region.
    pub def castObject(_: Region[r], o: ##java.lang.Object): Entry[k, v, r] \ Write(r) = 
        Entry(o as ##java.util.Map$Entry) as \ Write(r)


    pub def hhToKV(prim: ##java.util.Map$Entry): (k, v) with Marshal[k], Marshal[v] = 
        (hhToKey(prim), hhToValue(prim))


    pub def hhToKey(prim: ##java.util.Map$Entry): k with Marshal[k]  = 
        hhToKeyWith(Interop/Flix/Marshal.fromJavaObject, prim)

    pub def hhToValue(prim: ##java.util.Map$Entry): v with Marshal[v] = 
        hhToValueWith(Interop/Flix/Marshal.fromJavaObject, prim)

    pub def hhToKeyWith(kcast: ##java.lang.Object -> k,  prim: ##java.util.Map$Entry): k  = 
        import java.util.Map$Entry.getKey(): ##java.lang.Object \ {};
        getKey(prim) |> kcast

    pub def hhToValueWith(vcast: ##java.lang.Object -> v,  prim: ##java.util.Map$Entry): v = 
        import java.util.Map$Entry.getValue(): ##java.lang.Object \ {};
        getValue(prim) |> vcast

    ///
    /// We don't need the inverse function "Entry from (k,v)" because Java's API for building maps is `m.put(k, v)`
    /// so we never need to create a MapEntry.
    ///
    pub def toKeyValue(entry: Entry[k, v, r]): (k, v) \ Read(r) with Marshal[k], Marshal[v] =
        toKeyValueWith(Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, entry)

    pub def toKeyValueWith(kcast:  ##java.lang.Object -> k, 
                                    vcast: ##java.lang.Object -> v,
                                    entry: Entry[k, v, r]): (k, v) \ Read(r) =
        import java.util.Map$Entry.getKey(): ##java.lang.Object & r;
        import java.util.Map$Entry.getValue(): ##java.lang.Object & r;
        let Entry(entry1) = entry;
        let k = getKey(entry1);
        let v = getValue(entry1);                
        let k1 = kcast(k);
        let v1 = vcast(v);
        (k1, v1)

}
