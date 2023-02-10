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

    pub enum StringWriter[r: Region] { 
        case StringWriter(Region[r], ##java.io.StringWriter)
    }

    instance SubWriter[StringWriter] {
        pub def toWriter(rc: Region[r1], s: StringWriter[r]): Writer[r1] = 
            let StringWriter(s1) = s;
            Writer(rc, unsafe_cast s1 as ##java.io.Writer)

        pub def fromWriter(rc: Region[r1], s: Writer[r]): StringWriter[r1] = 
            let Writer(_, s1) = s;
            StringWriter(rc, unsafe_cast s1 as ##java.io.StringWriter) 
    }


    instance Interop/Lang.ImpAppendable[StringWriter] {
        pub def toAppendable(rc: Region[r1], s: StringWriter[r]): Appendable[r1] = 
            let StringWriter(_, s1) = s;
            Appendable(rc, unsafe_cast s1 as ##java.lang.Appendable)

        pub def fromAppendable(rc: Region[r1], s: Appendable[r]): StringWriter[r1] = 
            let Appendable(_, s1) = s;
            StringWriter(rc, unsafe_cast s1 as ##java.io.StringWriter) 
    }

}


namespace Interop/IO/StringWriter {

    use Interop/IO.StringWriter;
    use Interop/IO.StringWriter.{StringWriter};
    use Interop/IO.SubWriter;
    use Interop/Lang.CharSequence;


    pub def getHH(w: StringWriter[r]): ##java.io.StringWriter = 
        let StringWriter(_, w1) = w;
        w1


    pub def wrapHH(rc: Region[r], prim: ##java.io.StringWriter): StringWriter[r] =
        StringWriter(rc, prim)

    pub def new(rc: Region[r]): StringWriter[r] \ Write(r) =
        import new java.io.StringWriter(): ##java.io.StringWriter \ r as newStringWriter;
        StringWriter(rc, newStringWriter())

    pub def newWithSize(rc: Region[r], initSize: Int32): StringWriter[r] \ Write(r) =
        import new java.io.StringWriter(Int32): ##java.io.StringWriter \ r as newStringWriter;
        StringWriter(rc, newStringWriter(initSize))

    pub def toString(w: StringWriter[r]): String \ Read(r)=
        import java.io.StringWriter.toString(): String \ r;
        let StringWriter(_, w1) = w;
        toString(w1)

    /// TODO - getBuffer

    pub def appendChar!(c: Char, w: StringWriter[r]): StringWriter[r] \ Write(r)=
        import java.io.StringWriter.append(Char): ##java.io.StringWriter \ r;
        let StringWriter(rc, w1) = w;
        StringWriter(rc, append(w1, c))


    pub def appendCharSequence!(cs: CharSequence[r2], w: StringWriter[r]): StringWriter[r] \ {Write(r), Read(r2)} =
        import java.io.StringWriter.append(##java.lang.CharSequence): ##java.io.StringWriter \ {r, r2};
        let StringWriter(rc, w1) = w;
        let cs1 = Interop/Lang/CharSequence.getHH(cs);
        StringWriter(rc, append(w1, cs1))


    pub def appendSubCharSequence!(cs: CharSequence[r2], 
                                    sub: {start = Int32, end = Int32}, 
                                    w: StringWriter[r]): Result[String, StringWriter[r]] \ Write(r) =
        try {
            import java.io.StringWriter.append(##java.lang.CharSequence, Int32, Int32): ##java.io.StringWriter \ r;
            let StringWriter(rc, w1) = w;
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            StringWriter(rc, append(w1, cs1, sub.start, sub.end)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def flush!(w: StringWriter[r]): Unit \ Write(r)  =
        import java.io.StringWriter.flush(): Unit \ r;
        let StringWriter(_, w1) = w;
        flush(w1) 


    pub def close!(w: StringWriter[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.io.StringWriter.close(): Unit \ r;
            let StringWriter(_, w1) = w;
            close(w1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                w: StringWriter[r]): Result[String, Unit] \ {Read(r2), Write(r)} =
        try {
            import java.io.StringWriter.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let StringWriter(_, w1) = w;
            write(w1, arr, sub.offset, sub.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def writeCharacter!(i: Int32, w: StringWriter[r]): Unit \ Write(r) =
        import java.io.StringWriter.write(Int32): Unit \ r;
        let StringWriter(_, w1) = w;
        write(w1, i)


    pub def writeString!(s: String, w: StringWriter[r]): Unit \ Write(r)=
        import java.io.StringWriter.write(String): Unit \ r;
        let StringWriter(_, w1) = w;
        write(w1, s)
            

    pub def writeSubstring!(s: String, 
                            offset: {offset = Int32}, 
                            len: {len = Int32}, 
                            w: StringWriter[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.io.StringWriter.write(String, Int32, Int32): Unit \ r;
            let StringWriter(_, w1) = w;
            write(w1, s, offset.offset, len.len) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
