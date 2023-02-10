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
    pub enum FileInputStream[r: Region] { 
        case FileInputStream(Region[r], ##java.io.FileInputStream)
    }


    instance Interop/IO.SubInputStream[FileInputStream] {
        pub def toInputStream(rc: Region[r1], s: FileInputStream[r]): InputStream[r1] = 
            let FileInputStream(_, s1) = s;
            InputStream(rc, unsafe_cast s1 as ##java.io.InputStream)

        pub def fromInputStream(rc: Region[r1], s: InputStream[r]): FileInputStream[r1] = 
            let InputStream(_, s1) = s;
            FileInputStream(rc, unsafe_cast s1 as ##java.io.FileInputStream) 
    }


}

namespace Interop/IO/FileInputStream {

    use Interop/IO.FileInputStream;
    use Interop/IO.FileInputStream.{FileInputStream};
    use Interop/IO.File;
    use Interop/IO.File.{File};

    pub def getHH(s: FileInputStream[r]): ##java.io.FileInputStream = 
        let FileInputStream(_, s1) = s;
        s1

    pub def wrapHH(rc: Region[r], prim: ##java.io.FileInputStream): FileInputStream[r] =
        FileInputStream(rc, prim)

    pub def newWithFile(rc: Region[r1], file: File[r]): Result[String, FileInputStream[r1]] \ { Read(r), Write(r), IO} = 
        try {
            import new java.io.FileInputStream(##java.io.File): ##java.io.FileInputStream \ {r, r1, IO} as newFileInputStream;
            let file1 = Interop/IO/File.getHH(file);
            FileInputStream(rc, newFileInputStream(file1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def newWithPath(rc: Region[r], path: String): Result[String, FileInputStream[r]] \ {Write(r), IO} = 
        try {
            import new java.io.FileInputStream(String): ##java.io.FileInputStream \ {IO, r} as newFileInputStream;
            FileInputStream(rc, newFileInputStream(path)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }



    pub def read!(s: FileInputStream[r]): Result[String, Option[Int32]] \ { Read(r), IO } = 
        try {
            import java.io.FileInputStream.read(): Int32 \ { IO };
            let FileInputStream(_, s1) = s;
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
    pub def readIntoArray!(buf: Array[Int8, r1], s: FileInputStream[r]): Result[String, Int32] \ { Read(r), Write(r1), IO } = 
        try {
            import java.io.FileInputStream.read(Array[Int8, r1]): Int32 \ { r, r1, IO };
            let FileInputStream(_, s1) = s;
            read(s1, buf) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // read (into-array)
    pub def readIntoArrayWith!(buf: Array[Int8, r1], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                s: FileInputStream[r]): Result[String, Int32] \ { Read(r), Write(r1), IO } = 
        try {
            import java.io.FileInputStream.read(Array[Int8, r1], Int32, Int32): Int32 \ { r, r1, IO };
            let FileInputStream(_, s1) = s;
            read(s1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def skip!(n: Int64, s: FileInputStream[r]): Result[String, Int64] \ { Write(r), IO } = 
        try {
            import java.io.FileInputStream.skip(Int64): Int64 \ { r, IO };
            let FileInputStream(_, s1) = s;
            skip(s1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    /// Estimate!
    pub def available(s: FileInputStream[r]): Result[String, Int32] \ { Read(r), IO } = 
        try {
            import java.io.FileInputStream.available(): Int32 \ { r, IO };
            let FileInputStream(_, s1) = s;
            available(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def close!(s: FileInputStream[r]): Result[String, Unit] \ { Write(r), IO } = 
        try {
            import java.io.FileInputStream.close(): Unit \ { r, IO };
            let FileInputStream(_, s1) = s;
            close(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // getFD
    // getChannel

}
