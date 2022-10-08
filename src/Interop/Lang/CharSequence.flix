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

namespace Interop/Lang {

    /// Interface...
    /// Must be able to handle both String and StringBuilder[r]


    pub enum CharSequence[_: Region](##java.lang.CharSequence)

    instance Scoped[CharSequence] {
        pub def regionOf(_: CharSequence[r]): Region[r] = () as Region[r]
    }

    pub class ImpCharSequence[t: Region -> Type] {
        pub def toCharSequence[r: Region](s: t[r]): CharSequence[r]
        pub def fromCharSequence[r: Region](s: CharSequence[r]): t[r]
    }

    instance Interop/Lang.ImpCharSequence[StringBuilder] {
        pub def toCharSequence(s: StringBuilder[r]): CharSequence[r] = 
            let StringBuilder(s1) = s;
            CharSequence(s1 as ##java.lang.CharSequence)

        pub def fromCharSequence(s: CharSequence[r]): StringBuilder[r] = 
            let CharSequence(s1) = s;
            StringBuilder(s1 as ##java.lang.StringBuilder) 
    }


}

namespace Interop/Lang/ImpCharSequence {
    
    use Interop/Lang.ImpCharSequence;

    pub def getHH[r: Region, cseq: Region -> Type](cs: cseq[r]): ##java.lang.CharSequence with ImpCharSequence[cseq] = 
        Interop/Lang/ImpCharSequence.toCharSequence(cs) |> Interop/Lang/CharSequence.getHH

}


namespace Interop/Lang/CharSequence {

    use Interop/Lang.CharSequence;
    use Interop/Lang.CharSequence.{CharSequence};

    use Interop/Lang.ImpCharSequence;

    pub def getHH(cs: CharSequence[r]): ##java.lang.CharSequence = 
        let CharSequence(cs1) = cs;
        cs1

    pub def toCharSequenceHH[t: Region -> Type, r: Region](cseq: t[r]): ##java.lang.CharSequence with ImpCharSequence[t] = 
        Interop/Lang/ImpCharSequence.toCharSequence(cseq) |> getHH


    pub def length[r: Region, t: Region -> Type](ss: t[r]): Int32 \ Read(r) with ImpCharSequence[t] = 
        import java.lang.CharSequence.length(): Int32 & r;
        let CharSequence(ss1) = Interop/Lang/ImpCharSequence.toCharSequence(ss);
        length(ss1)

}
