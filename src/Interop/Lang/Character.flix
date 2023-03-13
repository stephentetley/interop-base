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

    ///
    /// Represents a Java Boolean.
    ///
    pub enum Character(##java.lang.Character)


    instance Interop/Flix.Marshal[Character] {
        pub def toJavaObject(x: Character): ##java.lang.Object = 
            let Character(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): Character = 
            Character(unchecked_cast(o as ##java.lang.Character))
    }


}

namespace Interop/Lang/Character {


    use Interop/Lang.Character
    use Interop/Lang.Character.{Character}


    pub def getHH(c: Character): ##java.lang.Character = 
        let Character(c1) = c;
        c1

    pub def wrapHH(prim: ##java.lang.Character): Character = 
        Character(prim)

    pub def toString(x: Character): String =
        import java.lang.Character.toString(): String \ {};
        let Character(x1) = x;
        toString(x1)

    pub def equals(x: Character, y: Character): Bool =
        import java.lang.Character.equals(##java.lang.Object): Bool \ {};
        let Character(x1) = x;
        let Character(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compare(x: Char, y: Char): Int32 =
        import static java.lang.Character.compare(Char, Char): Int32 \ {};
        compare(x, y)

    pub def charValue(x: Character): Char =
        import java.lang.Character.charValue(): Char \ {};
        let Character(x1) = x;
        charValue(x1)


    pub def charValueWithCodePoint(cp: Int32): Int32 =
        import static java.lang.Character.charCount(Int32): Int32 \ {};
        charCount(cp)

    pub def hashCode(x: Character): Int32 =
        import java.lang.Character.hashCode(): Int32 \ {};
        let Character(x1) = x;
        hashCode(x1)

    pub def valueOf(c: Char): Character =
        import static java.lang.Character.valueOf(Char): ##java.lang.Character \ {};
        valueOf(c) |> Character

    pub def getDirectionality(c: Char): Int8 =
        import static java.lang.Character.getDirectionality(Char): Int8 \ {};
        getDirectionality(c)

    pub def getName(cp: Int32): Option[String] =
        import static java.lang.Character.getName(Int32): String \ {};
        getName(cp) |> Object.toOption

    pub def getNumericValue(c: Char): Int32 =
        import static java.lang.Character.getNumericValue(Char): Int32 \ {};
        getNumericValue(c)

    pub def getType(c: Char): Int32 =
        import static java.lang.Character.getType(Char): Int32 \ {};
        getType(c)

    pub def highSurrogate(cp: Int32): Char =
        import static java.lang.Character.highSurrogate(Int32): Char \ {};
        highSurrogate(cp)

    pub def lowSurrogate(cp: Int32): Char =
        import static java.lang.Character.lowSurrogate(Int32): Char \ {};
        lowSurrogate(cp)

}
