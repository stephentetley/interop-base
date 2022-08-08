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
    
    /// Abstract Class
    /// Represents a Number.
    ///
    pub enum Number(##java.lang.Number)

    pub class SubNumber[x: Type] {
        pub def ucast(s: x): Number
        pub def dcast(s: Number): x
    }

}


namespace Interop/Lang/Number {


    use Interop/Lang.Number;
    use Interop/Lang.Number.{Number};

    pub def getHH(x: Number): ##java.lang.Number = 
        let Number(x1) = x;
        x1

    ///
    ///
    ///
    pub def byteValue(x: Number): Int8 =
        import java.lang.Number.byteValue(): Int8 & Pure;
        let Number(x1) = x;
        byteValue(x1)

    pub def shortValue(x: Number): Int16 =
        import java.lang.Number.shortValue(): Int16 & Pure;
        let Number(x1) = x;
        shortValue(x1)

    pub def intValue(x: Number): Int32 =
        import java.lang.Number.intValue(): Int32 & Pure;
        let Number(x1) = x;
        intValue(x1)

    pub def longValue(x: Number): Int64 =
        import java.lang.Number.longValue(): Int64 & Pure;
        let Number(x1) = x;
        longValue(x1)

    ///
    ///
    ///
    pub def doubleValue(x: Number): Float64 =
        import java.lang.Number.doubleValue(): Float64 & Pure;
        let Number(x1) = x;
        doubleValue(x1)

    pub def floatValue(x: Number): Float32 =
        import java.lang.Number.floatValue(): Float32 & Pure;
        let Number(x1) = x;
        floatValue(x1)

}
