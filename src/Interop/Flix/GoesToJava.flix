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


    // TODO 
    // There is a good case for having a singleton method toJavaObject class
    // and a toJavaObject / fromJavaObject class. 
    // `toJavaObject` would be applicable to types of kind Type, Region -> Type and Type -> Region -> Type, ...
    // Would `fromJavaObject` need to variations:
    // > def fromJavaObject(o: ##java.lang.Object): a
    // > def fromJavaObject(rc: Region[r], o: ##java.lang.Object): t[r]

    pub class GoesToJava[a] {
        pub def toJavaObject(x: a): ##java.lang.Object
    }

    instance GoesToJava[##java.lang.Object] {
        pub def toJavaObject(x: ##java.lang.Object): ##java.lang.Object = x
    }

    instance GoesToJava[String] {
        pub def toJavaObject(x: String): ##java.lang.Object = checked_cast(x)
    }

    instance GoesToJava[Bool] {
        pub def toJavaObject(x: Bool): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.boolToJava(x))
    }

    instance GoesToJava[Char] {
        pub def toJavaObject(x: Char): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.charToJava(x))
    }

    instance GoesToJava[Int8] {
        pub def toJavaObject(x: Int8): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.int8ToJava(x))
    }

    instance GoesToJava[Int16] {
        pub def toJavaObject(x: Int16): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.int16ToJava(x))
    }

    instance GoesToJava[Int32] {
        pub def toJavaObject(x: Int32): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.int32ToJava(x))
    }
    
    instance GoesToJava[Int64] {
        pub def toJavaObject(x: Int64): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.int64ToJava(x))
    }

    instance GoesToJava[BigInt] {
        pub def toJavaObject(x: BigInt): ##java.lang.Object = checked_cast(x)
    }

    instance GoesToJava[Float32] {
        pub def toJavaObject(x: Float32): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.float32ToJava(x))
    }

    instance GoesToJava[Float64] {
        pub def toJavaObject(x: Float64): ##java.lang.Object = checked_cast(Interop.Flix.GoesToJava.float64ToJava(x))
    }


    instance GoesToJava[Option[a]] with GoesToJava[a] {
        pub def toJavaObject(o: Option[a]): ##java.lang.Object =
            checked_cast(Interop.Util.Optional.fromOption1(o))    
    }

}


mod Interop.Flix.GoesToJava {


    pub def boolToJava(b: Bool): ##java.lang.Boolean = 
        import static java.lang.Boolean.valueOf(Bool): ##java.lang.Boolean \ {};
        valueOf(b)


    pub def charToJava(c: Char): ##java.lang.Character = 
        import static java.lang.Character.valueOf(Char): ##java.lang.Character \ {};
        valueOf(c)

    pub def int8ToJava(i: Int8): ##java.lang.Byte = 
        import static java.lang.Byte.valueOf(Int8): ##java.lang.Byte \ {};
        valueOf(i)

    pub def int16ToJava(i: Int16): ##java.lang.Short = 
        import static java.lang.Short.valueOf(Int16): ##java.lang.Short \ {};
        valueOf(i)

    pub def int32ToJava(i: Int32): ##java.lang.Integer = 
        import static java.lang.Integer.valueOf(Int32): ##java.lang.Integer \ {};
        valueOf(i)

    pub def int64ToJava(i: Int64): ##java.lang.Long = 
        import static java.lang.Long.valueOf(Int64): ##java.lang.Long \ {};
        valueOf(i)

    pub def float32ToJava(d: Float32): ##java.lang.Float = 
        import static java.lang.Float.valueOf(Float32): ##java.lang.Float \ {};
        valueOf(d)

    pub def float64ToJava(d: Float64): ##java.lang.Double = 
        import static java.lang.Double.valueOf(Float64): ##java.lang.Double \ {};
        valueOf(d)

}
