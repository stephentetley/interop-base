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

mod Interop.Lang {

    use Interop.Lang.Float
    use Interop.Lang.Float.{Float}

    ///
    /// Represents a Java Float class.
    ///
    pub enum Float(##java.lang.Float)


    instance Interop.Flix.GoesToJava[Float] {
        pub def toJavaObject(x: Float): ##java.lang.Object = 
            let Float(x1) = x;
            checked_cast(x1)
    }

}

mod Interop.Lang.Float {


    use Interop.Lang.Float
    use Interop.Lang.Float.{Float}


    pub def getHH(d: Float): ##java.lang.Float = 
        let Float(d1) = d;
        d1

    pub def wrapHH(prim: ##java.lang.Float): Float = 
        Float(prim)

    pub def toString(x: Float): String =
        import java.lang.Float.toString(): String \ {};
        let Float(x1) = x;
        toString(x1)

    pub def equals(x: Float, y: Float): Bool =
        import java.lang.Float.equals(##java.lang.Object): Bool \ {};
        let Float(x1) = x;
        let Float(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compare(x: Float32, y: Float32): Int32 =
        import static java.lang.Float.compare(Float32, Float32): Int32 \ {};
        compare(x, y)

    pub def compareTo(x: Float, y: Float): Int32 =
        import java.lang.Float.compareTo(##java.lang.Float): Int32 \ {};
        let Float(x1) = x;
        let Float(y1) = y;
        compareTo(x1, y1)

    pub def parseFloat(s: String): Float32 = 
        import static java.lang.Float.parseFloat(String): Float32 \ {};
        parseFloat(s)

    pub def floatValue(x: Float): Float32 =
        import java.lang.Float.floatValue(): Float32 \ {};
        let Float(x1) = x;
        floatValue(x1)

    pub def hashCode(x: Float): Int32 =
        import java.lang.Float.hashCode(): Int32 \ {};
        let Float(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Float32): Float =
        import static java.lang.Float.valueOf(Float32): ##java.lang.Float \ {};
        valueOf(x) |> Float



}
