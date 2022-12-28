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

    pub def getHH(ins: FileInputStream[r]): ##java.io.FileInputStream = 
        let FileInputStream(ins1) = ins;
        ins1

    pub def wrapHH(_: Region[r], prim: ##java.io.FileInputStream): FileInputStream[r] =
        FileInputStream(prim)

    pub def newWithFile(file: File[r]): Result[String, FileInputStream[r]] \ {Write(r), IO} = 
        try {
            import new java.io.FileInputStream(##java.io.File): ##java.io.FileInputStream \ {IO, r} as newFileInputStream;
            let file1 = Interop/IO/File.getHH(file);
            newFileInputStream(file1) |> FileInputStream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def newWithPath(_: Region[r], path: String): Result[String, FileInputStream[r]] \ {Write(r), IO} = 
        try {
            import new java.io.FileInputStream(String): ##java.io.FileInputStream \ {IO, r} as newFileInputStream;
            newFileInputStream(path) |> FileInputStream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }



    pub def read!(rd: FileInputStream[r]): Result[String, Option[Int32]] \ IO = 
        try {
            import java.io.FileInputStream.read(): Int32 \ { IO };
            let FileInputStream(rd1) = rd;
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
    pub def readIntoArray!(buf: Array[Int8, r2], ins: FileInputStream[r]): Result[String, Int32] \ { Write(r2), IO } = 
        try {
            import java.io.FileInputStream.read(Array[Int8, r2]): Int32 \ { IO };
            let FileInputStream(ins1) = ins;
            read(ins1, buf) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // read (into-array)
    pub def readIntoArrayWith!(buf: Array[Int8, r2], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                ins: FileInputStream[r]): Result[String, Int32] \ { Write(r2), IO } = 
        try {
            import java.io.FileInputStream.read(Array[Int8, r2], Int32, Int32): Int32 \ { IO };
            let FileInputStream(ins1) = ins;
            read(ins1, buf, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def skip!(n: Int64, ins: FileInputStream[r]): Result[String, Int64] \ IO = 
        try {
            import java.io.FileInputStream.skip(Int64): Int64 \ { IO };
            let FileInputStream(ins1) = ins;
            skip(ins1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    /// Estimate!
    pub def available(ins: FileInputStream[r]): Result[String, Int32] \ IO = 
        try {
            import java.io.FileInputStream.available(): Int32 \ { IO };
            let FileInputStream(ins1) = ins;
            available(ins1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def close!(ins: FileInputStream[r]): Result[String, Unit] \ IO = 
        try {
            import java.io.FileInputStream.close(): Unit \ { IO };
            let FileInputStream(ins1) = ins;
            close(ins1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // getFD
    // getChannel

}
