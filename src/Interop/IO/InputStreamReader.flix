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

    use Interop/IO.InputStreamReader
    use Interop/IO.InputStreamReader.{InputStreamReader}
    use Interop/IO.Reader
    use Interop/IO.Reader.{Reader}

    pub enum InputStreamReader[_: Region](##java.io.InputStreamReader)


    instance Interop/IO.SubReader[InputStreamReader] {
        pub def toReader(s: InputStreamReader[r]): Reader[r] = 
            let InputStreamReader(s1) = s;
            Reader(unchecked_cast(s1 as ##java.io.Reader))

        pub def fromReader(s: Reader[r]): InputStreamReader[r] = 
            let Reader(s1) = s;
            InputStreamReader(unchecked_cast(s1 as ##java.io.InputStreamReader))
    }

}

namespace Interop/IO/InputStreamReader {

    use Interop/IO.InputStreamReader
    use Interop/IO.InputStreamReader.{InputStreamReader}
    use Interop/IO.InputStream
    use Interop/NIO/Charset.Charset
    use Interop/NIO/Charset.Charset.{Charset}

    pub def getHH(rd: InputStreamReader[r]): ##java.io.InputStreamReader = 
        let InputStreamReader(rd1) = rd;
        rd1

    pub def wrapHH(_: Region[r], prim: ##java.io.InputStreamReader): InputStreamReader[r] =
        InputStreamReader(prim)

    pub def newInputStreamReader(_: Region[r1], ins: InputStream[r], cs: Charset): InputStreamReader[r1] \ { Read(r), Write(r1) }= 
        import new java.io.InputStreamReader(##java.io.InputStream, ##java.nio.charset.Charset): ##java.io.InputStreamReader \ {r, r1} as newInputStreamReader;
        let Charset(cs1) = cs;
        let ins1 = Interop/IO/InputStream.getHH(ins);
        InputStreamReader(newInputStreamReader(ins1, cs1))

    /// None indicates end-of-stream.
    pub def read!(rd: InputStreamReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        Result.tryCatch(_ -> {
            import java.io.InputStreamReader.read(): Int32 \ r;
            let InputStreamReader(rd1) = rd;
            match read(rd1) { 
                case i if i < 0 => None
                case i          => Some(i)
            }
        })

    // read (into-array)
    pub def readSubArray!(buf: Array[Char, r2], 
                        offset: {offset = Int32}, 
                        len: {len = Int32}, 
                        rd: InputStreamReader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        Result.tryCatch(_ -> {
            import java.io.InputStreamReader.read(Array[Char, r2], Int32, Int32): Int32 \ {r, r2};
            let InputStreamReader(rd1) = rd;
            read(rd1, buf, offset.offset, len.len)
        })

    pub def getEncoding(rd: InputStreamReader[r]): String \ Read(r) = 
        import java.io.InputStreamReader.getEncoding(): String \ r;
        let InputStreamReader(rd1) = rd;
        getEncoding(rd1)

    pub def ready(rd: InputStreamReader[r]): Result[String, Bool] \ Read(r) = 
        Result.tryCatch(_ -> {
            import java.io.InputStreamReader.ready(): Bool \ r;
            let InputStreamReader(rd1) = rd;
            ready(rd1)
        })

    pub def close!(rd: InputStreamReader[r]): Result[String, Unit] \ Write(r) = 
        Result.tryCatch(_ -> {
            import java.io.InputStreamReader.close(): Unit \ r;
            let InputStreamReader(rd1) = rd;
            close(rd1)
        })

}
