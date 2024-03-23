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

mod Interop.Math {


    /// Immutable 
    /// Potential implies new numeric types in Flix (apropos Haskell's Data.Fixed) that
    /// pair the context or use type class dictionaries...
    /// > pub enum BigDecimalWithContext[MathContext] = (MathContext, BigDecimal)
    /// > pub type alias UnlimitedDecimal = BigDecimalWithContext[Unlimited]
    pub enum MathContext(##java.math.MathContext)


}

mod Interop.Math.MathContext {

    use Interop.Math.MathContext
    use Interop.Math.MathContext.{MathContext}
    use Interop.Math.RoundingMode
    use Interop.Math.RoundingMode.{RoundingMode}

    pub def getHH(x: MathContext): ##java.math.MathContext = 
        let MathContext(x1) = x;
        x1

    pub def wrapHH(prim: ##java.math.MathContext): MathContext =
        MathContext(prim)


    pub def make(precision: Int32): MathContext = 
        import java_new java.math.MathContext(Int32): ##java.math.MathContext \ {} as new1;
        MathContext(new1(precision))

    pub def makeWithRoundingMode(precision: Int32, rm: RoundingMode): MathContext = 
        import java_new java.math.MathContext(Int32, ##java.math.RoundingMode): ##java.math.MathContext \ {} as new1;
        let RoundingMode(rm1) = rm;
        MathContext(new1(precision, rm1))

    pub def toString(c: MathContext): String = 
        import java.math.MathContext.toString(): String \ {};
        let MathContext(c1) = c;
        toString(c1)


    pub def equals(x: MathContext, y: MathContext): Bool =
        import java.math.MathContext.equals(##java.lang.Object): Bool \ {};
        let MathContext(x1) = x;
        let MathContext(y1) = y;
        equals(x1, checked_cast(y1))

    pub def decimal128(): MathContext = 
        import static java_get_field java.math.MathContext.DECIMAL128: ##java.math.MathContext \ {} as get_DECIMAL128;
        MathContext(get_DECIMAL128())

    pub def decimal32(): MathContext = 
        import static java_get_field java.math.MathContext.DECIMAL32: ##java.math.MathContext \ {} as get_DECIMAL32;
        MathContext(get_DECIMAL32())

    pub def decimal64(): MathContext = 
        import static java_get_field java.math.MathContext.DECIMAL64: ##java.math.MathContext \ {} as get_DECIMAL64;
        MathContext(get_DECIMAL64())

    pub def unlimited(): MathContext = 
        import static java_get_field java.math.MathContext.UNLIMITED: ##java.math.MathContext \ {} as get_UNLIMITED;
        MathContext(get_UNLIMITED())

    pub def getPrecision(c: MathContext): Int32 = 
        import java.math.MathContext.getPrecision(): Int32 \ {};
        let MathContext(c1) = c;
        getPrecision(c1)

    pub def getRoundingMode(c: MathContext): RoundingMode = 
        import java.math.MathContext.getRoundingMode(): ##java.math.RoundingMode \ {};
        let MathContext(c1) = c;
        RoundingMode(getRoundingMode(c1))


}
