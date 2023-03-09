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
    /// Represents a Java Long class.
    ///
    pub enum Long(##java.lang.Long)


    instance Interop/Flix.Marshal[Long] {
        pub def toJavaObject(x: Long): ##java.lang.Object = 
            let Long(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Long = 
            Long(unsafe_cast o as ##java.lang.Long)
    }

}

namespace Interop/Lang/Long {


    use Interop/Lang.Long
    use Interop/Lang.Long.{Long}


    pub def getHH(i: Long): ##java.lang.Long = 
        let Long(i1) = i;
        i1

    pub def wrapHH(prim: ##java.lang.Long): Long = 
        Long(prim)

    pub def toString(x: Long): String =
        import java.lang.Long.toString(): String \ {};
        let Long(x1) = x;
        toString(x1)

    pub def equals(x: Long, y: Long): Bool =
        import java.lang.Long.equals(##java.lang.Object): Bool \ {};
        let Long(x1) = x;
        let Long(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def compare(x: Int64, y: Int64): Int32 =
        import static java.lang.Long.compare(Int64, Int64): Int32 \ {};
        compare(x, y)

    pub def compareTo(x: Long, y: Long): Int32 =
        import java.lang.Long.compareTo(##java.lang.Long): Int32 \ {};
        let Long(x1) = x;
        let Long(y1) = y;
        compareTo(x1, y1)

    pub def parseLong(s: String): Int64 = 
        import static java.lang.Long.parseLong(String): Int64 \ {};
        parseLong(s)

    pub def intValue(x: Long): Int32 =
        import java.lang.Long.intValue(): Int32 \ {};
        let Long(x1) = x;
        intValue(x1)

    pub def longValue(x: Long): Int64 =
        import java.lang.Long.longValue(): Int64 \ {};
        let Long(x1) = x;
        longValue(x1)


    pub def hashCode(x: Long): Int32 =
        import java.lang.Long.hashCode(): Int32 \ {};
        let Long(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Int64): Long =
        import static java.lang.Long.valueOf(Int64): ##java.lang.Long \ {};
        valueOf(x) |> Long



}
