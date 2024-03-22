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


    /// Abstract class...
    /// Mutable, no alloc
    pub enum InputStream[_: Region](##java.io.InputStream)


    pub class SubInputStream[t: Region -> Type] {
        pub def toInputStream(s: t[r]): InputStream[r]
        pub def fromInputStream(s: InputStream[r]): t[r]
    }

}


mod Interop.IO.InputStream {

    use Interop.IO.InputStream
    use Interop.IO.InputStream.{InputStream}

    pub def getHH(s: InputStream[r]): ##java.io.InputStream = 
        let InputStream(s1) = s;
        s1

    pub def wrapHH(_: Region[r], prim: ##java.io.InputStream): InputStream[r] = 
        InputStream(prim)



    pub def close!(s: InputStream[r]): Result[String, Unit] \ r = 
        Result.tryCatch(_ -> {
            import java.io.InputStream.close(): Unit \ r;
            let InputStream(s1) = s;
            close(s1)
        })


    pub def readAllBytes(rc: Region[r1], s: InputStream[r]): Result[String, Array[Int8, r1]] \ { r, r1 } = 
        Result.tryCatch(_ -> {
            import java.io.InputStream.readAllBytes(): Array[Int8, r1] \ {r, r1};
            let InputStream(s1) = s;
            let _ = bug!("readAllBytes - todo"); // Array.new(rc);
            readAllBytes(s1)
        })

    pub def reset!(s: InputStream[r]): Result[String, Unit] \ r = 
        Result.tryCatch(_ -> {
            import java.io.InputStream.reset(): Unit \ r;
            let InputStream(s1) = s;
            reset(s1)
        })

    pub def skip!(n: Int64, s: InputStream[r]): Result[String, Int64] \ r = 
        Result.tryCatch(_ -> {
            import java.io.InputStream.skip(Int64): Int64 \ r;
            let InputStream(s1) = s;
            skip(s1, n)
        })

    pub def skipNBytes!(n: Int64, s: InputStream[r]): Result[String, Unit] \ r = 
        Result.tryCatch(_ -> {
            import java.io.InputStream.skipNBytes(Int64): Unit \ r;
            let InputStream(s1) = s;
            skipNBytes(s1, n)
        })

}
