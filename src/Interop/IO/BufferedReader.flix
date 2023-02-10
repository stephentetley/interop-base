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

    pub enum BufferedReader[r: Region] { 
        case BufferedReader(Region[r], ##java.io.BufferedReader)
    }

    instance Interop/IO.SubReader[BufferedReader] {
        pub def toReader(rc: Region[r1], s: BufferedReader[r]): Reader[r1] = 
            let BufferedReader(_, s1) = s;
            Reader(rc, unsafe_cast s1 as ##java.io.Reader)

        pub def fromReader(rc: Region[r1], s: Reader[r]): BufferedReader[r1] = 
            let Reader(_, s1) = s;
            BufferedReader(rc, unsafe_cast s1 as ##java.io.BufferedReader) 
    }

}

namespace Interop/IO/BufferedReader {

    use Interop/IO.BufferedReader;
    use Interop/IO.BufferedReader.{BufferedReader};
    use Interop/IO.Reader;

    use Interop/Util/Stream.Stream;
    use Interop/Util/Stream.Stream.{Stream};

    pub def getHH(rd: BufferedReader[r]): ##java.io.BufferedReader = 
        let BufferedReader(_, rd1) = rd;
        rd1

    pub def wrapHH(rc: Region[r], prim: ##java.io.BufferedReader): BufferedReader[r] = 
        BufferedReader(rc, prim)


    pub def newWithReader(rc: Region[r1], rd: Reader[r]): BufferedReader[r1] \ { Read(r), Write(r1) } =  
        import new java.io.BufferedReader(##java.io.Reader): ##java.io.BufferedReader \ {r, r1} as newBufferedReader;
        let rd1 = Interop/IO/Reader.getHH(rd); 
        BufferedReader(rc, newBufferedReader(rd1))


    pub def newWithSize(rc: Region[r1], rd: Reader[r], size: Int32): BufferedReader[r1] \ { Read(r), Write(r1) } = 
        import new java.io.BufferedReader(##java.io.Reader, Int32): ##java.io.BufferedReader \ {r, r1} as newBufferedReader;
        let rd1 = Interop/IO/Reader.getHH(rd);
        BufferedReader(rc, newBufferedReader(rd1, size))

    // read

    /// None indicates end-of-stream.
    pub def read!(rd: BufferedReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        try {
            import java.io.BufferedReader.read(): Int32 \ r;
            let BufferedReader(_, rd1) = rd;
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
                            rd: BufferedReader[r]): Result[String, Int32] \ { Write(r2), Read(r) } = 
        try {
            import java.io.BufferedReader.read(Array[Char, r2], Int32, Int32): Int32 \ {r, r2};
            let BufferedReader(_, rd1) = rd;
            read(rd1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    
    pub def readLine!(rd: BufferedReader[r]): Result[String, String] \ Read(r) = 
        try {
            import java.io.BufferedReader.readLine(): String \ r;
            let BufferedReader(_, rd1) = rd;
            readLine(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def ready(rd: BufferedReader[r]): Result[String, Bool] \ Read(r) = 
        try {
            import java.io.BufferedReader.ready(): Bool \ r;
            let BufferedReader(_, rd1) = rd;
            ready(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def markSupported(rd: BufferedReader[r]): Bool \ Read(r) = 
        import java.io.BufferedReader.markSupported(): Bool \ r;
        let BufferedReader(_, rd1) = rd;
        markSupported(rd1)


    pub def mark!(readAheadLimit: Int32, rd: BufferedReader[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.io.BufferedReader.mark(Int32): Unit \ r;
            let BufferedReader(_, rd1) = rd;
            mark(rd1, readAheadLimit) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def reset!(rd: BufferedReader[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.io.BufferedReader.reset(): Unit \ r;
            let BufferedReader(_, rd1) = rd;
            reset(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(rd: BufferedReader[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.io.BufferedReader.close(): Unit \ r;
            let BufferedReader(_, rd1) = rd;
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def lines!(rc: Region[r1], rd: BufferedReader[r]): Result[String, Stream[String, r1]] \ Read(r) = 
        try {
            import java.io.BufferedReader.lines(): ##java.util.stream.Stream \ r;
            let BufferedReader(_, rd1) = rd;
            Stream(rc, lines(rd1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
