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

    use Interop/IO.OutputStream;
    use Interop/IO.OutputStream.{OutputStream};

    pub enum FileOutputStream[_: Region](##java.io.FileOutputStream)

    instance Interop/IO.SubOutputStream[FileOutputStream] {
        pub def toOutputStream(s: FileOutputStream[r]): OutputStream[r] = 
            let FileOutputStream(s1) = s;
            OutputStream(unsafe_cast s1 as ##java.io.OutputStream)

        pub def fromOutputStream(s: OutputStream[r]): FileOutputStream[r] = 
            let OutputStream(s1) = s;
            FileOutputStream(unsafe_cast s1 as ##java.io.FileOutputStream) 
    }


}

namespace Interop/IO/FileOutputStream {

    use Interop/IO.FileOutputStream;
    use Interop/IO.FileOutputStream.{FileOutputStream};
    use Interop/IO.File;
    use Interop/IO.File.{File};

    pub def getHH(ous: FileOutputStream[r]): ##java.io.FileOutputStream = 
        let FileOutputStream(ous1) = ous;
        ous1

    pub def wrapHH(_: Region[r], prim: ##java.io.FileOutputStream): FileOutputStream[r] =
        FileOutputStream(prim)


    pub def newWithFile(file: File[r]): Result[FileOutputStream[r], String] \ {Write(r), IO} = 
        try {
            import new java.io.FileOutputStream(##java.io.File): ##java.io.FileOutputStream \ IO as newOutputStream;
            let file1 = Interop/IO/File.getHH(file);
            newOutputStream(file1) |> FileOutputStream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ r;
                Err(getMessage(ex))
        }

    pub def newWithPath(path: String): Result[FileOutputStream[r], String] \ {Write(r), IO} = 
        try {
            import new java.io.FileOutputStream(String): ##java.io.FileOutputStream \ IO as newOutputStream;
            newOutputStream(path) |> FileOutputStream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }



    pub def write!(b: Int32, fos: FileOutputStream[r]): Result[Unit, String] \ IO = 
        try {
            import java.io.FileOutputStream.write(Int32): Unit \ { IO };
            let FileOutputStream(fos1) = fos;
            write(fos1, b) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def close!(fos: FileOutputStream[r]): Result[Unit, String] \ IO = 
        try {
            import java.io.FileOutputStream.close(): Unit \ { IO };
            let FileOutputStream(fos1) = fos;
            close(fos1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
