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
    
    use Interop/Text.CompactNumberFormat
    use Interop/Text.CompactNumberFormat.{CompactNumberFormat}
    use Interop/Text.NumberFormat
    use Interop/Text.NumberFormat.{NumberFormat}

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
            NumberFormat(unchecked_cast(fmt1 as ##java.text.NumberFormat))

        pub def fromNumberFormat(fmt: NumberFormat): CompactNumberFormat = 
            let NumberFormat(fmt1) = fmt;
            CompactNumberFormat(unchecked_cast(fmt1 as ##java.text.CompactNumberFormat))
    }

}


namespace Interop/Text/CompactNumberFormat {

    use Interop/Text.CompactNumberFormat
    use Interop/Text.CompactNumberFormat.{CompactNumberFormat}
    use Interop/Text/CompactNumberFormat.CompactNumberFormatProperty
    use Interop/Text/CompactNumberFormat.CompactNumberFormatProperty.{
        CurrencyP, GroupingSize, 
        GroupingUsed, MaximumFractionDigits,
        MaximumIntegerDigits, MinimumFractionDigits, 
        MinimumIntegerDigits, ParseBigDecimal, 
        ParseIntegerOnly, RoundingModeP
    }

    use Interop/Math.RoundingMode
    use Interop/Math.RoundingMode.{RoundingMode}
    use Interop/Util.Currency
    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def getHH(cf: CompactNumberFormat): ##java.text.CompactNumberFormat = 
        let CompactNumberFormat(cf1) = cf;
        cf1

    pub def wrapHH(prim: ##java.text.CompactNumberFormat): CompactNumberFormat = 
        CompactNumberFormat(prim)


    pub enum CompactNumberFormatProperty {
        case CurrencyP(Currency)
        case GroupingSize(Int32)
        case GroupingUsed(Bool)
        case MaximumFractionDigits(Int32)
        case MaximumIntegerDigits(Int32)
        case MinimumFractionDigits(Int32)
        case MinimumIntegerDigits(Int32)
        case ParseBigDecimal(Bool)
        case ParseIntegerOnly(Bool)
        case RoundingModeP(RoundingMode)
    }

    pub def makeSetter(rc: Region[r], xs: List[CompactNumberFormatProperty]): Setter[CompactNumberFormat, r] = 
        use Interop/Flix/Setter.{castSetter};
        def f(x) = match x {
            case CurrencyP(x1)                  => castSetter(Interop/Text/SubNumberFormat.toNumberFormat, Interop/Text/NumberFormat.setCurrency!(rc, x1))
            case GroupingSize(x1)               => setGroupingSize!(rc, x1)
            case GroupingUsed(x1)               => setGroupingUsed!(rc, x1)
            case MaximumFractionDigits(x1)      => setMaximumFractionDigits!(rc, x1)
            case MaximumIntegerDigits(x1)       => setMaximumIntegerDigits!(rc, x1)
            case MinimumFractionDigits(x1)      => setMinimumFractionDigits!(rc, x1)
            case MinimumIntegerDigits(x1)       => setMinimumIntegerDigits!(rc, x1)
            case ParseBigDecimal(x1)            => setParseBigDecimal!(rc, x1)
            case ParseIntegerOnly(x1)           => setParseIntegerOnly!(rc, x1)
            case RoundingModeP(x1)              => setRoundingMode!(rc, x1)
        };
        Interop/Flix/Setter.makeSetter(rc, f, xs)



    pub def equals(x: CompactNumberFormat, y: CompactNumberFormat): Bool =
        import java.text.CompactNumberFormat.equals(##java.lang.Object): Bool \ {};
        let CompactNumberFormat(x1) = x;
        let CompactNumberFormat(y1) = y;
        equals(x1, checked_cast(y1))

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


    pub def setGroupingSize!(_: Region[r], n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setGroupingSize(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setGroupingSize(nf1, n)
        )


    pub def setGroupingUsed!(_: Region[r], used: Bool): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setGroupingUsed(Bool): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setGroupingUsed(nf1, used)
        )

    pub def setMaximumFractionDigits!(_: Region[r], n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMaximumFractionDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMaximumFractionDigits(nf1, n)
        )

    pub def setMaximumIntegerDigits!(_: Region[r], n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMaximumIntegerDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMaximumIntegerDigits(nf1, n)
        )

    pub def setMinimumFractionDigits!(_: Region[r], n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMinimumFractionDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMinimumFractionDigits(nf1, n)
        )

    pub def setMinimumIntegerDigits!(_: Region[r], n: Int32): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setMinimumIntegerDigits(Int32): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setMinimumIntegerDigits(nf1, n)
        )


    pub def setParseBigDecimal!(_: Region[r], value: Bool): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setParseBigDecimal(Bool): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setParseBigDecimal(nf1, value)
        )


    pub def setParseIntegerOnly!(_: Region[r], value: Bool): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setParseIntegerOnly(Bool): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            setParseIntegerOnly(nf1, value)
        )


    pub def getRoundingMode(nf: CompactNumberFormat): RoundingMode = 
        import java.text.CompactNumberFormat.getRoundingMode(): ##java.math.RoundingMode \ {};
        let CompactNumberFormat(nf1) = nf;
        getRoundingMode(nf1) |> RoundingMode

    pub def setRoundingMode!(_: Region[r], mode: RoundingMode): Setter[CompactNumberFormat, r] =
        Interop/Flix/Setter.lift(nf ->
            import java.text.CompactNumberFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            let RoundingMode(mode1) = mode;
            setRoundingMode(nf1, mode1)
        )

}
