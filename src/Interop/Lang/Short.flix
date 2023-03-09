/*
 * Copyright 2023 Stephen Tetley
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
    /// Represents a Java Short class.
    ///
    pub enum Short(##java.lang.Short)


    instance Interop/Flix.Marshal[Short] {
        pub def toJavaObject(x: Short): ##java.lang.Object = 
            let Short(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Short = 
            Short(unsafe_cast o as ##java.lang.Short)
    }

}

namespace Interop/Lang/Short {


    use Interop/Lang.Short
    use Interop/Lang.Short.{Short}


    pub def toString(x: Short): String =
        import java.lang.Short.toString(): String \ {};
        let Short(x1) = x;
        toString(x1)

    pub def equals(x: Short, y: Short): Bool =
        import java.lang.Short.equals(##java.lang.Object): Bool \ {};
        let Short(x1) = x;
        let Short(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def compare(x: Int16, y: Int16): Int32 =
        import static java.lang.Short.compare(Int16, Int16): Int32 \ {};
        compare(x, y)

    pub def compareTo(x: Short, y: Short): Int32 =
        import java.lang.Short.compareTo(##java.lang.Short): Int32 \ {};
        let Short(x1) = x;
        let Short(y1) = y;
        compareTo(x1, y1)

    pub def parseShort(s: String): Int16 = 
        import static java.lang.Short.parseShort(String): Int16 \ {};
        parseShort(s)

    pub def intValue(x: Short): Int32 =
        import java.lang.Short.intValue(): Int32 \ {};
        let Short(x1) = x;
        intValue(x1)

    pub def shortValue(x: Short): Int16 =
        import java.lang.Short.shortValue(): Int16 \ {};
        let Short(x1) = x;
        shortValue(x1)


    pub def hashCode(x: Short): Int32 =
        import java.lang.Short.hashCode(): Int32 \ {};
        let Short(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Int16): Short =
        import static java.lang.Short.valueOf(Int16): ##java.lang.Short \ {};
        valueOf(x) |> Short



}
