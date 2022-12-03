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

    
    /// Mutable

    pub enum File[_: Region](##java.io.File)

    instance Scoped[File] {
        pub def regionOf(_: File[r]): Region[r] = unsafe_cast () as Region[r]
    }


}

namespace Interop/IO/File {

    use Interop/IO.File;
    use Interop/IO.File.{File};

    use Interop/NIO/File.Path;
    use Interop/NIO/File.Path.{Path};

    pub def getHH(wr: File[r]): ##java.io.File = 
        let File(wr1) = wr;
        wr1

    pub def wrapHH(_: Region[r], prim: ##java.io.File): File[r] = 
        File(prim)


    pub def newFile[r: Region](_: Region[r], path: String): File[r] \ { Write(r), IO } = 
        import new java.io.File(String): ##java.io.File \ { Write(r), IO } as newFile;
        File(newFile(path))


    pub def toPath(file: File[r]): Result[Path, String] \ Read(r) =
        try {
            import java.io.File.toPath(): ##java.nio.file.Path \ r;
            let File(file1) = file;
            toPath(file1) |> Path |> Ok
       } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
