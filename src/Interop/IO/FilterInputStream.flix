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

    pub enum FilterInputStream[_: Region](##java.io.FilterInputStream)

    instance Scoped[FilterInputStream] {
        pub def regionOf(_: FilterInputStream[r]): Region[r] = () as Region[r]
    }


    instance Interop/IO.SubInputStream[FilterInputStream] {
        pub def toInputStream(s: FilterInputStream[r]): InputStream[r] = 
            let FilterInputStream(s1) = s;
            InputStream(s1 as ##java.io.InputStream)

        pub def fromInputStream(s: InputStream[r]): FilterInputStream[r] = 
            let InputStream(s1) = s;
            FilterInputStream(s1 as ##java.io.FilterInputStream) 
    }


}

namespace Interop/IO/FilterInputStream {

    use Interop/IO.FilterInputStream;
    use Interop/IO.FilterInputStream.{FilterInputStream};
    use Interop/IO.File;
    use Interop/IO.File.{File};

    pub def getHH(ins: FilterInputStream[r]): ##java.io.FilterInputStream = 
        let FilterInputStream(ins1) = ins;
        ins1

    pub def wrapHH(_: Region[r], prim: ##java.io.FilterInputStream): FilterInputStream[r] =
        FilterInputStream(prim)


    pub def read!(rd: FilterInputStream[r]): Result[Option[Int32], String] \ IO = 
        try {
            import java.io.FilterInputStream.read(): Int32 \ { IO };
            let FilterInputStream(rd1) = rd;
            match read(rd1) { 
                case i if i < 0 => Ok(None)
                case i          => Ok(Some(i))
            }
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    // read (into-array) to figure out...
    pub def readIntoArray!(buf: Array[Int8, r2], ins: FilterInputStream[r]): Result[Int32, String] \ { Write(r2), IO } = 
        try {
            import java.io.FilterInputStream.read(Array[Int8, r2]): Int32 \ { IO };
            let FilterInputStream(ins1) = ins;
            read(ins1, buf) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // read (into-array)
    pub def readIntoArrayWith!(buf: Array[Int8, r2], 
                                offset: {offset :: Int32}, 
                                len: {len :: Int32}, 
                                ins: FilterInputStream[r]): Result[Int32, String] \ { Write(r2), IO } = 
        try {
            import java.io.FilterInputStream.read(Array[Int8, r2], Int32, Int32): Int32 \ { IO };
            let FilterInputStream(ins1) = ins;
            read(ins1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def skip!(n: Int64, ins: FilterInputStream[r]): Result[Int64, String] \ IO = 
        try {
            import java.io.FilterInputStream.skip(Int64): Int64 \ { IO };
            let FilterInputStream(ins1) = ins;
            skip(ins1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    /// Estimate!
    pub def available(ins: FilterInputStream[r]): Result[Int32, String] \ IO = 
        try {
            import java.io.FilterInputStream.available(): Int32 \ { IO };
            let FilterInputStream(ins1) = ins;
            available(ins1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def close!(ins: FilterInputStream[r]): Result[Unit, String] \ IO = 
        try {
            import java.io.FilterInputStream.close(): Unit \ { IO };
            let FilterInputStream(ins1) = ins;
            close(ins1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
