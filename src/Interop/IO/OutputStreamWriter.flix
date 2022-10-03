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

    use Interop/IO.Writer;
    use Interop/IO.Writer.{Writer};
    use Interop/Lang.Appendable;
    use Interop/Lang.Appendable.{Appendable};

    pub enum OutputStreamWriter[_: Region](##java.io.OutputStreamWriter)


    /// Note - this is subclassed by FileWriter, should we have a `SubOutputStreamWriter` class?
    /// ... Probably not, could FileWriter use casting internally?

    instance Scoped[OutputStreamWriter] {
        pub def regionOf(_: OutputStreamWriter[r]): Region[r] = () as Region[r]
    }

    instance Interop/IO.SubWriter[OutputStreamWriter] {
        pub def toWriter(s: OutputStreamWriter[r]): Writer[r] = 
            let OutputStreamWriter(s1) = s;
            Writer(s1 as ##java.io.Writer)

        pub def fromWriter(s: Writer[r]): OutputStreamWriter[r] = 
            let Writer(s1) = s;
            OutputStreamWriter(s1 as ##java.io.OutputStreamWriter) 
    }

    instance Interop/Lang.ImpAppendable[OutputStreamWriter] {
        pub def toAppendable(s: OutputStreamWriter[r]): Appendable[r] = 
            let OutputStreamWriter(s1) = s;
            Appendable(s1 as ##java.lang.Appendable)

        pub def fromAppendable(s: Appendable[r]): OutputStreamWriter[r] = 
            let Appendable(s1) = s;
            OutputStreamWriter(s1 as ##java.io.OutputStreamWriter) 
    }

}

namespace Interop/IO/OutputStreamWriter {

    use Interop/IO.OutputStreamWriter;
    use Interop/IO.OutputStreamWriter.{OutputStreamWriter};
    use Interop/IO.SubOutputStream;

    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};

    pub def getHH(wr: OutputStreamWriter[r]): ##java.io.OutputStreamWriter = 
        let OutputStreamWriter(wr1) = wr;
        wr1

    pub def wrapHH(_: Region[r], prim: ##java.io.OutputStreamWriter): OutputStreamWriter[r] =
        OutputStreamWriter(prim)

    pub def newOutputStreamWriter[r: Region, stream: Region -> Type](_: Region[r], 
                                                                    ous: stream[r], 
                                                                    cs: Charset): OutputStreamWriter[r] \ Write(r) with SubOutputStream[stream] = 
        import new java.io.OutputStreamWriter(##java.io.OutputStream, ##java.nio.charset.Charset): ##java.io.OutputStreamWriter & r as newOutputStreamWriter;
        let Charset(cs1) = cs;
        OutputStreamWriter(newOutputStreamWriter(Interop/IO/OutputStream.getHH(Interop/IO/SubOutputStream.toOutputStream(ous)), cs1))

    pub def flush!(wr: OutputStreamWriter[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.flush(): Unit \ r;
            let wr1 = getHH(wr);
            flush(wr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(wr: OutputStreamWriter[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.flush(): Unit \ r;
            let OutputStreamWriter(wr1) = wr;
            flush(wr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getEncoding(wr: OutputStreamWriter[r]): Option[String] \ Read(r) =
        import java.io.OutputStreamWriter.getEncoding(): String\ r;
        let OutputStreamWriter(wr1) = wr;
        getEncoding(wr1) |> Object.toOption

    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                wr: OutputStreamWriter[r]): Result[Unit, String] \ {Read(r2), Write(r)} =
        try {
            import java.io.OutputStreamWriter.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let OutputStreamWriter(wr1) = wr;
            write(wr1, arr, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeCharacter!(i: Int32, wr: OutputStreamWriter[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.write(Int32): Unit \ r;
            let OutputStreamWriter(wr1) = wr;
            write(wr1, i) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeSubstring!(s: String, sub: {offset = Int32, len = Int32}, wr: OutputStreamWriter[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.write(String, Int32, Int32): Unit \ r;
            let OutputStreamWriter(wr1) = wr;
            write(wr1, s, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
