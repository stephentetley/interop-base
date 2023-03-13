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
    /// Represents a Java Double class.
    ///
    pub enum Double(##java.lang.Double)


    instance Interop/Flix.Marshal[Double] {
        pub def toJavaObject(x: Double): ##java.lang.Object = 
            let Double(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): Double = 
            Double(unchecked_cast(o as ##java.lang.Double))
    }

}

namespace Interop/Lang/Double {


    use Interop/Lang.Double
    use Interop/Lang.Double.{Double}


    pub def getHH(d: Double): ##java.lang.Double = 
        let Double(d1) = d;
        d1

    pub def wrapHH(prim: ##java.lang.Double): Double = 
        Double(prim)

    pub def toString(x: Double): String =
        import java.lang.Double.toString(): String \ {};
        let Double(x1) = x;
        toString(x1)

    pub def equals(x: Double, y: Double): Bool =
        import java.lang.Double.equals(##java.lang.Object): Bool \ {};
        let Double(x1) = x;
        let Double(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compare(x: Float64, y: Float64): Int32 =
        import static java.lang.Double.compare(Float64, Float64): Int32 \ {};
        compare(x, y)

    pub def compareTo(x: Double, y: Double): Int32 =
        import java.lang.Double.compareTo(##java.lang.Double): Int32 \ {};
        let Double(x1) = x;
        let Double(y1) = y;
        compareTo(x1, y1)

    pub def parseDouble(s: String): Float64 = 
        import static java.lang.Double.parseDouble(String): Float64 \ {};
        parseDouble(s)

    pub def doubleValue(x: Double): Float64 =
        import java.lang.Double.doubleValue(): Float64 \ {};
        let Double(x1) = x;
        doubleValue(x1)

    pub def hashCode(x: Double): Int32 =
        import java.lang.Double.hashCode(): Int32 \ {};
        let Double(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Float64): Double =
        import static java.lang.Double.valueOf(Float64): ##java.lang.Double \ {};
        valueOf(x) |> Double



}
