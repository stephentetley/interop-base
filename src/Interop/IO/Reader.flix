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
    /// Mutable, no alloc
    pub enum Reader[_: Region](##java.io.Reader)


    pub class SubReader[t: Region -> Type] {
        pub def toReader(s: t[r]): Reader[r]
        pub def fromReader(s: Reader[r]): t[r]
    }


}


namespace Interop/IO/Reader {

    use Interop/IO.Reader;
    use Interop/IO.Reader.{Reader};
    use Interop/IO.Writer;
    use Interop/IO.SubReader;
    use Interop/NIO.CharBuffer;



    pub def getHH(rd: Reader[r]): ##java.io.Reader = 
        let Reader(rd1) = rd;
        rd1

    pub def wrapHH(_: Region[r], prim: ##java.io.Reader): Reader[r] =
        Reader(prim)


    pub def close!(rd: Reader[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.close(): Unit \ r;
            let Reader(rd1) = rd;
            close(rd1)
        })
    
    pub def mark!(limit: Int32, rd: Reader[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.mark(Int32): Unit \ r;
            let Reader(rd1) = rd;
            mark(rd1, limit)
        })

    // Dont'provide `markSupported` should be overwritten by subclasses
    
    // read (into-array)
    pub def readArray(buf: Array[Char, r2], rd: Reader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.read(Array[Char, r2]): Int32 \ {r, r2};
            let Reader(rd1) = rd;
            read(rd1, buf)
        })

    // read (into-array)
    pub def readSubArray(buf: Array[Char, r2], 
                            offset: {offset = Int32}, 
                            len: {len = Int32}, 
                            rd: Reader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.read(Array[Char, r2], Int32, Int32): Int32 \ {r, r2};
            let Reader(rd1) = rd;
            read(rd1, buf, offset.offset, len.len)
        })

    // read into CharBuffer
    pub def readCharBuffer(buf: CharBuffer[r2], rd: Reader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.read(##java.nio.CharBuffer): Int32 \ {r, r2};
            let Reader(rd1) = rd;
            let buf1 = Interop/NIO/CharBuffer.getHH(buf);
            read(rd1, buf1)
        })

    pub def reset!(rd: Reader[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.reset(): Unit \ r;
            let Reader(rd1) = rd;
            reset(rd1)
        })

    pub def skip!(n: Int64, rd: Reader[r]): Result[String, Int64] \ Read(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.skip(Int64): Int64 \ r;
            let Reader(rd1) = rd;
            skip(rd1, n)
        })

    pub def transferTo!(outw: Writer[r2], rd: Reader[r]): Result[String, Int64] \ {Read(r), Write(r2)} =
        Interop/Flix/Util.try(_ -> {
            import java.io.Reader.transferTo(##java.io.Writer): Int64 \ {r, r2};
            let Reader(rd1) = rd;
            let outw1 = Interop/IO/Writer.getHH(outw);
            transferTo(rd1, outw1)
        })

}
