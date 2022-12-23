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
    pub enum InputStream[_: Region](##java.io.InputStream)


    pub class SubInputStream[t: Region -> Type] {
        pub def toInputStream[r: Region](s: t[r]): InputStream[r]
        pub def fromInputStream[r: Region](s: InputStream[r]): t[r]
    }

}


namespace Interop/IO/InputStream {

    use Interop/IO.InputStream;
    use Interop/IO.InputStream.{InputStream};

    pub def getHH(ins: InputStream[r]): ##java.io.InputStream = 
        let InputStream(ins1) = ins;
        ins1

    pub def wrapHH(_: Region[r], prim: ##java.io.InputStream): InputStream[r] = 
        InputStream(prim)




    pub def readAllBytes(ins: InputStream[r]): Result[Array[Int8, r], String] \ IO = 
        try {
            import java.io.InputStream.readAllBytes(): Array[Int8, r] \ IO;
            let InputStream(ins1) = ins;
            readAllBytes(ins1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
