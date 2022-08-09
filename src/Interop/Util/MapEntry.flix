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


    pub def hhToKey(kcast: ##java.lang.Object -> k \ ef,  m: ##java.util.Map$Entry): k \ { ef }  = 
        import java.util.Map$Entry.getKey(): ##java.lang.Object & Pure;
        getKey(m) |> kcast

    pub def hhToValue(vcast: ##java.lang.Object -> v \ ef,  m: ##java.util.Map$Entry): v \ { ef }  = 
        import java.util.Map$Entry.getValue(): ##java.lang.Object & Pure;
        getValue(m) |> vcast

}
