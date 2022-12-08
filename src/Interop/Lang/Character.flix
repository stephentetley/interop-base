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


}

namespace Interop/Lang/Character {


    use Interop/Lang.Character
    use Interop/Lang.Character.{Character}


    pub def toString(x: Character): String =
        import java.lang.Character.toString(): String \ {};
        let Character(x1) = x;
        toString(x1)

    pub def equals(x: Character, y: Character): Bool =
        import java.lang.Character.equals(##java.lang.Object): Bool \ {};
        let Character(x1) = x;
        let Character(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

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

    pub def valueOf(x: Char): Character =
        import static java.lang.Character.valueOf(Char): ##java.lang.Character \ {};
        valueOf(x) |> Character

    pub def getName(cp: Int32): String =
        import static java.lang.Character.getName(Int32): String \ {};
        getName(cp)
}
