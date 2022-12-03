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

    pub enum Appendable[_: Region](##java.lang.Appendable)

    instance Scoped[Appendable] {
        pub def regionOf(_: Appendable[r]): Region[r] = unsafe_cast () as Region[r]
    }

    pub class ImpAppendable[t: Region -> Type] {
        pub def toAppendable[r: Region](s: t[r]): Appendable[r]
        pub def fromAppendable[r: Region](s: Appendable[r]): t[r]
    }

    instance Interop/Lang.ImpAppendable[StringBuilder] {
        pub def toAppendable(s: StringBuilder[r]): Appendable[r] = 
            let StringBuilder(s1) = s;
            Appendable(unsafe_cast s1 as ##java.lang.Appendable)

        pub def fromAppendable(s: Appendable[r]): StringBuilder[r] = 
            let Appendable(s1) = s;
            StringBuilder(unsafe_cast s1 as ##java.lang.StringBuilder) 
    }

}

namespace Interop/Lang/Appendable {

    use Interop/Lang.Appendable;
    use Interop/Lang.Appendable.{Appendable};
    use Interop/Lang.ImpAppendable;

    use Interop/Lang.CharSequence;
    use Interop/Lang.CharSequence.{CharSequence};
    use Interop/Lang.ImpCharSequence;

    pub def getHH(ap: Appendable[r]): ##java.lang.Appendable = 
        let Appendable(ap1) = ap;
        ap1

    pub def appendChar![r: Region, t: Region -> Type](c: Char, ss: t[r]): Result[Unit, String] \ Write(r) with ImpAppendable[t] = 
        try {
            import java.lang.Appendable.append(Char): ##java.lang.Appendable & r;
            let Appendable(ss1) = Interop/Lang/ImpAppendable.toAppendable(ss);
            discard append(ss1, c);
            Ok()
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }

    /// TODO - use concrete types
    pub def appendCharSequence![r1: Region, r2: Region, t1: Region -> Type, t2: Region -> Type]
                                (cs: t1[r1], ss: t2[r2]): Result[Unit, String] \ {Read(r1), Write(r2)} with ImpCharSequence[t1], ImpAppendable[t2] = 
        try {
            import java.lang.Appendable.append(##java.lang.CharSequence): ##java.lang.Appendable & r2;
            let Appendable(ss1) = Interop/Lang/ImpAppendable.toAppendable(ss);
            let CharSequence(cs1) = Interop/Lang/ImpCharSequence.toCharSequence(cs);
            discard append(ss1, cs1);
            unsafe_cast Ok() as \ {Read(r1), Write(r2)} 
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r2;
                Err(getMessage(ex))
        }


}
