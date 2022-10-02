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

    instance Scoped[BufferedReader] {
        pub def regionOf(_: BufferedReader[r]): Region[r] = () as Region[r]
    }

    instance Interop/IO.SubReader[BufferedReader] {
        pub def toReader(s: BufferedReader[r]): Reader[r] = 
            let BufferedReader(s1) = s;
            Reader(s1 as ##java.io.Reader)

        pub def fromReader(s: Reader[r]): BufferedReader[r] = 
            let Reader(s1) = s;
            BufferedReader(s1 as ##java.io.BufferedReader) 
    }

}

namespace Interop/IO/BufferedReader {

    use Interop/IO.BufferedReader;
    use Interop/IO.BufferedReader.{BufferedReader};

    use Interop/Util/Stream.Stream;
    use Interop/Util/Stream.Stream.{Stream};

    pub def getHH(rd: BufferedReader[r]): ##java.io.BufferedReader = 
        let BufferedReader(rd1) = rd;
        rd1

    pub def wrapHH(_: Region[r], prim: ##java.io.BufferedReader): BufferedReader[r] = 
        BufferedReader(prim)


    // read

    pub def read!(rd: BufferedReader[r]): Result[Option[Int32], String] \ IO = 
        try {
            import java.io.BufferedReader.read(): Int32 \ { IO };
            let BufferedReader(rd1) = rd;
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
    pub def readIntoArrayWith!(buf: Array[Char, r2], offset: {offset :: Int32}, len: {len :: Int32}, rd: BufferedReader[r]): Result[Int32, String] \ { Write(r2), IO } = 
        try {
            import java.io.BufferedReader.read(Array[Char, r2], Int32, Int32): Int32 \ { IO };
            let BufferedReader(rd1) = rd;
            read(rd1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    
    pub def readLine!(rd: BufferedReader[r]): Result[String, String] \ IO = 
        try {
            import java.io.BufferedReader.readLine(): String \ { IO };
            let BufferedReader(rd1) = rd;
            readLine(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def ready(rd: BufferedReader[r]): Result[Bool, String] \ IO = 
        try {
            import java.io.BufferedReader.ready(): Bool \ { IO };
            let BufferedReader(rd1) = rd;
            ready(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def markSupported(rd: BufferedReader[r]): Bool \ IO = 
        import java.io.BufferedReader.markSupported(): Bool \ { IO };
        let BufferedReader(rd1) = rd;
        markSupported(rd1)


    pub def mark!(readAheadLimit: Int32, rd: BufferedReader[r]): Result[Unit, String] \ IO = 
        try {
            import java.io.BufferedReader.mark(Int32): Unit \ { IO };
            let BufferedReader(rd1) = rd;
            mark(rd1, readAheadLimit) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def reset!(rd: BufferedReader[r]): Result[Unit, String] \ IO = 
        try {
            import java.io.BufferedReader.reset(): Unit \ { IO };
            let BufferedReader(rd1) = rd;
            reset(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(rd: BufferedReader[r]): Result[Unit, String] \ IO = 
        try {
            import java.io.BufferedReader.close(): Unit \ { IO };
            let BufferedReader(rd1) = rd;
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def lines!(rd: BufferedReader[r]): Result[Stream[String, r], String] \ IO = 
        try {
            import java.io.BufferedReader.lines(): ##java.util.stream.Stream \ { IO };
            let BufferedReader(rd1) = rd;
            lines(rd1) |> Stream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
