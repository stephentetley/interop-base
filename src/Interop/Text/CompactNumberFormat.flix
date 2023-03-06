/*
 * Copyright 2020 Stephen Tetley
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

namespace Interop/Text {
    
    ///
    /// Represents a CompactNumberFormat.
    /// "Immutable with Setter"
    ///
    /// Note the JDK appears to discourage using this class directly. e.g. use the
    /// abstract base class `NumberFormat` instantiated with the factory method `getCompactNumberInstance`.
    /// (See "SPI pattern")
    ///
    pub enum CompactNumberFormat(##java.text.CompactNumberFormat)

    instance SubNumberFormat[CompactNumberFormat] {
        pub def toNumberFormat(fmt: CompactNumberFormat): NumberFormat = 
            let CompactNumberFormat(fmt1) = fmt;
            NumberFormat(unsafe_cast fmt1 as ##java.text.NumberFormat)

        pub def fromNumberFormat(fmt: NumberFormat): CompactNumberFormat = 
            let NumberFormat(fmt1) = fmt;
            CompactNumberFormat(unsafe_cast fmt1 as ##java.text.CompactNumberFormat) 
    }

}


namespace Interop/Text/CompactNumberFormat {

    use Interop/Text.CompactNumberFormat
    use Interop/Text.CompactNumberFormat.{CompactNumberFormat}
    use Interop/Math.RoundingMode
    use Interop/Math.RoundingMode.{RoundingMode}
    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def getHH(cf: CompactNumberFormat): ##java.text.CompactNumberFormat = 
        let CompactNumberFormat(cf1) = cf;
        cf1

    pub def wrapHH(prim: ##java.text.CompactNumberFormat): CompactNumberFormat = 
        CompactNumberFormat(prim)

/*
    ///
    /// Returns a new mutable CompactNumberFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r]): CompactNumberFormat \ {IO, Write(r)} =
        import new java.text.CompactNumberFormat(): ##java.text.CompactNumberFormat \ {IO, r} as newDecimalFormat;
        newDecimalFormat() |> CompactNumberFormat

    ///
    /// Returns a new mutable CompactNumberFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def newWithPattern(_: Region[r], patt: String): CompactNumberFormat \ {IO, Write(r)} =
        import new java.text.CompactNumberFormat(String): ##java.text.CompactNumberFormat \ {IO, r} as newDecimalFormat;
        newDecimalFormat(patt) |> CompactNumberFormat

    ///
    /// Returns a new mutable CompactNumberFormat.
    /// Uses DecimalFormatSymbols so not in IO
    ///
    pub def newWithDecimalFormatSymbols(_: Region[r], patt: String, dfs: DecimalFormatSymbols[r]): CompactNumberFormat \ Write(r) =
        import new java.text.CompactNumberFormat(String, ##java.text.DecimalFormatSymbols): ##java.text.CompactNumberFormat \ r as newDecimalFormat;
        let dfs1 = Interop/Text/DecimalFormatSymbols.getHH(dfs);
        newDecimalFormat(patt, dfs1) |> CompactNumberFormat
*/

    pub def equals(x: CompactNumberFormat, y: CompactNumberFormat): Bool =
        import java.text.CompactNumberFormat.equals(##java.lang.Object): Bool \ {};
        let CompactNumberFormat(x1) = x;
        let CompactNumberFormat(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def hashCode(nf: CompactNumberFormat): Int32 =
        import java.text.CompactNumberFormat.hashCode(): Int32 \ {};
        let CompactNumberFormat(nf1) = nf;
        hashCode(nf1)


    pub def formatInt64(n: Int64, nf: CompactNumberFormat): Result[String, String] =
        Interop/Text/SubNumberFormat.toNumberFormat(nf)
            |> Interop/Text/NumberFormat.formatInt64(n)

    
    pub def formatFloat64(d: Float64, nf: CompactNumberFormat): Result[String, String] = 
        Interop/Text/SubNumberFormat.toNumberFormat(nf)
            |> Interop/Text/NumberFormat.formatFloat64(d)


    pub def getGroupingSize(nf: CompactNumberFormat): Int32 =
        import java.text.CompactNumberFormat.getGroupingSize(): Int32 \ {};
        let CompactNumberFormat(nf1) = nf;
        getGroupingSize(nf1)


    pub def setGroupingSize!(n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setGroupingSize(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setGroupingSize(nf1, n)
        )


    pub def setGroupingUsed!(used: Bool): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setGroupingUsed(Bool): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setGroupingUsed(nf1, used)
        )

    pub def setMaximumFractionDigits!(n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMaximumFractionDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMaximumFractionDigits(nf1, n)
        )

    pub def setMaximumIntegerDigits!(n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMaximumIntegerDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMaximumIntegerDigits(nf1, n)
        )

    pub def setMinimumFractionDigits!(n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMinimumFractionDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMinimumFractionDigits(nf1, n)
        )

    pub def setMinimumIntegerDigits!(n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMinimumIntegerDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMinimumIntegerDigits(nf1, n)
        )


    pub def setParseBigDecimal!(value: Bool): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setParseBigDecimal(Bool): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setParseBigDecimal(nf1, value)
        )


    pub def setParseIntegerOnly!(value: Bool): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setParseIntegerOnly(Bool): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setParseIntegerOnly(nf1, value)
        )


    pub def getRoundingMode(nf: CompactNumberFormat): RoundingMode = 
        import java.text.CompactNumberFormat.getRoundingMode(): ##java.math.RoundingMode \ {};
        let CompactNumberFormat(nf1) = nf;
        getRoundingMode(nf1) |> RoundingMode

    pub def setRoundingMode!(mode: RoundingMode): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            let RoundingMode(mode1) = mode;
            setRoundingMode(nf1, mode1)
        )

}
