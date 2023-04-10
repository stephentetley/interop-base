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

    use Interop.Lang.Integer
    use Interop.Lang.Integer.{Integer}

    ///
    /// Represents a Java Integer class.
    ///
    pub enum Integer(##java.lang.Integer)


    instance Interop.Flix.Marshal[Integer] {
        pub def toJavaObject(x: Integer): ##java.lang.Object = 
            let Integer(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): Integer = 
            Integer(unchecked_cast(o as ##java.lang.Integer))
    }

}

mod Interop.Lang.Integer {


    use Interop.Lang.Integer
    use Interop.Lang.Integer.{Integer}

    pub def getHH(i: Integer): ##java.lang.Integer = 
        let Integer(i1) = i;
        i1

    pub def wrapHH(prim: ##java.lang.Integer): Integer = 
        Integer(prim)

    pub def toString(x: Integer): String =
        import java.lang.Integer.toString(): String \ {};
        let Integer(x1) = x;
        toString(x1)

    pub def equals(x: Integer, y: Integer): Bool =
        import java.lang.Integer.equals(##java.lang.Object): Bool \ {};
        let Integer(x1) = x;
        let Integer(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compare(x: Int32, y: Int32): Int32 =
        import static java.lang.Integer.compare(Int32, Int32): Int32 \ {};
        compare(x, y)

    pub def compareTo(x: Integer, y: Integer): Int32 =
        import java.lang.Integer.compareTo(##java.lang.Integer): Int32 \ {};
        let Integer(x1) = x;
        let Integer(y1) = y;
        compareTo(x1, y1)

    pub def parseInt(s: String): Int32 = 
        import static java.lang.Integer.parseInt(String): Int32 \ {};
        parseInt(s)

    pub def intValue(x: Integer): Int32 =
        import java.lang.Integer.intValue(): Int32 \ {};
        let Integer(x1) = x;
        intValue(x1)

    pub def hashCode(x: Integer): Int32 =
        import java.lang.Integer.hashCode(): Int32 \ {};
        let Integer(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Int32): Integer =
        import static java.lang.Integer.valueOf(Int32): ##java.lang.Integer \ {};
        valueOf(x) |> Integer



}
