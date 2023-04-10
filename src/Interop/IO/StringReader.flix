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

    use Interop.IO.StringReader
    use Interop.IO.StringReader.{StringReader}
    use Interop.IO.Reader
    use Interop.IO.Reader.{Reader}

    // StringReader has a read pointer so it is mutable
    pub enum StringReader[_: Region](##java.io.StringReader)


    instance SubReader[StringReader] {
        pub def toReader(s: StringReader[r]): Reader[r] = 
            let StringReader(s1) = s;
            Reader(unchecked_cast(s1 as ##java.io.Reader))

        pub def fromReader(s: Reader[r]): StringReader[r] = 
            let Reader(s1) = s;
            StringReader(unchecked_cast(s1 as ##java.io.StringReader))
    }


}


mod Interop.IO.StringReader {

    use Interop.IO.StringReader
    use Interop.IO.StringReader.{StringReader}



    pub def getHH(rd: StringReader[r]): ##java.io.StringReader = 
        let StringReader(rd1) = rd;
        rd1


    pub def wrapHH(_: Region[r], prim: ##java.io.StringReader): StringReader[r] =
        StringReader(prim)

    pub def newStringReader(_: Region[r], s: String): StringReader[r] \ Write(r) =
        import new java.io.StringReader(String): ##java.io.StringReader \ r as newStringReader;
        StringReader(newStringReader(s))


    pub def close!(rd: StringReader[r]): Result[String, Unit] \ Write(r) = 
        Result.tryCatch(_ -> {
            import java.io.StringReader.close(): Unit \ r;
            let StringReader(rd1) = rd;
            close(rd1)
        })


    pub def mark!(limit: Int32, rd: StringReader[r]): Result[String, Unit] \ Write(r) = 
        Result.tryCatch(_ -> {
            import java.io.StringReader.mark(Int32): Unit \ r;
            let StringReader(rd1) = rd;
            mark(rd1, limit)
        })

    pub def markSupported(rd: StringReader[r]): Bool \ Read(r) = 
        import java.io.StringReader.markSupported(): Bool \ r;
        let StringReader(rd1) = rd;
        markSupported(rd1)



    /// None indicates end-of-stream.
    pub def read!(rd: StringReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        Result.tryCatch(_ -> {
            import java.io.StringReader.read(): Int32 \ r;
            let StringReader(rd1) = rd;
            match read(rd1) { 
                case i if i < 0 => None
                case i          => Some(i)
            }
        })



}
