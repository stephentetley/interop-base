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

    pub def newInputStreamReader(ins: InputStream[r], cs: Charset): InputStreamReader[r] \ Write(r) = 
        import new java.io.InputStreamReader(##java.io.InputStream, ##java.nio.charset.Charset): ##java.io.InputStreamReader \ r as newInputStreamReader;
        let Charset(cs1) = cs;
        let ins1 = Interop/IO/InputStream.getHH(ins);
        InputStreamReader(newInputStreamReader(ins1, cs1))

    /// None indicates end-of-stream.
    pub def read!(rd: InputStreamReader[r]): Result[Option[Int32], String] \ Read(r) = 
        try {
            import java.io.InputStreamReader.read(): Int32 \ r;
            let InputStreamReader(rd1) = rd;
            match read(rd1) { 
                case i if i < 0 => Ok(None)
                case i          => Ok(Some(i))
            }
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    // read (into-array)
    pub def readSubArray!(buf: Array[Char, r2], 
                        offset: {offset = Int32}, 
                        len: {len = Int32}, 
                        rd: InputStreamReader[r]): Result[Int32, String] \ { Write(r2), Read(r) } = 
        try {
            import java.io.InputStreamReader.read(Array[Char, r2], Int32, Int32): Int32 \ {r, r2};
            let InputStreamReader(rd1) = rd;
            read(rd1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getEncoding(rd: InputStreamReader[r]): String \ Read(r) = 
        import java.io.InputStreamReader.getEncoding(): String \ r;
        let InputStreamReader(rd1) = rd;
        getEncoding(rd1)

    pub def ready(rd: InputStreamReader[r]): Result[Bool, String] \ Read(r) = 
        try {
            import java.io.InputStreamReader.ready(): Bool \ r;
            let InputStreamReader(rd1) = rd;
            ready(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(rd: InputStreamReader[r]): Result[Unit, String] \ Write(r) = 
        try {
            import java.io.InputStreamReader.close(): Unit \ r;
            let InputStreamReader(rd1) = rd;
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
