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

    use Interop.IO.OutputStreamWriter
    use Interop.IO.OutputStreamWriter.{OutputStreamWriter}
    use Interop.IO.Writer
    use Interop.IO.Writer.{Writer}
    use Interop.Lang.Appendable
    use Interop.Lang.Appendable.{Appendable}

    pub enum OutputStreamWriter[_: Region](##java.io.OutputStreamWriter)



    /// Note - this is subclassed by FileWriter, should we have a `SubOutputStreamWriter` class?
    /// ... Probably not, could FileWriter use casting internally?


    instance Interop.IO.SubWriter[OutputStreamWriter] {
        pub def toWriter(s: OutputStreamWriter[r]): Writer[r] = 
            let OutputStreamWriter(s1) = s;
            Writer(unchecked_cast(s1 as ##java.io.Writer))

        pub def fromWriter(s: Writer[r]): OutputStreamWriter[r] = 
            let Writer(s1) = s;
            OutputStreamWriter(unchecked_cast(s1 as ##java.io.OutputStreamWriter))
    }

    instance Interop.Lang.ImpAppendable[OutputStreamWriter] {
        pub def toAppendable(s: OutputStreamWriter[r]): Appendable[r] = 
            let OutputStreamWriter(s1) = s;
            Appendable(unchecked_cast(s1 as ##java.lang.Appendable))

        pub def fromAppendable(s: Appendable[r]): OutputStreamWriter[r] = 
            let Appendable(s1) = s;
            OutputStreamWriter(unchecked_cast(s1 as ##java.io.OutputStreamWriter))
    }

}

mod Interop.IO.OutputStreamWriter {

    use Interop.IO.OutputStreamWriter
    use Interop.IO.OutputStreamWriter.{OutputStreamWriter}
    use Interop.IO.OutputStream

    use Charset.{Charset}

    pub def getHH(w: OutputStreamWriter[r]): ##java.io.OutputStreamWriter = 
        let OutputStreamWriter(w1) = w;
        w1

    pub def wrapHH(_: Region[r], prim: ##java.io.OutputStreamWriter): OutputStreamWriter[r] =
        OutputStreamWriter(prim)

    pub def newOutputStreamWriter(_: Region[r1], outs: OutputStream[r], cs: Charset): OutputStreamWriter[r1] \ { r, r1 } = 
        import new java.io.OutputStreamWriter(##java.io.OutputStream, ##java.nio.charset.Charset): ##java.io.OutputStreamWriter \ {r, r1} as newOutputStreamWriter;
        let Charset(cs1) = cs;
        let outs1 = Interop.IO.OutputStream.getHH(outs);
        OutputStreamWriter(newOutputStreamWriter(outs1, cs1))

    pub def flush!(w: OutputStreamWriter[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.io.OutputStreamWriter.flush(): Unit \ r;
            let OutputStreamWriter(w1) = w;
            flush(w1)
        })

    pub def close!(w: OutputStreamWriter[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.io.OutputStreamWriter.close(): Unit \ r;
            let OutputStreamWriter(w1) = w;
            close(w1)
        })

    pub def getEncoding(w: OutputStreamWriter[r]): Option[String] \ r =
        import java.io.OutputStreamWriter.getEncoding(): String\ r;
        let OutputStreamWriter(w1) = w;
        getEncoding(w1) |> Object.toOption

    pub def writeSubCharArray!(arr: Array[Char, r1], 
                                offset: {offset = Int32}, 
                                len: {len = Int32}, 
                                w: OutputStreamWriter[r]): Result[String, Unit] \ {r, r1} =
        Result.tryCatch(_ -> {
            import java.io.OutputStreamWriter.write(Array[Char, r1], Int32, Int32): Unit \ {r, r1};
            let OutputStreamWriter(w1) = w;
            write(w1, arr, offset.offset, len.len)
        })

    pub def writeCharacter!(i: Int32, w: OutputStreamWriter[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.io.OutputStreamWriter.write(Int32): Unit \ r;
            let OutputStreamWriter(w1) = w;
            write(w1, i)
        })

    pub def writeSubstring!(s: String, offset: {offset = Int32}, len: {len = Int32}, w: OutputStreamWriter[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.io.OutputStreamWriter.write(String, Int32, Int32): Unit \ r;
            let OutputStreamWriter(w1) = w;
            write(w1, s, offset.offset, len.len)
        })

}
