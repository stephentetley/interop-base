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

    use Interop.IO.StringWriter
    use Interop.IO.StringWriter.{StringWriter}
    use Interop.IO.Writer
    use Interop.IO.Writer.{Writer}
    use Interop.Lang.Appendable
    use Interop.Lang.Appendable.{Appendable}
    
    /// Abstract class...

    pub enum StringWriter[_: Region](##java.io.StringWriter)


    instance SubWriter[StringWriter] {
        pub def toWriter(s: StringWriter[r]): Writer[r] = 
            let StringWriter(s1) = s;
            Writer(unchecked_cast(s1 as ##java.io.Writer))

        pub def fromWriter(s: Writer[r]): StringWriter[r] = 
            let Writer(s1) = s;
            StringWriter(unchecked_cast(s1 as ##java.io.StringWriter))
    }


    instance Interop.Lang.ImpAppendable[StringWriter] {
        pub def toAppendable(s: StringWriter[r]): Appendable[r] = 
            let StringWriter(s1) = s;
            Appendable(unchecked_cast(s1 as ##java.lang.Appendable))

        pub def fromAppendable(s: Appendable[r]): StringWriter[r] = 
            let Appendable(s1) = s;
            StringWriter(unchecked_cast(s1 as ##java.io.StringWriter))
    }

}


mod Interop.IO.StringWriter {

    use Interop.IO.StringWriter
    use Interop.IO.StringWriter.{StringWriter}
    use Interop.IO.SubWriter
    use Interop.Lang.CharSequence


    pub def getHH(w: StringWriter[r]): ##java.io.StringWriter = 
        let StringWriter(w1) = w;
        w1


    pub def wrapHH(_: Region[r], prim: ##java.io.StringWriter): StringWriter[r] =
        StringWriter(prim)

    pub def new(_: Region[r]): StringWriter[r] \ Write(r) =
        import new java.io.StringWriter(): ##java.io.StringWriter \ r as newStringWriter;
        StringWriter(newStringWriter())

    pub def newWithSize(_: Region[r], initSize: Int32): StringWriter[r] \ Write(r) =
        import new java.io.StringWriter(Int32): ##java.io.StringWriter \ r as newStringWriter;
        StringWriter(newStringWriter(initSize))

    pub def toString(w: StringWriter[r]): String \ Read(r)=
        import java.io.StringWriter.toString(): String \ r;
        let StringWriter(w1) = w;
        toString(w1)

    /// TODO - getBuffer

    pub def appendChar!(c: Char, w: StringWriter[r]): StringWriter[r] \ Write(r)=
        import java.io.StringWriter.append(Char): ##java.io.StringWriter \ r;
        let StringWriter(w1) = w;
        StringWriter(append(w1, c))


    pub def appendCharSequence!(cs: CharSequence[r2], w: StringWriter[r]): StringWriter[r] \ {Write(r), Read(r2)} =
        import java.io.StringWriter.append(##java.lang.CharSequence): ##java.io.StringWriter \ {r, r2};
        let StringWriter(w1) = w;
        let cs1 = Interop.Lang.CharSequence.getHH(cs);
        StringWriter(append(w1, cs1))


    pub def appendSubCharSequence!(cs: CharSequence[r2], 
                                    start: {start = Int32}, 
                                    end: {end = Int32}, 
                                    w: StringWriter[r]): Result[String, StringWriter[r]] \ Write(r) =
        Result.tryCatch(_ -> {
            import java.io.StringWriter.append(##java.lang.CharSequence, Int32, Int32): ##java.io.StringWriter \ r;
            let StringWriter(w1) = w;
            let cs1 = Interop.Lang.CharSequence.getHH(cs);
            StringWriter(append(w1, cs1, start.start, end.end))
        })


    pub def flush!(w: StringWriter[r]): Unit \ Write(r)  =
        import java.io.StringWriter.flush(): Unit \ r;
        let StringWriter(w1) = w;
        flush(w1) 


    pub def close!(w: StringWriter[r]): Result[String, Unit] \ Write(r) =
        Result.tryCatch(_ -> {
            import java.io.StringWriter.close(): Unit \ r;
            let StringWriter(w1) = w;
            close(w1)
        })


    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                w: StringWriter[r]): Result[String, Unit] \ {Read(r2), Write(r)} =
        Result.tryCatch(_ -> {
            import java.io.StringWriter.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let StringWriter(w1) = w;
            write(w1, arr, offset.offset, len.len)
        })


    pub def writeCharacter!(i: Int32, w: StringWriter[r]): Unit \ Write(r) =
        import java.io.StringWriter.write(Int32): Unit \ r;
        let StringWriter(w1) = w;
        write(w1, i)


    pub def writeString!(s: String, w: StringWriter[r]): Unit \ Write(r)=
        import java.io.StringWriter.write(String): Unit \ r;
        let StringWriter(w1) = w;
        write(w1, s)
            

    pub def writeSubstring!(s: String, 
                            offset: {offset = Int32}, 
                            len: {len = Int32}, 
                            w: StringWriter[r]): Result[String, Unit] \ Write(r) =
        Result.tryCatch(_ -> {
            import java.io.StringWriter.write(String, Int32, Int32): Unit \ r;
            let StringWriter(w1) = w;
            write(w1, s, offset.offset, len.len)
        })

}
