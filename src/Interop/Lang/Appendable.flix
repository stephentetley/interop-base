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

mod Interop.Lang {

    use Interop.Lang.Appendable
    use Interop.Lang.Appendable.{Appendable}
    use StringBuilder.{StringBuilder}

    /// Interface...
    /// Mutable, no alloc
    pub enum Appendable[_: Region](##java.lang.Appendable)



    pub class ImpAppendable[t: Region -> Type] {
        pub def toAppendable[r: Region](s: t[r]): Appendable[r]
        pub def fromAppendable[r: Region](s: Appendable[r]): t[r]
    }

    instance Interop.Lang.ImpAppendable[StringBuilder] {
        pub def toAppendable(s: StringBuilder[r]): Appendable[r] = 
            let StringBuilder(s1) = s;
            Appendable(unchecked_cast(s1 as ##java.lang.Appendable))

        pub def fromAppendable(s: Appendable[r]): StringBuilder[r] = 
            let Appendable(s1) = s;
            StringBuilder(unchecked_cast(s1 as ##java.lang.StringBuilder))
    }

}

mod Interop.Lang.Appendable {

    use Interop.Lang.Appendable
    use Interop.Lang.Appendable.{Appendable}

    use Interop.Lang.CharSequence
    use Interop.Lang.CharSequence.{CharSequence}
    use Interop.Lang.ImpCharSequence

    pub def getHH(ap: Appendable[r]): ##java.lang.Appendable = 
        let Appendable(ap1) = ap;
        ap1

    pub def wrapHH(_: Region[r], prim: ##java.lang.Appendable): Appendable[r] = 
        Appendable(prim)


    pub def appendChar!(c: Char, ap: Appendable[r]): Result[String, Appendable[r]] \ Write(r) = 
        Result.tryCatch(_ -> {
            import java.lang.Appendable.append(Char): ##java.lang.Appendable \ Write(r);
            let Appendable(ap1) = ap;
            Appendable(append(ap1, c))
        })

    pub def appendCharSequence!(cs: CharSequence[r1], ap: Appendable[r]): Result[String, Appendable[r]] \ { Read(r1), Write(r) } = 
        Result.tryCatch(_ -> {
            import java.lang.Appendable.append(##java.lang.CharSequence): ##java.lang.Appendable \ { Read(r1), Write(r) };
            let cs1 = Interop.Lang.CharSequence.getHH(cs);
            let Appendable(ap1) = ap;
            Appendable(append(ap1, cs1))
        })

    pub def appendCharSubSequence!(cs: CharSequence[r1], 
                                    start: {start = Int32},
                                    end: {end = Int32},
                                    ap: Appendable[r2]): Result[String, Appendable[r]] \ { Read(r1), Write(r2) } = 
        Result.tryCatch(_ -> {
            import java.lang.Appendable.append(##java.lang.CharSequence, Int32, Int32): ##java.lang.Appendable \ { Read(r1), Write(r2) };
            let cs1 = Interop.Lang.CharSequence.getHH(cs);
            let Appendable(ap1) = ap;
            Appendable(append(ap1, cs1, start.start, end.end))
        })

}
