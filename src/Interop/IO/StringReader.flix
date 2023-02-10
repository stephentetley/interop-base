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

    use Interop/IO.Reader
    use Interop/IO.Reader.{Reader}

    // StringReader has a read pointer so it is mutable
    pub enum StringReader[r: Region] { 
        case StringReader(Region[r], ##java.io.StringReader)
    }

    instance SubReader[StringReader] {
        pub def toReader(rc: Region[r1], s: StringReader[r]): Reader[r1] = 
            let StringReader(_, s1) = s;
            Reader(rc, unsafe_cast s1 as ##java.io.Reader)

        pub def fromReader(rc: Region[r1], s: Reader[r]): StringReader[r1] = 
            let Reader(_, s1) = s;
            StringReader(rc, unsafe_cast s1 as ##java.io.StringReader) 
    }


}


namespace Interop/IO/StringReader {

    use Interop/IO.StringReader
    use Interop/IO.StringReader.{StringReader}



    pub def getHH(rd: StringReader[r]): ##java.io.StringReader = 
        let StringReader(_, rd1) = rd;
        rd1


    pub def wrapHH(rc: Region[r], prim: ##java.io.StringReader): StringReader[r] =
        StringReader(rc, prim)

    pub def newStringReader(rc: Region[r], s: String): StringReader[r] \ Write(r) =
        import new java.io.StringReader(String): ##java.io.StringReader \ r as newStringReader;
        StringReader(rc, newStringReader(s))


    pub def close!(rd: StringReader[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.io.StringReader.close(): Unit \ r;
            let StringReader(_, rd1) = rd;
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def mark!(limit: Int32, rd: StringReader[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.io.StringReader.mark(Int32): Unit \ r;
            let StringReader(_, rd1) = rd;
            mark(rd1, limit) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def markSupported(rd: StringReader[r]): Bool \ Read(r) = 
        import java.io.StringReader.markSupported(): Bool \ r;
        let StringReader(_, rd1) = rd;
        markSupported(rd1)



    /// None indicates end-of-stream.
    pub def read!(rd: StringReader[r]): Result[String, Option[Int32]] \ Read(r) = 
        try {
            import java.io.StringReader.read(): Int32 \ r;
            let StringReader(_, rd1) = rd;
            match read(rd1) { 
                case i if i < 0 => Ok(None)
                case i          => Ok(Some(i))
            }
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }



}
