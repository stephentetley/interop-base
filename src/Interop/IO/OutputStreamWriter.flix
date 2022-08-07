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

    instance Scoped[OutputStreamWriter] {
        pub def regionOf(_: OutputStreamWriter[r]): Region[r] = () as Region[r]
    }

    instance Interop/IO.SubWriter[OutputStreamWriter] {
        pub def ucast(s: OutputStreamWriter[r]): Writer[r] = 
            let OutputStreamWriter(s1) = s;
            Writer(s1 as ##java.io.Writer)

        pub def dcast(s: Writer[r]): OutputStreamWriter[r] = 
            let Writer(s1) = s;
            OutputStreamWriter(s1 as ##java.io.OutputStreamWriter) 
    }

    instance Interop/Lang.ImpAppendable[OutputStreamWriter] {
        pub def ucast(s: OutputStreamWriter[r]): Appendable[r] = 
            let OutputStreamWriter(s1) = s;
            Appendable(s1 as ##java.lang.Appendable)

        pub def dcast(s: Appendable[r]): OutputStreamWriter[r] = 
            let Appendable(s1) = s;
            OutputStreamWriter(s1 as ##java.io.OutputStreamWriter) 
    }

}

namespace Interop/IO/OutputStreamWriter {

    use Interop/IO.OutputStreamWriter;
    use Interop/IO.OutputStreamWriter.{OutputStreamWriter};

    use Interop/IO.SubOutputStream;


    pub def getHH(wr: OutputStreamWriter[r]): ##java.io.OutputStreamWriter = 
        let OutputStreamWriter(wr1) = wr;
        wr1

    pub def newOutputStreamWriter[r: Region, stream: Region -> Type](_: Region[r], 
                                                                    ous: stream[r], 
                                                                    cs: ##java.nio.charset.Charset): OutputStreamWriter[r] \ Write(r) with SubOutputStream[stream] = 
        import new java.io.OutputStreamWriter(##java.io.OutputStream, ##java.nio.charset.Charset): ##java.io.OutputStreamWriter & r as newOutputStreamWriter;
        OutputStreamWriter(newOutputStreamWriter(Interop/IO/OutputStream.getHH(Interop/IO/SubOutputStream.ucast(ous)), cs))


}
