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

    instance Scoped[FileOutputStream] {
        pub def regionOf(_: FileOutputStream[r]): Region[r] = () as Region[r]
    }


    instance Interop/IO.SubOutputStream[FileOutputStream] {
        pub def ucast(s: FileOutputStream[r]): OutputStream[r] = 
            let FileOutputStream(s1) = s;
            OutputStream(s1 as ##java.io.OutputStream)

        pub def dcast(s: OutputStream[r]): FileOutputStream[r] = 
            let OutputStream(s1) = s;
            FileOutputStream(s1 as ##java.io.FileOutputStream) 
    }


}

namespace Interop/IO/FileOutputStream {

    use Interop/IO.FileOutputStream;
    use Interop/IO.FileOutputStream.{FileOutputStream};

    pub def getHH(ous: FileOutputStream[r]): ##java.io.FileOutputStream = 
        let FileOutputStream(ous1) = ous;
        ous1

    pub def newFileOutputStream(_: Region[r], file: ##java.io.File): Result[FileOutputStream[r], String] \ {Write(r), IO} = 
        try {
            import new java.io.FileOutputStream(##java.io.File): ##java.io.FileOutputStream \ IO as newOutputStream;
            FileOutputStream(newOutputStream(file)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }

}
