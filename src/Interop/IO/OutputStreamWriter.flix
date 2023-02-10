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

    pub enum OutputStreamWriter[r: Region] { 
        case OutputStreamWriter(Region[r], ##java.io.OutputStreamWriter)
    }


    /// Note - this is subclassed by FileWriter, should we have a `SubOutputStreamWriter` class?
    /// ... Probably not, could FileWriter use casting internally?


    instance Interop/IO.SubWriter[OutputStreamWriter] {
        pub def toWriter(rc: Region[r1], s: OutputStreamWriter[r]): Writer[r1] = 
            let OutputStreamWriter(_, s1) = s;
            Writer(rc, unsafe_cast s1 as ##java.io.Writer)

        pub def fromWriter(rc: Region[r1], s: Writer[r]): OutputStreamWriter[r1] = 
            let Writer(_, s1) = s;
            OutputStreamWriter(rc, unsafe_cast s1 as ##java.io.OutputStreamWriter) 
    }

    instance Interop/Lang.ImpAppendable[OutputStreamWriter] {
        pub def toAppendable(rc: Region[r1], s: OutputStreamWriter[r]): Appendable[r1] = 
            let OutputStreamWriter(_, s1) = s;
            Appendable(rc, unsafe_cast s1 as ##java.lang.Appendable)

        pub def fromAppendable(rc: Region[r1], s: Appendable[r]): OutputStreamWriter[r1] = 
            let Appendable(_, s1) = s;
            OutputStreamWriter(rc, unsafe_cast s1 as ##java.io.OutputStreamWriter) 
    }

}

namespace Interop/IO/OutputStreamWriter {

    use Interop/IO.OutputStreamWriter;
    use Interop/IO.OutputStreamWriter.{OutputStreamWriter};
    use Interop/IO.OutputStream;

    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};

    pub def getHH(w: OutputStreamWriter[r]): ##java.io.OutputStreamWriter = 
        let OutputStreamWriter(_, w1) = w;
        w1

    pub def wrapHH(rc: Region[r], prim: ##java.io.OutputStreamWriter): OutputStreamWriter[r] =
        OutputStreamWriter(rc, prim)

    pub def newOutputStreamWriter(rc: Region[r1], outs: OutputStream[r], cs: Charset): OutputStreamWriter[r1] \ { Read(r), Write(r1) } = 
        import new java.io.OutputStreamWriter(##java.io.OutputStream, ##java.nio.charset.Charset): ##java.io.OutputStreamWriter \ {r, r1} as newOutputStreamWriter;
        let Charset(cs1) = cs;
        let outs1 = Interop/IO/OutputStream.getHH(outs);
        OutputStreamWriter(rc, newOutputStreamWriter(outs1, cs1))

    pub def flush!(w: OutputStreamWriter[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.flush(): Unit \ r;
            let OutputStreamWriter(_, w1) = w;
            flush(w1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(w: OutputStreamWriter[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.close(): Unit \ r;
            let OutputStreamWriter(_, w1) = w;
            close(w1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getEncoding(w: OutputStreamWriter[r]): Option[String] \ Read(r) =
        import java.io.OutputStreamWriter.getEncoding(): String\ r;
        let OutputStreamWriter(_, w1) = w;
        getEncoding(w1) |> Object.toOption

    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                w: OutputStreamWriter[r]): Result[String, Unit] \ {Read(r2), Write(r)} =
        try {
            import java.io.OutputStreamWriter.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let OutputStreamWriter(_, w1) = w;
            write(w1, arr, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeCharacter!(i: Int32, w: OutputStreamWriter[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.write(Int32): Unit \ r;
            let OutputStreamWriter(_, w1) = w;
            write(w1, i) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeSubstring!(s: String, sub: {offset = Int32, len = Int32}, w: OutputStreamWriter[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.io.OutputStreamWriter.write(String, Int32, Int32): Unit \ r;
            let OutputStreamWriter(_, w1) = w;
            write(w1, s, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
