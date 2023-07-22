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

mod Interop.Flix {


    /// Unfortunately this class does not work as well as `GoesToJava` - mutable types are not handled...
    /// Needs a rethink...
    /// Possibly functions with a `ComesFromJava` result type should just produce `##java.lang.Object` and 
    /// leave it to a higher layer to marshal to a Flix type.

    pub class ComesFromJava[a: Type] {
        pub def fromJavaObject(o: ##java.lang.Object): a
    }

    instance ComesFromJava[##java.lang.Object] {
        pub def fromJavaObject(o: ##java.lang.Object): ##java.lang.Object = o
    }

    instance ComesFromJava[String] {
        pub def fromJavaObject(o: ##java.lang.Object): String = unchecked_cast(o as String)
    }

    instance ComesFromJava[Bool] {
        pub def fromJavaObject(o: ##java.lang.Object): Bool = 
            Interop.Flix.ComesFromJava.boolFromJava(unchecked_cast(o as ##java.lang.Boolean))
    }

    instance ComesFromJava[Char] {
        pub def fromJavaObject(o: ##java.lang.Object): Char = 
            Interop.Flix.ComesFromJava.charFromJava(unchecked_cast(o as ##java.lang.Character))
    }

    instance ComesFromJava[Int8] {
        pub def fromJavaObject(o: ##java.lang.Object): Int8 = 
            Interop.Flix.ComesFromJava.int8FromJava(unchecked_cast(o as ##java.lang.Byte))
    }

    instance ComesFromJava[Int16] {
        pub def fromJavaObject(o: ##java.lang.Object): Int16 = 
            Interop.Flix.ComesFromJava.int16FromJava(unchecked_cast(o as ##java.lang.Short))
    }

    instance ComesFromJava[Int32] {
        pub def fromJavaObject(o: ##java.lang.Object): Int32 = 
            Interop.Flix.ComesFromJava.int32FromJava(unchecked_cast(o as ##java.lang.Integer))
    }
    
    instance ComesFromJava[Int64] {
        pub def fromJavaObject(o: ##java.lang.Object): Int64 = 
            Interop.Flix.ComesFromJava.int64FromJava(unchecked_cast(o as ##java.lang.Long))
    }

    instance ComesFromJava[BigInt] {
        pub def fromJavaObject(o: ##java.lang.Object): BigInt = unchecked_cast(o as BigInt)
    }

    instance ComesFromJava[Float32] {
        pub def fromJavaObject(o: ##java.lang.Object): Float32 = 
            Interop.Flix.ComesFromJava.float32FromJava(unchecked_cast(o as ##java.lang.Float))
    }

    instance ComesFromJava[Float64] {
        pub def fromJavaObject(o: ##java.lang.Object): Float64 = 
            Interop.Flix.ComesFromJava.float64FromJava(unchecked_cast(o as ##java.lang.Double))
    }

    instance ComesFromJava[BigDecimal] {
        pub def fromJavaObject(o: ##java.lang.Object): BigDecimal = unchecked_cast(o as BigDecimal)
    }

    instance ComesFromJava[Option[a]] with ComesFromJava[a] {
        pub def fromJavaObject(o: ##java.lang.Object): Option[a] = 
            Interop.Util.Optional.hhToOption(Interop.Flix.ComesFromJava.fromJavaObject, unchecked_cast(o as ##java.util.Optional))
               
    }

}


mod Interop.Flix.ComesFromJava {


    pub def boolFromJava(b: ##java.lang.Boolean): Bool = 
        import java.lang.Boolean.booleanValue(): Bool \ {};
        booleanValue(b)

    pub def boolFromJavaObject(o: ##java.lang.Object): Bool = 
        boolFromJava(unchecked_cast(o as ##java.lang.Boolean))


    pub def charFromJava(c: ##java.lang.Character): Char = 
        import java.lang.Character.charValue(): Char \ {};
        charValue(c)

    pub def charFromJavaObject(o: ##java.lang.Object): Char = 
        charFromJava(unchecked_cast(o as ##java.lang.Character))


    pub def int8FromJava(i: ##java.lang.Byte): Int8 = 
        import java.lang.Byte.byteValue(): Int8 \ {};
        byteValue(i)

    pub def int8FromJavaObject(o: ##java.lang.Object): Int8 = 
        int8FromJava(unchecked_cast(o as ##java.lang.Byte))


    pub def int16FromJava(i: ##java.lang.Short): Int16 = 
        import java.lang.Short.shortValue(): Int16 \ {};
        shortValue(i)

    pub def int16FromJavaObject(o: ##java.lang.Object): Int16 = 
        int16FromJava(unchecked_cast(o as ##java.lang.Short))


    pub def int32FromJava(i: ##java.lang.Integer): Int32 = 
        import java.lang.Integer.intValue(): Int32 \ {};
        intValue(i)

    pub def int32FromJavaObject(o: ##java.lang.Object): Int32 = 
        int32FromJava(unchecked_cast(o as ##java.lang.Integer))        

    pub def int64FromJava(i: ##java.lang.Long): Int64 = 
        import java.lang.Long.longValue(): Int64 \ {};
        longValue(i)

    pub def int64FromJavaObject(o: ##java.lang.Object): Int64 = 
        int64FromJava(unchecked_cast(o as ##java.lang.Long))

    pub def float32FromJava(d: ##java.lang.Float): Float32 = 
        import java.lang.Float.floatValue(): Float32 \ {};
        floatValue(d)

    pub def float32FromJavaObject(o: ##java.lang.Object): Float32 = 
        float32FromJava(unchecked_cast(o as ##java.lang.Float))


    pub def float64FromJava(d: ##java.lang.Double): Float64 = 
        import java.lang.Double.doubleValue(): Float64 \ {};
        doubleValue(d)

    pub def float64FromJavaObject(o: ##java.lang.Object): Float64 = 
        float64FromJava(unchecked_cast(o as ##java.lang.Double))

}

