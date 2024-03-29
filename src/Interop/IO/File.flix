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

    
    /// Mutable, no alloc

    pub enum File[_: Region](##java.io.File)


}

mod Interop.IO.File {

    use Interop.IO.File
    use Interop.IO.File.{File}

    use Interop.NIO.File.Path
    use Interop.NIO.File.Path.{Path}

    pub def getHH(f: File[r]): ##java.io.File = 
        let File(f1) = f;
        f1

    pub def wrapHH(_: Region[r], prim: ##java.io.File): File[r] = 
        File(prim)

    pub def make(_: Region[r], path: String): File[r] \ r = 
        import java_new java.io.File(String): ##java.io.File \ r as new1;
        File(new1(path))

    pub def makeWithChild(_: Region[r], parent: String, child: String): File[r] \ r = 
        import java_new java.io.File(String, String): ##java.io.File \ r as new1;
        File(new1(parent, child))


    pub def toString(f: File[r]): String \ r = 
        import java.io.File.toString(): String \ r;
        let File(f1) = f;
        toString(f1)


    pub def toPath(f: File[r]): Result[String, Path] \ r =
        Result.tryCatch(_ -> {
            import java.io.File.toPath(): ##java.nio.file.Path \ r;
            let File(f1) = f;
            toPath(f1) |> Path
        })


}
