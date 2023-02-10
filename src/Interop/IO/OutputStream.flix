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
    pub enum OutputStream[r: Region] { 
        case OutputStream(Region[r], ##java.io.OutputStream)
    }

    pub class SubOutputStream[t: Region -> Type] {
        pub def toOutputStream[r: Region, r1: Region](rc: Region[r1], s: t[r]): OutputStream[r1]
        pub def fromOutputStream[r: Region, r1: Region](rc: Region[r1], s: OutputStream[r]): t[r1]
    }


}

namespace Interop/IO/OutputStream {

    use Interop/IO.OutputStream;
    use Interop/IO.OutputStream.{OutputStream};

    pub def getHH(s: OutputStream[r]): ##java.io.OutputStream = 
        let OutputStream(_, s1) = s;
        s1

    pub def wrapHH(rc: Region[r], prim: ##java.io.OutputStream): OutputStream[r] = 
        OutputStream(rc, prim)


}
