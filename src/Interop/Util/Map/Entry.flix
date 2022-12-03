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


    /// Interface / Mutable - see `java.util.Map.Entry.setValue`
    pub enum Entry[_k: Type, _v: Type, _: Region](##java.util.Map$Entry)
    
    instance Scoped[Entry[k, v]] {
        pub def regionOf(_: Entry[k, v, r]): Region[r] = unsafe_cast () as Region[r]
    }


}

namespace Interop/Util/Map/Entry {

    use Interop/Util/Map.Entry;
    use Interop/Util/Map.Entry.{Entry};
    use Interop/Flix.Marshal;

    pub def getHH(ent: Entry[k, v, r]): ##java.util.Map$Entry = 
        let Entry(ent1) = ent;
        ent1

    pub def wrapHH(_: Region[r], ent: ##java.util.Map$Entry): Entry[k, v, r] = 
        Entry(ent)


    /// Entry cannot be an instance of Marshal because it carries a region.
    pub def castObject(_: Region[r], o: ##java.lang.Object): Entry[k, v, r] \ Write(r) = 
        unsafe_cast (Entry(unsafe_cast o as ##java.util.Map$Entry)) as \ Write(r)

    pub def equals(x: Entry[k, v, r], y: Entry[k, v, r]): Bool \ Read(r) = 
        import java.util.Map$Entry.equals(##java.lang.Object): Bool \ r;
        let Entry(x1) = x;
        let Entry(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object) 

    pub def hashCode(x: Entry[k, v, r]): Int32 \ Read(r) = 
        import java.util.Map$Entry.hashCode(): Int32 \ r;
        let Entry(x1) = x;
        hashCode(x1) 

    pub def getKey(ent: Entry[k, v, r]): k \ Read(r) with Marshal[k] = 
        import java.util.Map$Entry.getKey(): ##java.lang.Object \ r;
        let Entry(ent1) = ent;
        getKey(ent1) |> Interop/Flix/Marshal.fromJavaObject

    pub def getValue(ent: Entry[k, v, r]): v \ Read(r) with Marshal[v] = 
        import java.util.Map$Entry.getValue(): ##java.lang.Object \ r;
        let Entry(ent1) = ent;
        getValue(ent1) |> Interop/Flix/Marshal.fromJavaObject

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
