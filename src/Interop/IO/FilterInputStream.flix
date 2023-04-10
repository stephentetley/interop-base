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

mod Interop.IO {

    use Interop.IO.FilterInputStream
    use Interop.IO.FilterInputStream.{FilterInputStream}
    use Interop.IO.InputStream
    use Interop.IO.InputStream.{InputStream}

    pub enum FilterInputStream[_: Region](##java.io.FilterInputStream)


    instance Interop.IO.SubInputStream[FilterInputStream] {
        pub def toInputStream(s: FilterInputStream[r]): InputStream[r] = 
            let FilterInputStream(s1) = s;
            InputStream(unchecked_cast(s1 as ##java.io.InputStream))

        pub def fromInputStream(s: InputStream[r]): FilterInputStream[r] = 
            let InputStream(s1) = s;
            FilterInputStream(unchecked_cast(s1 as ##java.io.FilterInputStream))
    }


}

mod Interop.IO.FilterInputStream {

    use Interop.IO.FilterInputStream
    use Interop.IO.FilterInputStream.{FilterInputStream}
    use Interop.IO.File
    use Interop.IO.File.{File}

    pub def getHH(s: FilterInputStream[r]): ##java.io.FilterInputStream = 
        let FilterInputStream(s1) = s;
        s1

    pub def wrapHH(_: Region[r], prim: ##java.io.FilterInputStream): FilterInputStream[r] =
        FilterInputStream(prim)


    pub def read!(s: FilterInputStream[r]): Result[String, Option[Int32]] \ Read(r) = 
        Result.tryCatch(_ -> {
            import java.io.FilterInputStream.read(): Int32 \ { r };
            let FilterInputStream(s1) = s;
            match read(s1) { 
                case i if i < 0 => None
                case i          => Some(i)
            }
        })

    // read (into-array) to figure out...
    pub def readIntoArray!(buf: Array[Int8, r1], s: FilterInputStream[r]): Result[String, Int32] \ { Read(r), Write(r1)} = 
        Result.tryCatch(_ -> {
            import java.io.FilterInputStream.read(Array[Int8, r1]): Int32 \ { r, r1 };
            let FilterInputStream(s1) = s;
            read(s1, buf)
        })


    // read (into-array)
    pub def readIntoArrayWith!(buf: Array[Int8, r2], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                s: FilterInputStream[r]): Result[String, Int32] \ { Write(r2), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FilterInputStream.read(Array[Int8, r2], Int32, Int32): Int32 \ { IO };
            let FilterInputStream(s1) = s;
            read(s1, buf, offset.offset, len.len)
        })

    pub def skip!(n: Int64, s: FilterInputStream[r]): Result[String, Int64] \ IO = 
        Result.tryCatch(_ -> {
            import java.io.FilterInputStream.skip(Int64): Int64 \ { IO };
            let FilterInputStream(s1) = s;
            skip(s1, n)
        })


    /// Estimate!
    pub def available(s: FilterInputStream[r]): Result[String, Int32] \ IO = 
        Result.tryCatch(_ -> {
            import java.io.FilterInputStream.available(): Int32 \ { IO };
            let FilterInputStream(s1) = s;
            available(s1)
        })


    pub def close!(s: FilterInputStream[r]): Result[String, Unit] \ IO = 
        Result.tryCatch(_ -> {
            import java.io.FilterInputStream.close(): Unit \ { IO };
            let FilterInputStream(s1) = s;
            close(s1)
        })

}
