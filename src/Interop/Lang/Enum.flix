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
    /// Represents a Java Enum.
    /// Class
    ///
    pub enum Enum[_: Type](##java.lang.Enum)

    pub class SubEnum[t: Type] {
        pub def toEnum[a: Type](s: t): Enum[a]
        pub def fromEnum[a: Type](s: Enum[a]): t
    }

}

namespace Interop/Lang/Enum {


    use Interop/Lang.Enum
    use Interop/Lang.Enum.{Enum}

    pub def toString(x: Enum[a]): String =
        import java.lang.Enum.toString(): String \ {};
        let Enum(x1) = x;
        toString(x1)

    pub def equals(x: Enum[a], y: Enum[a]): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool \ {};
        let Enum(x1) = x;
        let Enum(y1) = y;
        equals(x1, checked_cast(y1))

    pub def hashCode(x: Enum[a]): Int32 =
        import java.lang.Enum.hashCode(): Int32 \ {};
        let Enum(x1) = x;
        hashCode(x1)

    pub def name(x: Enum[a]): String =
        import java.lang.Enum.name(): String \ {};
        let Enum(x1) = x;
        name(x1)

    pub def ordinal(x: Enum[a]): Int32 =
        import java.lang.Enum.ordinal(): Int32 \ {};
        let Enum(x1) = x;
        ordinal(x1)

}
