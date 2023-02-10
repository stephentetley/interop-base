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

    pub enum Appendable[r: Region] { 
        case Appendable(Region[r], ##java.lang.Appendable)
    }


    pub class ImpAppendable[t: Region -> Type] {
        pub def toAppendable[r: Region, r1: Region](rc: Region[r1], s: t[r]): Appendable[r1]
        pub def fromAppendable[r: Region, r1: Region](rc: Region[r1], s: Appendable[r]): t[r1]
    }

    instance Interop/Lang.ImpAppendable[StringBuilder] {
        pub def toAppendable(rc: Region[r1], s: StringBuilder[r]): Appendable[r1] = 
            let StringBuilder(s1) = s;
            Appendable(rc, unsafe_cast s1 as ##java.lang.Appendable)

        pub def fromAppendable(_: Region[r1], s: Appendable[r]): StringBuilder[r1] = 
            let Appendable(_, s1) = s;
            StringBuilder(unsafe_cast s1 as ##java.lang.StringBuilder) 
    }

}

namespace Interop/Lang/Appendable {

    use Interop/Lang.Appendable;
    use Interop/Lang.Appendable.{Appendable};

    use Interop/Lang.CharSequence
    use Interop/Lang.CharSequence.{CharSequence}
    use Interop/Lang.ImpCharSequence

    pub def getHH(ap: Appendable[r]): ##java.lang.Appendable = 
        let Appendable(_, ap1) = ap;
        ap1

    pub def wrapHH(rc: Region[r], prim: ##java.lang.Appendable): Appendable[r] = 
        Appendable(rc, prim)


    pub def appendChar!(c: Char, ap: Appendable[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.lang.Appendable.append(Char): ##java.lang.Appendable \ Write(r);
            let Appendable(_, ap1) = ap;
            discard append(ap1, c);
            Ok()
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def appendCharSequence!(cs: CharSequence[r1], ap: Appendable[r]): Result[String, Unit] \ { Read(r1), Write(r) } = 
        try {
            import java.lang.Appendable.append(##java.lang.CharSequence): ##java.lang.Appendable \ { Read(r1), Write(r) };
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            let Appendable(_, ap1) = ap;
            discard append(ap1, cs1);
            Ok()
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def appendCharSubSequence!(cs: CharSequence[r1], 
                                    start: {start = Int32},
                                    end: {end = Int32},
                                    ap: Appendable[r2]): Result[String, Unit] \ { Read(r1), Write(r2) } = 
        try {
            import java.lang.Appendable.append(##java.lang.CharSequence, Int32, Int32): ##java.lang.Appendable \ { Read(r1), Write(r2) };
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            let Appendable(_, ap1) = ap;
            discard append(ap1, cs1, start.start, end.end);
            unsafe_cast Ok() as _ \ {Read(r1), Write(r2)} 
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
