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

    /// Interface...
    /// Immutable  - but in Java handles both String and StringBuilder[r]....

    use Interop.Lang.CharSequence
    use Interop.Lang.CharSequence.{CharSequence}

    pub enum CharSequence(##java.lang.CharSequence)


    pub class ImpCharSequence[t: Type] {
        pub def toCharSequence(s: t): CharSequence
        pub def fromCharSequence(s: CharSequence): t
    }


    instance Interop.Flix.Marshal[CharSequence] {
        pub def toJavaObject(x: CharSequence): ##java.lang.Object = 
            let CharSequence(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): CharSequence = 
            CharSequence(unchecked_cast(o as ##java.lang.CharSequence))
    }

    instance Interop.Lang.ImpCharSequence[String] {
        pub def toCharSequence(s: String): CharSequence =
            let cs: ##java.lang.CharSequence = checked_cast(s);
            CharSequence(cs)

        pub def fromCharSequence(s: CharSequence): String = 
            let CharSequence(s1) = s;
            unchecked_cast(s1 as String)
    }

}



mod Interop.Lang.CharSequence {

    use StringBuilder.{StringBuilder}

    use Interop.Lang.CharSequence
    use Interop.Lang.CharSequence.{CharSequence}
    use Interop.Lang.ImpCharSequence

    pub def getHH(cs: CharSequence): ##java.lang.CharSequence = 
        let CharSequence(cs1) = cs;
        cs1

    pub def wrapHH(prim: ##java.lang.CharSequence): CharSequence = 
        CharSequence(prim)

    pub def toCharSequenceHH(s: t): ##java.lang.CharSequence with ImpCharSequence[t] = 
        Interop.Lang.ImpCharSequence.toCharSequence(s) |> getHH


    pub def toString(cs: CharSequence): String = 
        import java.lang.CharSequence.toString(): String \ {};
        let CharSequence(cs1) = cs;
        toString(cs1)

    pub def isEmpty(cs: CharSequence): Bool = 
        import java.lang.CharSequence.isEmpty(): Bool \ {};
        let CharSequence(cs1) = cs;
        isEmpty(cs1)

    pub def length(cs: CharSequence): Int32 = 
        import java.lang.CharSequence.length(): Int32 \ {};
        let CharSequence(cs1) = cs;
        length(cs1)

    pub def charAt(ix: Int32, cs: CharSequence): Result[String, Char] = 
        Result.tryCatch(_ -> {
            import java.lang.CharSequence.charAt(Int32): Char \ {};
            let CharSequence(cs1) = cs;
            charAt(cs1, ix)
        })

    pub def subSequence(start: {start = Int32}, end: {end = Int32}, cs: CharSequence): Result[String, CharSequence] = 
        Result.tryCatch(_ -> {
            import java.lang.CharSequence.subSequence(Int32, Int32): ##java.lang.CharSequence \ {};
            let CharSequence(cs1) = cs;
            CharSequence(subSequence(cs1, start.start, end.end))
        })

    // Define explicit "from" functions because `CharSequence` is mutable but String isn't.

    pub def fromString(s: String): CharSequence = 
        Interop.Lang.ImpCharSequence.toCharSequence(s)

    pub def fromStringBuilder(sb: StringBuilder[r]): CharSequence \ r = 
        let StringBuilder(sb1) = sb;
        let cs: ##java.lang.CharSequence = checked_cast(sb1);
        checked_ecast(CharSequence(cs))

}
