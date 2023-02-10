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

    use Interop/IO.OutputStream
    use Interop/IO.OutputStream.{OutputStream}

    pub enum FileOutputStream[r: Region] { 
        case FileOutputStream(Region[r], ##java.io.FileOutputStream)
    }

    instance Interop/IO.SubOutputStream[FileOutputStream] {
        pub def toOutputStream(rc: Region[r1], s: FileOutputStream[r]): OutputStream[r1] = 
            let FileOutputStream(_, s1) = s;
            OutputStream(rc, unsafe_cast s1 as ##java.io.OutputStream)

        pub def fromOutputStream(rc: Region[r1], s: OutputStream[r]): FileOutputStream[r1] = 
            let OutputStream(_, s1) = s;
            FileOutputStream(rc, unsafe_cast s1 as ##java.io.FileOutputStream) 
    }


}

namespace Interop/IO/FileOutputStream {

    use Interop/IO.FileOutputStream
    use Interop/IO.FileOutputStream.{FileOutputStream}
    use Interop/IO.File
    use Interop/IO.File.{File}

    pub def getHH(s: FileOutputStream[r]): ##java.io.FileOutputStream = 
        let FileOutputStream(_, s1) = s;
        s1

    pub def wrapHH(rc: Region[r], prim: ##java.io.FileOutputStream): FileOutputStream[r] =
        FileOutputStream(rc, prim)


    pub def newWithFile(rc: Region[r1], file: File[r]): Result[String, FileOutputStream[r1]] \ {Read(r), Write(r1), IO} = 
        try {
            import new java.io.FileOutputStream(##java.io.File): ##java.io.FileOutputStream \ {Read(r), Write(r1), IO} as newOutputStream;
            let file1 = Interop/IO/File.getHH(file);
            FileOutputStream(rc, newOutputStream(file1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ r;
                Err(getMessage(ex))
        }

    pub def newWithPath(rc: Region[r], path: String): Result[String, FileOutputStream[r]] \ { Write(r), IO } = 
        try {
            import new java.io.FileOutputStream(String): ##java.io.FileOutputStream \ {r, IO} as newOutputStream;
            FileOutputStream(rc, newOutputStream(path)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }



    pub def write!(b: Int32, s: FileOutputStream[r]): Result[String, Unit] \ { Write(r), IO } = 
        try {
            import java.io.FileOutputStream.write(Int32): Unit \ { r, IO };
            let FileOutputStream(_, s1) = s;
            write(s1, b) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def close!(s: FileOutputStream[r]): Result[String, Unit] \ { Write(r), IO } = 
        try {
            import java.io.FileOutputStream.close(): Unit \ { r, IO };
            let FileOutputStream(_, s1) = s;
            close(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
