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


    // "read pointer"
    pub enum FileInputStream[_: Region](##java.io.FileInputStream)
    


    instance Interop/IO.SubInputStream[FileInputStream] {
        pub def toInputStream(s: FileInputStream[r]): InputStream[r] = 
            let FileInputStream(s1) = s;
            InputStream(unsafe_cast s1 as ##java.io.InputStream)

        pub def fromInputStream(s: InputStream[r]): FileInputStream[r] = 
            let InputStream(s1) = s;
            FileInputStream(unsafe_cast s1 as ##java.io.FileInputStream) 
    }


}

namespace Interop/IO/FileInputStream {

    use Interop/IO.FileInputStream;
    use Interop/IO.FileInputStream.{FileInputStream};
    use Interop/IO.File;
    use Interop/IO.File.{File};

    pub def getHH(s: FileInputStream[r]): ##java.io.FileInputStream = 
        let FileInputStream(s1) = s;
        s1

    pub def wrapHH(_: Region[r], prim: ##java.io.FileInputStream): FileInputStream[r] =
        FileInputStream(prim)

    pub def newWithFile(_: Region[r1], file: File[r]): Result[String, FileInputStream[r1]] \ { Read(r), Write(r), IO} = 
        Result.tryCatch(_ -> {
            import new java.io.FileInputStream(##java.io.File): ##java.io.FileInputStream \ {r, r1, IO} as newFileInputStream;
            let file1 = Interop/IO/File.getHH(file);
            FileInputStream(newFileInputStream(file1))
        })

    pub def newWithPath(_: Region[r], path: String): Result[String, FileInputStream[r]] \ {Write(r), IO} = 
        Result.tryCatch(_ -> {
            import new java.io.FileInputStream(String): ##java.io.FileInputStream \ {IO, r} as newFileInputStream;
            FileInputStream(newFileInputStream(path))
        })



    pub def read!(s: FileInputStream[r]): Result[String, Option[Int32]] \ { Read(r), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FileInputStream.read(): Int32 \ { IO };
            let FileInputStream(s1) = s;
            match read(s1) { 
                case i if i < 0 => None
                case i          => Some(i)
            }
        })

    // read (into-array) to figure out...
    pub def readIntoArray!(buf: Array[Int8, r1], s: FileInputStream[r]): Result[String, Int32] \ { Read(r), Write(r1), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FileInputStream.read(Array[Int8, r1]): Int32 \ { r, r1, IO };
            let FileInputStream(s1) = s;
            read(s1, buf)
        })


    // read (into-array)
    pub def readIntoArrayWith!(buf: Array[Int8, r1], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                s: FileInputStream[r]): Result[String, Int32] \ { Read(r), Write(r1), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FileInputStream.read(Array[Int8, r1], Int32, Int32): Int32 \ { r, r1, IO };
            let FileInputStream(s1) = s;
            read(s1, buf, offset.offset, len.len)
        })

    pub def skip!(n: Int64, s: FileInputStream[r]): Result[String, Int64] \ { Write(r), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FileInputStream.skip(Int64): Int64 \ { r, IO };
            let FileInputStream(s1) = s;
            skip(s1, n)
        })

    /// Estimate!
    pub def available(s: FileInputStream[r]): Result[String, Int32] \ { Read(r), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FileInputStream.available(): Int32 \ { r, IO };
            let FileInputStream(s1) = s;
            available(s1)
        })


    pub def close!(s: FileInputStream[r]): Result[String, Unit] \ { Write(r), IO } = 
        Result.tryCatch(_ -> {
            import java.io.FileInputStream.close(): Unit \ { r, IO };
            let FileInputStream(s1) = s;
            close(s1)
        })


    // getFD
    // getChannel

}
