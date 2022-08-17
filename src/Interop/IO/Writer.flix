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


    instance Interop/Lang.ImpAppendable[Writer] {
        pub def toAppendable(s: Writer[r]): Appendable[r] = 
            let Writer(s1) = s;
            Appendable(s1 as ##java.lang.Appendable)

        pub def fromAppendable(s: Appendable[r]): Writer[r] = 
            let Appendable(s1) = s;
            Writer(s1 as ##java.io.Writer) 
    }

}

namespace Interop/IO/Writer {

    use Interop/IO.Writer;
    use Interop/IO.Writer.{Writer};



    pub def getHH(wr: Writer[r]): ##java.io.Writer = 
        let Writer(wr1) = wr;
        wr1


    pub def mkWriter(_: Region[r], prim: ##java.io.Writer): Writer[r] \ Write(r) =
        Writer(prim) as \ Write(r)

}
