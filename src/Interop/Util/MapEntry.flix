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


    /// Mutable - see `java.util.Map.Entry.setValue`
    pub enum MapEntry[_k: Type, _v: Type, _: Region](##java.util.Map$Entry)

}

namespace Interop/Util/MapEntry {

    use Interop/Util.MapEntry;
    use Interop/Util.MapEntry.{MapEntry};
    use Interop/Flix.Marshal;

    pub def getHH(m: MapEntry[k, v, r]): ##java.util.Map$Entry = 
        let MapEntry(m1) = m;
        m1

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

        
}
