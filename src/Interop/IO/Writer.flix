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

    use Interop/Lang.Appendable;
    use Interop/Lang.Appendable.{Appendable};
    
    /// Abstract class...

    pub enum Writer[_: Region](##java.io.Writer)

    instance Scoped[Writer] {
        pub def regionOf(_: Writer[r]): Region[r] = () as Region[r]
    }

    pub class SubWriter[t: Region -> Type] {
        pub def toWriter[r: Region](s: t[r]): Writer[r]
        pub def fromWriter[r: Region](s: Writer[r]): t[r]
    }


    instance SubWriter[Writer] {
        pub def toWriter(w: Writer[r]): Writer[r] = w
        pub def fromWriter(w: Writer[r]): Writer[r] = w
    }


    instance Interop/Lang.ImpAppendable[Writer] {
        pub def toAppendable(s: Writer[r]): Appendable[r] = 
            let Writer(s1) = s;
            Appendable(s1 as ##java.lang.Appendable)

        pub def fromAppendable(s: Appendable[r]): Writer[r] = 
            let Appendable(s1) = s;
            Writer(s1 as ##java.io.Writer) 
    }

}

namespace Interop/IO/SubWriter {
    
    use Interop/IO.SubWriter;

    pub def getHH[r: Region, writer: Region -> Type](rd: writer[r]): ##java.io.Writer with SubWriter[writer] = 
        Interop/IO/SubWriter.toWriter(rd) |> Interop/IO/Writer.getHH

}

namespace Interop/IO/Writer {

    use Interop/IO.Writer;
    use Interop/IO.Writer.{Writer};
    use Interop/IO.SubWriter;
    use Interop/Lang.ImpCharSequence;


    pub def getHH(wr: Writer[r]): ##java.io.Writer = 
        let Writer(wr1) = wr;
        wr1


    pub def wrapHH(_: Region[r], prim: ##java.io.Writer): Writer[r] =
        Writer(prim)


    /// 
    pub def nullWriter(): Writer[r] \ Write(r) =
        import static java.io.Writer.nullWriter(): ##java.io.Writer \ r;
        nullWriter() |> Writer


    pub def appendChar![r: Region, wrt: Region -> Type]
                        (c: Char, wr: wrt[r]): Result[wrt[r], String] \ Write(r) with SubWriter[wrt]=
        try {
            import java.io.Writer.append(Char): ##java.io.Writer \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            append(wr1, c) |> Writer |> Interop/IO/SubWriter.fromWriter |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def appendCharSequence![r: Region, r2: Region, wrt: Region -> Type, cseq: Region -> Type]
                                (cs: cseq[r2], wr: wrt[r]): Result[wrt[r], String] \ Write(r) with SubWriter[wrt], ImpCharSequence[cseq] =
        try {
            import java.io.Writer.append(##java.lang.CharSequence): ##java.io.Writer \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            let cs1 = Interop/Lang/ImpCharSequence.getHH(cs);
            append(wr1, cs1) |> Writer |> Interop/IO/SubWriter.fromWriter |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def appendSubCharSequence![r: Region, r2: Region, wrt: Region -> Type, cseq: Region -> Type]
                                (cs: cseq[r2], sub: {start = Int32, end = Int32}, wr: wrt[r]): Result[wrt[r], String] \ Write(r) with SubWriter[wrt], ImpCharSequence[cseq] =
        try {
            import java.io.Writer.append(##java.lang.CharSequence, Int32, Int32): ##java.io.Writer \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            let cs1 = Interop/Lang/ImpCharSequence.getHH(cs);
            append(wr1, cs1, sub.start, sub.end) |> Writer |> Interop/IO/SubWriter.fromWriter |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def flush![r: Region, wrt: Region -> Type]
                        (wr: wrt[r]): Result[Unit, String] \ Write(r) with SubWriter[wrt] =
        try {
            import java.io.Writer.flush(): Unit \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            flush(wr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close![r: Region, writer: Region -> Type]
                    (wr: writer[r]): Result[Unit, String] \ Write(r) with SubWriter[writer] =
        try {
            import java.io.Writer.close(): Unit \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            close(wr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeCharArray![r: Region, r2: Region, writer: Region -> Type]
                        (arr: Array[Char, r2], wr: writer[r]): Result[Unit, String] \ {Read(r2), Write(r)} with SubWriter[writer] =
        try {
            import java.io.Writer.write(Array[Char, r2]): Unit \ {r, r2};
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            write(wr1, arr) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeSubCharArray![r: Region, r2: Region, writer: Region -> Type]
                                (arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                wr: writer[r]): Result[Unit, String] \ {Read(r2), Write(r)} with SubWriter[writer] =
        try {
            import java.io.Writer.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            write(wr1, arr, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeCharacter![r: Region, wrt: Region -> Type]
                            (i: Int32, wr: wrt[r]): Result[Unit, String] \ Write(r) with SubWriter[wrt] =
        try {
            import java.io.Writer.write(Int32): Unit \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            write(wr1, i) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeString![r: Region, wrt: Region -> Type]
                        (s: String, wr: wrt[r]): Result[Unit, String] \ Write(r) with SubWriter[wrt] =
        try {
            import java.io.Writer.write(String): Unit \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            write(wr1, s) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeSubstring![r: Region, wrt: Region -> Type]
                            (s: String, sub: {offset = Int32, len = Int32}, wr: wrt[r]): Result[Unit, String] \ Write(r) with SubWriter[wrt] =
        try {
            import java.io.Writer.write(String, Int32, Int32): Unit \ r;
            let wr1 = Interop/IO/SubWriter.getHH(wr);
            write(wr1, s, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
