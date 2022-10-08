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

    pub enum StringWriter[_: Region](##java.io.StringWriter)

    instance Scoped[StringWriter] {
        pub def regionOf(_: StringWriter[r]): Region[r] = () as Region[r]
    }


    instance SubWriter[StringWriter] {
        pub def toWriter(s: StringWriter[r]): Writer[r] = 
            let StringWriter(s1) = s;
            Writer(s1 as ##java.io.Writer)

        pub def fromWriter(s: Writer[r]): StringWriter[r] = 
            let Writer(s1) = s;
            StringWriter(s1 as ##java.io.StringWriter) 
    }


    instance Interop/Lang.ImpAppendable[StringWriter] {
        pub def toAppendable(s: StringWriter[r]): Appendable[r] = 
            let StringWriter(s1) = s;
            Appendable(s1 as ##java.lang.Appendable)

        pub def fromAppendable(s: Appendable[r]): StringWriter[r] = 
            let Appendable(s1) = s;
            StringWriter(s1 as ##java.io.StringWriter) 
    }

}


namespace Interop/IO/StringWriter {

    use Interop/IO.StringWriter;
    use Interop/IO.StringWriter.{StringWriter};
    use Interop/IO.SubWriter;
    use Interop/Lang.CharSequence;


    pub def getHH(sr: StringWriter[r]): ##java.io.StringWriter = 
        let StringWriter(sr1) = sr;
        sr1


    pub def wrapHH(_: Region[r], prim: ##java.io.StringWriter): StringWriter[r] =
        StringWriter(prim)

    pub def new(_: Region[r]): StringWriter[r] \ Write(r) =
        import new java.io.StringWriter(): ##java.io.StringWriter \ r as newStringWriter;
        newStringWriter() |> StringWriter

    pub def newWithSize(_: Region[r], initSize: Int32): StringWriter[r] \ Write(r) =
        import new java.io.StringWriter(Int32): ##java.io.StringWriter \ r as newStringWriter;
        newStringWriter(initSize) |> StringWriter

    pub def toString(sr: StringWriter[r]): String \ Read(r)=
        import java.io.StringWriter.toString(): String \ r;
        let StringWriter(sr1) = sr;
        toString(sr1)

    /// TODO - getBuffer

    pub def appendChar!(c: Char, sr: StringWriter[r]): StringWriter[r] \ Write(r)=
        import java.io.StringWriter.append(Char): ##java.io.StringWriter \ r;
        let StringWriter(sr1) = sr;
        append(sr1, c) |> StringWriter 


    pub def appendCharSequence!(cs: CharSequence[r2], sr: StringWriter[r]): StringWriter[r] \ {Write(r), Read(r2)} =
        import java.io.StringWriter.append(##java.lang.CharSequence): ##java.io.StringWriter \ {r, r2};
        let StringWriter(sr1) = sr;
        let cs1 = Interop/Lang/CharSequence.getHH(cs);
        append(sr1, cs1) |> StringWriter


    pub def appendSubCharSequence!(cs: CharSequence[r2], 
                                    sub: {start = Int32, end = Int32}, 
                                    sr: StringWriter[r]): Result[StringWriter[r], String] \ Write(r) =
        try {
            import java.io.StringWriter.append(##java.lang.CharSequence, Int32, Int32): ##java.io.StringWriter \ r;
            let StringWriter(sr1) = sr;
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            append(sr1, cs1, sub.start, sub.end) |> StringWriter |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def flush!(sr: StringWriter[r]): Unit \ Write(r)  =
        import java.io.StringWriter.flush(): Unit \ r;
        let StringWriter(sr1) = sr;
        flush(sr1) 


    pub def close!(sr: StringWriter[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.StringWriter.close(): Unit \ r;
            let StringWriter(sr1) = sr;
            close(sr1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                sr: StringWriter[r]): Result[Unit, String] \ {Read(r2), Write(r)} =
        try {
            import java.io.StringWriter.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let StringWriter(sr1) = sr;
            write(sr1, arr, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def writeCharacter!(i: Int32, sr: StringWriter[r]): Unit \ Write(r) =
        import java.io.StringWriter.write(Int32): Unit \ r;
        let StringWriter(sr1) = sr;
        write(sr1, i)


    pub def writeString!(s: String, sr: StringWriter[r]): Unit \ Write(r)=
        import java.io.StringWriter.write(String): Unit \ r;
        let StringWriter(sr1) = sr;
        write(sr1, s)
            

    pub def writeSubstring!(s: String, 
                            offset: {offset :: Int32}, 
                            len: {len :: Int32}, 
                            sr: StringWriter[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.io.StringWriter.write(String, Int32, Int32): Unit \ r;
            let StringWriter(sr1) = sr;
            write(sr1, s, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
