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
    pub enum Entry[_k: Type, _v: Type, r: Region] { 
        case Entry(Region[r], ##java.util.Map$Entry)
    }
    

}

namespace Interop/Util/Map/Entry {

    use Interop/Util/Map.Entry;
    use Interop/Util/Map.Entry.{Entry};
    use Interop/Flix.Marshal;

    pub def getHH(e: Entry[k, v, r]): ##java.util.Map$Entry = 
        let Entry(_, e1) = e;
        e1

    pub def wrapHH(rc: Region[r], prim: ##java.util.Map$Entry): Entry[k, v, r] = 
        Entry(rc, prim)


    /// Entry cannot be an instance of Marshal because it carries a region.
    pub def castObject(rc: Region[r], o: ##java.lang.Object): Entry[k, v, r] \ Write(r) = 
        unsafe_cast (Entry(rc, unsafe_cast o as ##java.util.Map$Entry)) as _ \ Write(r)

    pub def equals(e1: Entry[k, v, r], e2: Entry[k, v, r]): Bool \ Read(r) = 
        import java.util.Map$Entry.equals(##java.lang.Object): Bool \ r;
        let Entry(_, ee1) = e1;
        let Entry(_, ee2) = e2;
        equals(ee1, unsafe_cast ee2 as ##java.lang.Object) 

    pub def hashCode(e: Entry[k, v, r]): Int32 \ Read(r) = 
        import java.util.Map$Entry.hashCode(): Int32 \ r;
        let Entry(_, e1) = e;
        hashCode(e1) 

    pub def getKey(e: Entry[k, v, r]): k \ Read(r) with Marshal[k] = 
        import java.util.Map$Entry.getKey(): ##java.lang.Object \ r;
        let Entry(_, e1) = e;
        getKey(e1) |> Interop/Flix/Marshal.fromJavaObject

    pub def getValue(e: Entry[k, v, r]): v \ Read(r) with Marshal[v] = 
        import java.util.Map$Entry.getValue(): ##java.lang.Object \ r;
        let Entry(_, e1) = e;
        getValue(e1) |> Interop/Flix/Marshal.fromJavaObject

    pub def copyOf(rc: Region[r1], e: Entry[k, v, r]): Result[String, Entry[k, v, r1]] \ { Read(r), Write(r1) } = 
        try {
            import static java.util.Map$Entry.copyOf(##java.util.Map$Entry): ##java.util.Map$Entry \ { Read(r), Write(r1) };
            let Entry(_, e1) = e;
            Entry(rc, copyOf(e1)) |> Ok
        } catch { 
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    ///
    /// We don't need the inverse function "Entry from (k,v)" because Java's API for building maps is `m.put(k, v)`
    /// so we never need to create a MapEntry.
    ///
    pub def toKeyValue(e: Entry[k, v, r]): (k, v) \ Read(r) with Marshal[k], Marshal[v] =
        toKeyValueWith(Interop/Flix/Marshal.fromJavaObject, Interop/Flix/Marshal.fromJavaObject, e)

    pub def toKeyValueWith(kcast:  ##java.lang.Object -> k, 
                                    vcast: ##java.lang.Object -> v,
                                    e: Entry[k, v, r]): (k, v) \ Read(r) =
        import java.util.Map$Entry.getKey(): ##java.lang.Object & r;
        import java.util.Map$Entry.getValue(): ##java.lang.Object & r;
        let Entry(_, e1) = e;
        let k = getKey(e1);
        let v = getValue(e1);                
        let k1 = kcast(k);
        let v1 = vcast(v);
        (k1, v1)

}
