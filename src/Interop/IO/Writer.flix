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

    pub class SubWriter[t: Region -> Type] {
        pub def toWriter[r: Region, r1: Region](rc: Region[r1], s: t[r]): Writer[r1]
        pub def fromWriter[r: Region, r1: Region](rc: Region[r1], s: Writer[r]): t[r1]
    }


    instance Interop/Lang.ImpAppendable[Writer] {
        pub def toAppendable(rc: Region[r1], s: Writer[r]): Appendable[r1] = 
            let Writer(s1) = s;
            Appendable(rc, unsafe_cast s1 as ##java.lang.Appendable)

        pub def fromAppendable(_: Region[r1], s: Appendable[r]): Writer[r1] = 
            let Appendable(_, s1) = s;
            Writer(unsafe_cast s1 as ##java.io.Writer) 
    }

}


namespace Interop/IO/Writer {

    use Interop/IO.Writer;
    use Interop/IO.Writer.{Writer};
    use Interop/IO.SubWriter;
    use Interop/Lang.CharSequence;


    pub def getHH(w: Writer[r]): ##java.io.Writer = 
        let Writer(w1) = w;
        w1


    pub def wrapHH(_: Region[r], prim: ##java.io.Writer): Writer[r] =
        Writer(prim)


    /// 
    pub def nullWriter(_: Region[r]): Writer[r] \ Write(r) =
        import static java.io.Writer.nullWriter(): ##java.io.Writer \ r;
        Writer(nullWriter())


    pub def appendChar!(c: Char, w: Writer[r]): Result[String, Writer[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.append(Char): ##java.io.Writer \ r;
            let Writer(w1) = w;
            Writer(append(w1, c))
        })


    pub def appendCharSequence!(cs: CharSequence[r2], w: Writer[r]): Result[String, Writer[r]] \ { Read(r1), Write(r) } =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.append(##java.lang.CharSequence): ##java.io.Writer \ {r, r1};
            let Writer(w1) = w;
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            Writer(append(w1, cs1))
        })

    pub def appendSubCharSequence!(cs: CharSequence[r1], 
                                    sub: {start = Int32, end = Int32}, 
                                    w: Writer[r]): Result[String, Writer[r]] \ { Read(r1), Write(r) } =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.append(##java.lang.CharSequence, Int32, Int32): ##java.io.Writer \ {r, r1};
            let Writer(w1) = w;
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            Writer(append(w1, cs1, sub.start, sub.end))
        })

    pub def flush!(w: Writer[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.flush(): Unit \ r;
            let Writer(w1) = w;
            flush(w1)
        })

    pub def close!(w: Writer[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.close(): Unit \ r;
            let Writer(w1) = w;
            close(w1)
        })

    pub def writeCharArray!(arr: Array[Char, r2], w: Writer[r]): Result[String, Unit] \ {Read(r2), Write(r)} =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.write(Array[Char, r2]): Unit \ {r, r2};
            let Writer(w1) = w;
            write(w1, arr)
        })

    pub def writeSubCharArray!(arr: Array[Char, r2], 
                                sub: {offset = Int32, len = Int32}, 
                                w: Writer[r]): Result[String, Unit] \ {Read(r2), Write(r)} =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.write(Array[Char, r2], Int32, Int32): Unit \ {r, r2};
            let Writer(w1) = w;
            write(w1, arr, sub.offset, sub.len)
        })

    pub def writeCharacter!(i: Int32, w: Writer[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.write(Int32): Unit \ r;
            let Writer(w1) = w;
            write(w1, i)
        })

    pub def writeString!(s: String, w: Writer[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.write(String): Unit \ r;
            let Writer(w1) = w;
            write(w1, s)
        })

    pub def writeSubstring!(s: String, sub: {offset = Int32, len = Int32}, w: Writer[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.io.Writer.write(String, Int32, Int32): Unit \ r;
            let Writer(w1) = w;
            write(w1, s, sub.offset, sub.len)
        })

}
