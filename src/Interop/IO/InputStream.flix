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
    pub enum InputStream[r: Region] { 
        case InputStream(Region[r], ##java.io.InputStream)
    }

    pub class SubInputStream[t: Region -> Type] {
        pub def toInputStream[r: Region, r1: Region](rc: Region[r1], s: t[r]): InputStream[r1]
        pub def fromInputStream[r: Region, r1: Region](rc: Region[r1], s: InputStream[r]): t[r1]
    }

}


namespace Interop/IO/InputStream {

    use Interop/IO.InputStream;
    use Interop/IO.InputStream.{InputStream};

    pub def getHH(s: InputStream[r]): ##java.io.InputStream = 
        let InputStream(_, s1) = s;
        s1

    pub def wrapHH(rc: Region[r], prim: ##java.io.InputStream): InputStream[r] = 
        InputStream(rc, prim)




    pub def readAllBytes(rc: Region[r1], s: InputStream[r]): Result[String, Array[Int8, r1]] \ { Read(r), Write(r1) } = 
        try {
            import java.io.InputStream.readAllBytes(): Array[Int8, r1] \ {r, r1};
            let InputStream(_, s1) = s;
            let _ = Array.new(rc);
            readAllBytes(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
