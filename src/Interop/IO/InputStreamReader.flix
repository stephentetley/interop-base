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

    pub enum InputStreamReader[r: Region] { 
        case InputStreamReader(Region[r], ##java.io.InputStreamReader)
    }

    instance Interop/IO.SubReader[InputStreamReader] {
        pub def toReader(rc: Region[r1], s: InputStreamReader[r]): Reader[r1] = 
            let InputStreamReader(_, s1) = s;
            Reader(rc, unsafe_cast s1 as ##java.io.Reader)

        pub def fromReader(rc: Region[r1], s: Reader[r]): InputStreamReader[r1] = 
            let Reader(_, s1) = s;
            InputStreamReader(rc, unsafe_cast s1 as ##java.io.InputStreamReader) 
    }

}

namespace Interop/IO/InputStreamReader {

    use Interop/IO.InputStreamReader;
    use Interop/IO.InputStreamReader.{InputStreamReader};
    use Interop/IO.InputStream;

    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};

    pub def getHH(rd: InputStreamReader[r]): ##java.io.InputStreamReader = 
        let InputStreamReader(_, rd1) = rd;
        rd1

    pub def wrapHH(rc: Region[r], prim: ##java.io.InputStreamReader): InputStreamReader[r] =
        InputStreamReader(rc, prim)

    pub def newInputStreamReader(rc: Region[r1], ins: InputStream[r], cs: Charset): InputStreamReader[r1] \ { Read(r), Write(r1) }= 
        import new java.io.InputStreamReader(##java.io.InputStream, ##java.nio.charset.Charset): ##java.io.InputStreamReader \ {r, r1} as newInputStreamReader;
        let Charset(cs1) = cs;
        let ins1 = Interop/IO/InputStream.getHH(ins);
        InputStreamReader(rc, newInputStreamReader(ins1, cs1))

    /// None indicates end-of-stream.
    pub def read!(rd: InputStreamReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        try {
            import java.io.InputStreamReader.read(): Int32 \ r;
            let InputStreamReader(_, rd1) = rd;
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
                        rd: InputStreamReader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        try {
            import java.io.InputStreamReader.read(Array[Char, r2], Int32, Int32): Int32 \ {r, r2};
            let InputStreamReader(_, rd1) = rd;
            read(rd1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getEncoding(rd: InputStreamReader[r]): String \ Read(r) = 
        import java.io.InputStreamReader.getEncoding(): String \ r;
        let InputStreamReader(_, rd1) = rd;
        getEncoding(rd1)

    pub def ready(rd: InputStreamReader[r]): Result[String, Bool] \ Read(r) = 
        try {
            import java.io.InputStreamReader.ready(): Bool \ r;
            let InputStreamReader(_, rd1) = rd;
            ready(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(rd: InputStreamReader[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.io.InputStreamReader.close(): Unit \ r;
            let InputStreamReader(_, rd1) = rd;
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
