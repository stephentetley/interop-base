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

    use Interop.IO.FileOutputStream
    use Interop.IO.FileOutputStream.{FileOutputStream}
    use Interop.IO.OutputStream
    use Interop.IO.OutputStream.{OutputStream}

    pub enum FileOutputStream[_: Region](##java.io.FileOutputStream)


    instance Interop.IO.SubOutputStream[FileOutputStream] {
        pub def toOutputStream(s: FileOutputStream[r]): OutputStream[r] = 
            let FileOutputStream(s1) = s;
            OutputStream(unchecked_cast(s1 as ##java.io.OutputStream))

        pub def fromOutputStream(s: OutputStream[r]): FileOutputStream[r] = 
            let OutputStream(s1) = s;
            FileOutputStream(unchecked_cast(s1 as ##java.io.FileOutputStream))
    }


}

mod Interop.IO.FileOutputStream {

    use Interop.IO.FileOutputStream
    use Interop.IO.FileOutputStream.{FileOutputStream}
    use Interop.IO.File
    use Interop.IO.File.{File}

    pub def getHH(s: FileOutputStream[r]): ##java.io.FileOutputStream = 
        let FileOutputStream(s1) = s;
        s1

    pub def wrapHH(_: Region[r], prim: ##java.io.FileOutputStream): FileOutputStream[r] =
        FileOutputStream(prim)


    pub def makeWithFile(_: Region[r1], file: File[r]): Result[String, FileOutputStream[r1]] \ {IO, r, r1} = 
        Result.tryCatch(_ -> {
            import java_new java.io.FileOutputStream(##java.io.File): ##java.io.FileOutputStream \ {IO, r, r1} as newOutputStream;
            let file1 = Interop.IO.File.getHH(file);
            FileOutputStream(newOutputStream(file1))
        })

    pub def makeWithPath(_: Region[r], path: String): Result[String, FileOutputStream[r]] \ {IO, r} = 
        Result.tryCatch(_ -> {
            import java_new java.io.FileOutputStream(String): ##java.io.FileOutputStream \ {IO, r} as newOutputStream;
            FileOutputStream(newOutputStream(path))
        })



    pub def write!(b: Int32, s: FileOutputStream[r]): Result[String, Unit] \ {IO, r} = 
        Result.tryCatch(_ -> {
            import java.io.FileOutputStream.write(Int32): Unit \ {IO, r};
            let FileOutputStream(s1) = s;
            write(s1, b)
        })


    pub def close!(s: FileOutputStream[r]): Result[String, Unit] \ {IO, r} = 
        Result.tryCatch(_ -> {
            import java.io.FileOutputStream.close(): Unit \ {IO, r};
            let FileOutputStream(s1) = s;
            close(s1)
        })

}
