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


    pub enum CharSequence[_: Region](##java.lang.CharSequence)


    pub class ImpCharSequence[t: Region -> Type] {
        pub def toCharSequence(s: t[r]): CharSequence[r]
        pub def fromCharSequence(s: CharSequence[r]): t[r]
    }

    instance Interop/Lang.ImpCharSequence[StringBuilder] {
        pub def toCharSequence(s: StringBuilder[r]): CharSequence[r] = 
            let StringBuilder(s1) = s;
            CharSequence(unchecked_cast(s1 as ##java.lang.CharSequence))

        pub def fromCharSequence(s: CharSequence[r]): StringBuilder[r] = 
            let CharSequence(s1) = s;
            StringBuilder(unchecked_cast(s1 as ##java.lang.StringBuilder))
    }

}



namespace Interop/Lang/CharSequence {

    use Interop/Lang.CharSequence
    use Interop/Lang.CharSequence.{CharSequence}

    use Interop/Lang.ImpCharSequence

    pub def getHH(cs: CharSequence[r]): ##java.lang.CharSequence = 
        let CharSequence(cs1) = cs;
        cs1

    pub def wrapHH(_: Region[r], prim: ##java.lang.CharSequence): CharSequence[r] = 
        CharSequence(prim)

    pub def toCharSequenceHH[t: Region -> Type, r: Region](s: t[r]): ##java.lang.CharSequence with ImpCharSequence[t] = 
        Interop/Lang/ImpCharSequence.toCharSequence(s) |> getHH


    pub def toString(cs: CharSequence[r]): String \ Read(r) = 
        import java.lang.CharSequence.toString(): String \ r;
        let CharSequence(cs1) = cs;
        toString(cs1)

    pub def isEmpty(cs: CharSequence[r]): Bool \ Read(r) = 
        import java.lang.CharSequence.isEmpty(): Bool \ r;
        let CharSequence(cs1) = cs;
        isEmpty(cs1)

    pub def length(cs: CharSequence[r]): Int32 \ Read(r) = 
        import java.lang.CharSequence.length(): Int32 \ r;
        let CharSequence(cs1) = cs;
        length(cs1)

    pub def charAt(ix: Int32, cs: CharSequence[r]): Result[String, Char] \ Read(r) = 
        Result.tryCatch(_ -> {
            import java.lang.CharSequence.charAt(Int32): Char \ r;
            let CharSequence(cs1) = cs;
            charAt(cs1, ix)
        })

    pub def subSequence(start: {start = Int32}, end: {end = Int32}, cs: CharSequence[r]): Result[String, CharSequence[r]] \ {Read(r), Write(r)} = 
        Result.tryCatch(_ -> {
            import java.lang.CharSequence.subSequence(Int32, Int32): ##java.lang.CharSequence \ r;
            let CharSequence(cs1) = cs;
            CharSequence(subSequence(cs1, start.start, end.end))
        })

}
