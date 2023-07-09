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

/// Just operations with MathContext

mod Interop.Math.BigDecimalZ {

    use Interop.Math.MathContext
    use Interop.Math.MathContext.{MathContext}


    pub def abs(c: MathContext, d: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.abs(##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        abs(d, c1)

    pub def add(c: MathContext, d1: BigDecimal, d2: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.add(BigDecimal, ##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        add(d1, d2, c1)

    pub def divide(c: MathContext, d1: BigDecimal, d2: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.divide(BigDecimal, ##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        divide(d1, d2, c1)

    pub def multiply(c: MathContext, d1: BigDecimal, d2: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.multiply(BigDecimal, ##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        multiply(d1, d2, c1)

    pub def negate(c: MathContext, d: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.negate(##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        negate(d, c1)

    pub def plus(c: MathContext, d: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.plus(##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        plus(d, c1)

    pub def pow(c: MathContext, d: BigDecimal, n: Int32): BigDecimal = 
        import java.math.BigDecimal.pow(Int32, ##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        pow(d, n, c1)

    pub def remainder(c: MathContext, d1: BigDecimal, d2: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.remainder(BigDecimal, ##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        remainder(d1, d2, c1)

    pub def round(c: MathContext, d: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.round(##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        round(d, c1)

    pub def sqrt(c: MathContext, d: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.sqrt(##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        sqrt(d, c1)

    pub def subtract(c: MathContext, d1: BigDecimal, d2: BigDecimal): BigDecimal = 
        import java.math.BigDecimal.subtract(BigDecimal, ##java.math.MathContext): BigDecimal \ {};
        let MathContext(c1) = c;
        subtract(d1, d2, c1)

}
