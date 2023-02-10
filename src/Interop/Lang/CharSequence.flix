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
    /// Read-only (not pure) - in Java handles both String and StringBuilder[r]


    pub enum CharSequence[r: Region] { 
        case CharSequence(Region[r], ##java.lang.CharSequence)
    }

    pub class ImpCharSequence[t: Region -> Type] {
        pub def toCharSequence[r: Region, r1: Region](rc: Region[r1], s: t[r]): CharSequence[r1]
        pub def fromCharSequence[r: Region, r1: Region](rc: Region[r1], s: CharSequence[r]): t[r1]
    }

    instance Interop/Lang.ImpCharSequence[StringBuilder] {
        pub def toCharSequence(rc: Region[r1], s: StringBuilder[r]): CharSequence[r1] = 
            let StringBuilder(s1) = s;
            CharSequence(rc, unsafe_cast s1 as ##java.lang.CharSequence)

        pub def fromCharSequence(_: Region[r1], s: CharSequence[r]): StringBuilder[r1] = 
            let CharSequence(_, s1) = s;
            StringBuilder(unsafe_cast s1 as ##java.lang.StringBuilder) 
    }

}



namespace Interop/Lang/CharSequence {

    use Interop/Lang.CharSequence
    use Interop/Lang.CharSequence.{CharSequence}

    use Interop/Lang.ImpCharSequence

    pub def getHH(cs: CharSequence[r]): ##java.lang.CharSequence = 
        let CharSequence(_, cs1) = cs;
        cs1

    pub def wrapHH(rc: Region[r], prim: ##java.lang.CharSequence): CharSequence[r] = 
        CharSequence(rc, prim)

    pub def toCharSequenceHH[t: Region -> Type, r: Region, r1: Region](rc: Region[r1], s: t[r]): ##java.lang.CharSequence with ImpCharSequence[t] = 
        Interop/Lang/ImpCharSequence.toCharSequence(rc, s) |> getHH


    pub def toString(cs: CharSequence[r]): String \ Read(r) = 
        import java.lang.CharSequence.toString(): String \ r;
        let CharSequence(_, cs1) = cs;
        toString(cs1)

    pub def isEmpty(cs: CharSequence[r]): Bool \ Read(r) = 
        import java.lang.CharSequence.isEmpty(): Bool \ r;
        let CharSequence(_, cs1) = cs;
        isEmpty(cs1)

    pub def length(cs: CharSequence[r]): Int32 \ Read(r) = 
        import java.lang.CharSequence.length(): Int32 \ r;
        let CharSequence(_, cs1) = cs;
        length(cs1)

    pub def charAt(ix: Int32, cs: CharSequence[r]): Result[String, Char] \ Read(r) = 
        try {
            import java.lang.CharSequence.charAt(Int32): Char \ r;
            let CharSequence(_, cs1) = cs;
            charAt(cs1, ix) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def subSequence(start: {start = Int32}, end: {end = Int32}, cs: CharSequence[r]): Result[String, CharSequence[r]] \ {Read(r), Write(r)} = 
        try {
            import java.lang.CharSequence.subSequence(Int32, Int32): ##java.lang.CharSequence \ r;
            let CharSequence(rc, cs1) = cs;
            CharSequence(rc, subSequence(cs1, start.start, end.end)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
