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

    use Interop/Util.HashMap;
    use Interop/Util.HashMap.{HashMap};
    use Interop/Util.ImpMapZ;
    use Interop/Flix.Marshal;


    pub def getHH(m: HashMap[k, v, r]): ##java.util.HashMap = 
        let HashMap(m1) = m;
        m1

}
