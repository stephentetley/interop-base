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
    /// Represents a Java Byte class.
    ///
    pub enum Byte(##java.lang.Byte)


    instance Interop/Flix.Marshal[Byte] {
        pub def toJavaObject(x: Byte): ##java.lang.Object = 
            let Byte(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Byte = 
            Byte(unsafe_cast o as ##java.lang.Byte)
    }

}

namespace Interop/Lang/Byte {


    use Interop/Lang.Byte
    use Interop/Lang.Byte.{Byte}


    pub def getHH(i: Byte): ##java.lang.Byte = 
        let Byte(i1) = i;
        i1

    pub def wrapHH(prim: ##java.lang.Byte): Byte = 
        Byte(prim)


    pub def toString(x: Byte): String =
        import java.lang.Byte.toString(): String \ {};
        let Byte(x1) = x;
        toString(x1)

    pub def equals(x: Byte, y: Byte): Bool =
        import java.lang.Byte.equals(##java.lang.Object): Bool \ {};
        let Byte(x1) = x;
        let Byte(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def compare(x: Int8, y: Int8): Int32 =
        import static java.lang.Byte.compare(Int8, Int8): Int32 \ {};
        compare(x, y)

    pub def compareTo(x: Byte, y: Byte): Int32 =
        import java.lang.Byte.compareTo(##java.lang.Byte): Int32 \ {};
        let Byte(x1) = x;
        let Byte(y1) = y;
        compareTo(x1, y1)

    pub def parseByte(s: String): Int8 = 
        import static java.lang.Byte.parseByte(String): Int8 \ {};
        parseByte(s)

    pub def intValue(x: Byte): Int32 =
        import java.lang.Byte.intValue(): Int32 \ {};
        let Byte(x1) = x;
        intValue(x1)

    pub def byteValue(x: Byte): Int8 =
        import java.lang.Byte.byteValue(): Int8 \ {};
        let Byte(x1) = x;
        byteValue(x1)


    pub def hashCode(x: Byte): Int32 =
        import java.lang.Byte.hashCode(): Int32 \ {};
        let Byte(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Int8): Byte =
        import static java.lang.Byte.valueOf(Int8): ##java.lang.Byte \ {};
        valueOf(x) |> Byte



}
