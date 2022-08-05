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

namespace Interop/IO {


    /// Abstract class...
    pub enum OutputStream[_: Region](##java.io.OutputStream)

    instance Scoped[OutputStream] {
        pub def regionOf(_: OutputStream[r]): Region[r] = () as Region[r]
    }

    pub class SubOutputStream[t: Region -> Type] {
        pub def ucast[r: Region](s: t[r]): OutputStream[r]
        pub def dcast[r: Region](s: OutputStream[r]): t[r]
    }


}

namespace Interop/IO/OutputStream {

    use Interop/IO.OutputStream;
    use Interop/IO.OutputStream.{OutputStream};

    pub def getHH(ous: OutputStream[r]): ##java.io.OutputStream = 
        let OutputStream(ous1) = ous;
        ous1



}
