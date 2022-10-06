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

    /// Abstract class...

    pub enum Reader[_: Region](##java.io.Reader)

    instance Scoped[Reader] {
        pub def regionOf(_: Reader[r]): Region[r] = () as Region[r]
    }

    pub class SubReader[t: Region -> Type] {
        pub def toReader[r: Region](s: t[r]): Reader[r]
        pub def fromReader[r: Region](s: Reader[r]): t[r]
    }


    instance SubReader[Reader] {
        pub def toReader(x: Reader[r]): Reader[r] = x
        pub def fromReader(x: Reader[r]): Reader[r] = x
    }


}

namespace Interop/IO/SubReader {
    
    use Interop/IO.SubReader;

    pub def getHH[r: Region, reader: Region -> Type](rd: reader[r]): ##java.io.Reader with SubReader[reader] = 
        Interop/IO/SubReader.toReader(rd) |> Interop/IO/Reader.getHH

}

namespace Interop/IO/Reader {

    use Interop/IO.Reader;
    use Interop/IO.Reader.{Reader};
    use Interop/IO.SubReader;



    pub def getHH(rd: Reader[r]): ##java.io.Reader = 
        let Reader(rd1) = rd;
        rd1

    pub def wrapHH(_: Region[r], prim: ##java.io.Reader): Reader[r] =
        Reader(prim)


    pub def close![r: Region, reader: Region -> Type]
                    (rd: reader[r]): Result[Unit, String] \ Write(r) with SubReader[reader] =
        try {
            import java.io.Reader.close(): Unit \ r;
            let rd1 = Interop/IO/SubReader.getHH(rd);
            close(rd1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def skip![r: Region, reader: Region -> Type]
                    (n: Int64, rd: reader[r]): Result[Int64, String] \ Write(r) with SubReader[reader] =
        try {
            import java.io.Reader.skip(Int64): Int64 \ r;
            let rd1 = Interop/IO/SubReader.getHH(rd);
            skip(rd1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
