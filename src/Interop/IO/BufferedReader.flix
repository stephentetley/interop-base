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

    /// Class

    pub enum BufferedReader[_: Region](##java.io.BufferedReader)

    instance Interop/IO.SubReader[BufferedReader] {
        pub def toReader(s: BufferedReader[r]): Reader[r] = 
            let BufferedReader(s1) = s;
            Reader(unsafe_cast s1 as ##java.io.Reader)

        pub def fromReader(s: Reader[r]): BufferedReader[r] = 
            let Reader(s1) = s;
            BufferedReader(unsafe_cast s1 as ##java.io.BufferedReader) 
    }

}

namespace Interop/IO/BufferedReader {

    use Interop/IO.BufferedReader;
    use Interop/IO.BufferedReader.{BufferedReader};
    use Interop/IO.Reader;

    use Interop/Util/Stream.Stream;
    use Interop/Util/Stream.Stream.{Stream};

    pub def getHH(rd: BufferedReader[r]): ##java.io.BufferedReader = 
        let BufferedReader(rd1) = rd;
        rd1

    pub def wrapHH(_: Region[r], prim: ##java.io.BufferedReader): BufferedReader[r] = 
        BufferedReader(prim)


    pub def newWithReader(_: Region[r1], rd: Reader[r]): BufferedReader[r1] \ { Read(r), Write(r1) } =  
        import new java.io.BufferedReader(##java.io.Reader): ##java.io.BufferedReader \ {r, r1} as newBufferedReader;
        let rd1 = Interop/IO/Reader.getHH(rd); 
        BufferedReader(newBufferedReader(rd1))


    pub def newWithSize(_: Region[r1], rd: Reader[r], size: Int32): BufferedReader[r1] \ { Read(r), Write(r1) } = 
        import new java.io.BufferedReader(##java.io.Reader, Int32): ##java.io.BufferedReader \ {r, r1} as newBufferedReader;
        let rd1 = Interop/IO/Reader.getHH(rd);
        BufferedReader(newBufferedReader(rd1, size))

    // read

    /// None indicates end-of-stream.
    pub def read!(rd: BufferedReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.read(): Int32 \ r;
            let BufferedReader(rd1) = rd;
            match read(rd1) { 
                case i if i < 0 => None
                case i          => Some(i)
            }
        })

    // read (into-array)
    pub def readSubArray!(buf: Array[Char, r2], 
                            offset: {offset = Int32}, 
                            len: {len = Int32}, 
                            rd: BufferedReader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.read(Array[Char, r2], Int32, Int32): Int32 \ {r, r2};
            let BufferedReader(rd1) = rd;
            read(rd1, buf, offset.offset, len.len)
        })

    
    pub def readLine!(rd: BufferedReader[r]): Result[String, String] \ Read(r) = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.readLine(): String \ r;
            let BufferedReader(rd1) = rd;
            readLine(rd1)
        })

    pub def ready(rd: BufferedReader[r]): Result[String, Bool] \ Read(r) = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.ready(): Bool \ r;
            let BufferedReader(rd1) = rd;
            ready(rd1)
        })

    pub def markSupported(rd: BufferedReader[r]): Bool \ Read(r) = 
        import java.io.BufferedReader.markSupported(): Bool \ r;
        let BufferedReader(rd1) = rd;
        markSupported(rd1)


    pub def mark!(readAheadLimit: Int32, rd: BufferedReader[r]): Result[String, Unit] \ Write(r) = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.mark(Int32): Unit \ r;
            let BufferedReader(rd1) = rd;
            mark(rd1, readAheadLimit)
        })

    pub def reset!(rd: BufferedReader[r]): Result[String, Unit] \ Write(r) = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.reset(): Unit \ r;
            let BufferedReader(rd1) = rd;
            reset(rd1)
        })

    pub def close!(rd: BufferedReader[r]): Result[String, Unit] \ Write(r) = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.close(): Unit \ r;
            let BufferedReader(rd1) = rd;
            close(rd1)
        })

    pub def lines!(rc: Region[r1], rd: BufferedReader[r]): Result[String, Stream[String, r1]] \ { Read(r), Write(r1) } = 
        Interop/Flix/Util.try(_ -> {
            import java.io.BufferedReader.lines(): ##java.util.stream.Stream \ {r, r1};
            let BufferedReader(rd1) = rd;
            Stream(rc, lines(rd1))
        })


}
