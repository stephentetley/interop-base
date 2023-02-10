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

    use Interop/IO.InputStream;
    use Interop/IO.InputStream.{InputStream};

    pub enum FilterInputStream[r: Region] { 
        case FilterInputStream(Region[r], ##java.io.FilterInputStream)
    }

    instance Interop/IO.SubInputStream[FilterInputStream] {
        pub def toInputStream(rc: Region[r1], s: FilterInputStream[r]): InputStream[r1] = 
            let FilterInputStream(_, s1) = s;
            InputStream(rc, unsafe_cast s1 as ##java.io.InputStream)

        pub def fromInputStream(rc: Region[r1], s: InputStream[r]): FilterInputStream[r1] = 
            let InputStream(_, s1) = s;
            FilterInputStream(rc, unsafe_cast s1 as ##java.io.FilterInputStream) 
    }


}

namespace Interop/IO/FilterInputStream {

    use Interop/IO.FilterInputStream;
    use Interop/IO.FilterInputStream.{FilterInputStream};
    use Interop/IO.File;
    use Interop/IO.File.{File};

    pub def getHH(s: FilterInputStream[r]): ##java.io.FilterInputStream = 
        let FilterInputStream(_, s1) = s;
        s1

    pub def wrapHH(rc: Region[r], prim: ##java.io.FilterInputStream): FilterInputStream[r] =
        FilterInputStream(rc, prim)


    pub def read!(s: FilterInputStream[r]): Result[String, Option[Int32]] \ Read(r) = 
        try {
            import java.io.FilterInputStream.read(): Int32 \ { r };
            let FilterInputStream(_, s1) = s;
            match read(s1) { 
                case i if i < 0 => Ok(None)
                case i          => Ok(Some(i))
            }
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    // read (into-array) to figure out...
    pub def readIntoArray!(buf: Array[Int8, r1], s: FilterInputStream[r]): Result[String, Int32] \ { Read(r), Write(r1)} = 
        try {
            import java.io.FilterInputStream.read(Array[Int8, r1]): Int32 \ { r, r1 };
            let FilterInputStream(_, s1) = s;
            read(s1, buf) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // read (into-array)
    pub def readIntoArrayWith!(buf: Array[Int8, r2], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                s: FilterInputStream[r]): Result[String, Int32] \ { Write(r2), IO } = 
        try {
            import java.io.FilterInputStream.read(Array[Int8, r2], Int32, Int32): Int32 \ { IO };
            let FilterInputStream(_, s1) = s;
            read(s1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def skip!(n: Int64, s: FilterInputStream[r]): Result[String, Int64] \ IO = 
        try {
            import java.io.FilterInputStream.skip(Int64): Int64 \ { IO };
            let FilterInputStream(_, s1) = s;
            skip(s1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    /// Estimate!
    pub def available(s: FilterInputStream[r]): Result[String, Int32] \ IO = 
        try {
            import java.io.FilterInputStream.available(): Int32 \ { IO };
            let FilterInputStream(_, s1) = s;
            available(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def close!(s: FilterInputStream[r]): Result[String, Unit] \ IO = 
        try {
            import java.io.FilterInputStream.close(): Unit \ { IO };
            let FilterInputStream(_, s1) = s;
            close(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
