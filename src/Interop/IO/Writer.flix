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
        pub def regionOf(_: Writer[r]): Region[r] = unsafe_cast () as Region[r]
    }

    pub class SubWriter[t: Region -> Type] {
        pub def toWriter[r: Region](s: t[r]): Writer[r]
        pub def fromWriter[r: Region](s: Writer[r]): t[r]
    }


    instance Interop/Lang.ImpAppendable[Writer] {
        pub def toAppendable(s: Writer[r]): Appendable[r] = 
            let Writer(s1) = s;
            Appendable(unsafe_cast s1 as ##java.lang.Appendable)

        pub def fromAppendable(s: Appendable[r]): Writer[r] = 
            let Appendable(s1) = s;
            Writer(unsafe_cast s1 as ##java.io.Writer) 
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
    use Interop/Lang.CharSequence;


    pub def getHH(wr: Writer[r]): ##java.io.Writer = 
        let Writer(wr1) = wr;
        wr1


    pub def wrapHH(_: Region[r], prim: ##java.io.Writer): Writer[r] =
        Writer(prim)


    /// 
    pub def nullWriter(): Writer[r] \ Write(r) =
        import static java.io.Writer.nullWriter(): ##java.io.Writer \ r;
        nullWriter() |> Writer


    pub def appendChar!(c: Char, wr: Writer[r]): Result[Writer[r], String] \ Write(r) =
        try {
            import java.io.Writer.append(Char): ##java.io.Writer \ r;
            let wr1 = getHH(wr);
            append(wr1, c) |> Writer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def appendCharSequence!(cs: CharSequence[r2], wr: Writer[r]): Result[Writer[r], String] \ Write(r) =
        try {
            import java.io.Writer.append(##java.lang.CharSequence): ##java.io.Writer \ r;
            let wr1 = getHH(wr);
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            append(wr1, cs1) |> Writer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def appendSubCharSequence!(cs: CharSequence[r2], 
                                    sub: {start = Int32, end = Int32}, 
                                    wr: Writer[r]): Result[Writer[r], String] \ Write(r) =
        try {
            import java.io.Writer.append(##java.lang.CharSequence, Int32, Int32): ##java.io.Writer \ r;
            let wr1 = getHH(wr);
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            append(wr1, cs1, sub.start, sub.end) |> Writer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def flush!(wr: Writer[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.Writer.flush(): Unit \ r;
            let wr1 = getHH(wr);
            flush(wr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(wr: Writer[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.Writer.close(): Unit \ r;
            let wr1 = getHH(wr);
            close(wr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeCharArray!(arr: Array[Char, r2], wr: Writer[r]): Result[Unit, String] \ {Read(r2), Write(r)} =
        try {
            import java.io.Writer.write(Array[Char, r2]): Unit \ {r, r2};
            let wr1 = getHH(wr);
            write(wr1, arr) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                wr: Writer[r]): Result[Unit, String] \ {Read(r2), Write(r)} =
        try {
            import java.io.Writer.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let wr1 = getHH(wr);
            write(wr1, arr, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeCharacter!(i: Int32, wr: Writer[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.Writer.write(Int32): Unit \ r;
            let wr1 = getHH(wr);
            write(wr1, i) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeString!(s: String, wr: Writer[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.Writer.write(String): Unit \ r;
            let wr1 = getHH(wr);
            write(wr1, s) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def writeSubstring!(s: String, sub: {offset = Int32, len = Int32}, wr: Writer[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.Writer.write(String, Int32, Int32): Unit \ r;
            let wr1 = getHH(wr);
            write(wr1, s, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
