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

    use Interop/IO.Reader;
    use Interop/IO.Reader.{Reader};

    pub enum InputStreamReader[_: Region](##java.io.InputStreamReader)

    instance Scoped[InputStreamReader] {
        pub def regionOf(_: InputStreamReader[r]): Region[r] = () as Region[r]
    }

    instance Interop/IO.SubReader[InputStreamReader] {
        pub def toReader(s: InputStreamReader[r]): Reader[r] = 
            let InputStreamReader(s1) = s;
            Reader(s1 as ##java.io.Reader)

        pub def fromReader(s: Reader[r]): InputStreamReader[r] = 
            let Reader(s1) = s;
            InputStreamReader(s1 as ##java.io.InputStreamReader) 
    }

}

namespace Interop/IO/InputStreamReader {

    use Interop/IO.InputStreamReader;
    use Interop/IO.InputStreamReader.{InputStreamReader};
    use Interop/IO.InputStream;

    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};

    pub def getHH(rd: InputStreamReader[r]): ##java.io.InputStreamReader = 
        let InputStreamReader(rd1) = rd;
        rd1

    pub def wrapHH(_: Region[r], prim: ##java.io.InputStreamReader): InputStreamReader[r] =
        InputStreamReader(prim)

    pub def newInputStreamReader(_: Region[r], 
                                    ins: InputStream[r], 
                                    cs: Charset): InputStreamReader[r] \ Write(r) = 
        import new java.io.InputStreamReader(##java.io.InputStream, ##java.nio.charset.Charset): ##java.io.InputStreamReader \ r as newInputStreamReader;
        let Charset(cs1) = cs;
        let ins1 = Interop/IO/InputStream.getHH(ins);
        InputStreamReader(newInputStreamReader(ins1, cs1))


}
