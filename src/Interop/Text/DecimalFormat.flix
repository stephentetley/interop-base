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
    
    use Interop/Text.DecimalFormat
    use Interop/Text.DecimalFormat.{DecimalFormat}
    use Interop/Text.NumberFormat
    use Interop/Text.NumberFormat.{NumberFormat}

    ///
    /// Represents a DecimalFormat.
    /// "Immutable with Setter"
    ///
    pub enum DecimalFormat(##java.text.DecimalFormat)

    

    instance SubNumberFormat[DecimalFormat] {
        pub def toNumberFormat(fmt: DecimalFormat): NumberFormat = 
            let DecimalFormat(fmt1) = fmt;
            NumberFormat(unchecked_cast(fmt1 as ##java.text.NumberFormat))

        pub def fromNumberFormat(fmt: NumberFormat): DecimalFormat = 
            let NumberFormat(fmt1) = fmt;
            DecimalFormat(unchecked_cast(fmt1 as ##java.text.DecimalFormat))
    }

}


namespace Interop/Text/DecimalFormat {

    use Interop/Text.DecimalFormat
    use Interop/Text.DecimalFormat.{DecimalFormat}
    use Interop/Text/DecimalFormat.DecimalFormatProperty
    use Interop/Text/DecimalFormat.DecimalFormatProperty.{
        ApplyPattern, ApplyLocalizedPattern, CurrencyP, 
        DecimalFormatSymbolsP, DecimalSeparatorAlwaysShown, GroupingSize, 
        GroupingUsed, MaximumFractionDigits, MaximumIntegerDigits, 
        MinimumFractionDigits, MinimumIntegerDigits, Multiplier, 
        NegativePrefix, NegativeSuffix, ParseBigDecimal, 
        ParseIntegerOnly, PositivePrefix, PositiveSuffix,
        RoundingModeP
    }

    use Interop/Text.DecimalFormatSymbols
    use Interop/Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    use Interop/Math.RoundingMode
    use Interop/Math.RoundingMode.{RoundingMode}
    use Interop/Util.Currency
    use Interop/Util.Currency.{Currency}
    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def getHH(df: DecimalFormat): ##java.text.DecimalFormat = 
        let DecimalFormat(df1) = df;
        df1

    pub def wrapHH(prim: ##java.text.DecimalFormat): DecimalFormat = 
        DecimalFormat(prim)


    pub enum DecimalFormatProperty {
        case ApplyPattern(String)
        case ApplyLocalizedPattern(String)
        case CurrencyP(Currency)
        case DecimalFormatSymbolsP(DecimalFormatSymbols)
        case DecimalSeparatorAlwaysShown(Bool)
        case GroupingSize(Int32)
        case GroupingUsed(Bool)
        case MaximumFractionDigits(Int32)
        case MaximumIntegerDigits(Int32)
        case MinimumFractionDigits(Int32)
        case MinimumIntegerDigits(Int32)
        case Multiplier(Int32)
        case NegativePrefix(String)
        case NegativeSuffix(String)
        case ParseBigDecimal(Bool)
        case ParseIntegerOnly(Bool)
        case PositivePrefix(String)
        case PositiveSuffix(String)
        case RoundingModeP(RoundingMode)
    }

    pub def makeSetter(rc: Region[r], xs: List[DecimalFormatProperty]): Setter[DecimalFormat, r] = 
        use Interop/Flix/Setter.{castSetter};
        def f(x) = match x {
            case ApplyPattern(x1)                   => applyPattern!(rc, x1)
            case ApplyLocalizedPattern(x1)          => applyLocalizedPattern!(rc, x1)
            case CurrencyP(x1)                      => setCurrency!(rc, x1)
            case DecimalFormatSymbolsP(x1)          => setDecimalFormatSymbols!(rc, x1)
            case DecimalSeparatorAlwaysShown(x1)    => setDecimalSeparatorAlwaysShown!(rc, x1)
            case GroupingSize(x1)                   => setGroupingSize!(rc, x1)
            case GroupingUsed(x1)                   => castSetter(Interop/Text/SubNumberFormat.toNumberFormat, Interop/Text/NumberFormat.setGroupingUsed!(rc, x1))
            case MaximumFractionDigits(x1)          => setMaximumFractionDigits!(rc, x1)
            case MaximumIntegerDigits(x1)           => setMaximumIntegerDigits!(rc, x1)
            case MinimumFractionDigits(x1)          => setMinimumFractionDigits!(rc, x1)
            case MinimumIntegerDigits(x1)           => setMinimumIntegerDigits!(rc, x1)
            case Multiplier(x1)                     => setMultiplier!(rc, x1)
            case NegativePrefix(x1)                 => setNegativePrefix!(rc, x1)
            case NegativeSuffix(x1)                 => setNegativeSuffix!(rc, x1)
            case ParseBigDecimal(x1)                => setParseBigDecimal!(rc, x1)
            case ParseIntegerOnly(x1)               => castSetter(Interop/Text/SubNumberFormat.toNumberFormat, Interop/Text/NumberFormat.setParseIntegerOnly!(rc, x1))
            case PositivePrefix(x1)                 => setPositivePrefix!(rc, x1)
            case PositiveSuffix(x1)                 => setPositiveSuffix!(rc, x1)
            case RoundingModeP(x1)                  => setRoundingMode!(rc, x1)
        };
        Interop/Flix/Setter.makeSetter(rc, f, xs)

    ///
    /// Returns a new DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(props: List[DecimalFormatProperty]): Result[String, DecimalFormat] \ IO = region rc {
        import new java.text.DecimalFormat(): ##java.text.DecimalFormat \ IO as new1;
        DecimalFormat(new1()) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    ///
    /// Returns a new DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def newWithPattern(patt: String, props: List[DecimalFormatProperty]): Result[String, DecimalFormat] \ IO = region rc {
        import new java.text.DecimalFormat(String): ##java.text.DecimalFormat \ IO as new1;
        DecimalFormat(new1(patt)) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }


    ///
    /// Returns a new mutable DecimalFormat.
    /// Uses DecimalFormatSymbols so not in IO
    ///
    pub def newWithDecimalFormatSymbols(patt: String, 
                                        syms: DecimalFormatSymbols, 
                                        props: List[DecimalFormatProperty]): Result[String, DecimalFormat] = region rc {
        import new java.text.DecimalFormat(String, ##java.text.DecimalFormatSymbols): ##java.text.DecimalFormat \ {} as new1;
        let syms1 = Interop/Text/DecimalFormatSymbols.getHH(syms);
        DecimalFormat(new1(patt, syms1)) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    pub def hashCode(df: DecimalFormat): Int32 =
        import java.text.DecimalFormat.hashCode(): Int32 \ {};
        let DecimalFormat(df1) = df;
        hashCode(df1)


    pub def getCurrency(df: DecimalFormat): Result[String, Currency] =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.getCurrency(): ##java.util.Currency \ {};
            let DecimalFormat(df1) = df;
            getCurrency(df1) |> Currency
        })


    pub def setCurrency!(_: Region[r], cur: Currency): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setCurrency(##java.util.Currency): Unit  \ r;
            let DecimalFormat(df1) = df;
            let Currency(cur1) = cur;
            setCurrency(df1, cur1)
        )


    pub def getDecimalFormatSymbols(df: DecimalFormat): Result[String, DecimalFormatSymbols] =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.getDecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ {};
            let DecimalFormat(df1) = df;
            DecimalFormatSymbols(getDecimalFormatSymbols(df1))
        })

    /// TODO - remove region from DecimalFormatSymbols and make "immutable with Setter"
    pub def setDecimalFormatSymbols!(_: Region[r], syms: DecimalFormatSymbols): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setDecimalFormatSymbols(##java.text.DecimalFormatSymbols): Unit \ r ;
            let DecimalFormat(df1) = df;
            let DecimalFormatSymbols(syms1) = syms;
            setDecimalFormatSymbols(df1, syms1)
        )

    pub def setDecimalSeparatorAlwaysShown!(_: Region[r], shown: Bool): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setDecimalSeparatorAlwaysShown(Bool): Unit \ r;
            let DecimalFormat(df1) = df;
            setDecimalSeparatorAlwaysShown(df1, shown)
        )

    pub def setGroupingSize!(_: Region[r], sz: Int32): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setGroupingSize(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setGroupingSize(df1, sz)
        )

    pub def setMaximumIntegerDigits!(_: Region[r], n: Int32): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setMaximumIntegerDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMaximumIntegerDigits(df1, n)
        )

    pub def setMinimumIntegerDigits!(_: Region[r], n: Int32): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setMinimumIntegerDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMinimumIntegerDigits(df1, n)
        )

    pub def setMaximumFractionDigits!(_: Region[r], n: Int32): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setMaximumFractionDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMaximumFractionDigits(df1, n)
        )


    pub def setMinimumFractionDigits!(_: Region[r], n: Int32): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setMinimumFractionDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMinimumFractionDigits(df1, n)
        )

    pub def setMultiplier!(_: Region[r], n: Int32): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setMultiplier(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMultiplier(df1, n)
        )

    pub def setNegativePrefix!(_: Region[r], s: String): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setNegativePrefix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setNegativePrefix(df1, s)
        )

    pub def setNegativeSuffix!(_: Region[r], s: String): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setNegativeSuffix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setNegativeSuffix(df1, s)
        )

    pub def setParseBigDecimal!(_: Region[r], pbd: Bool): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setParseBigDecimal(Bool): Unit \ r;
            let DecimalFormat(df1) = df;
            setParseBigDecimal(df1, pbd)
        )

    pub def setPositivePrefix!(_: Region[r], s: String): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setPositivePrefix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setPositivePrefix(df1, s)
        )

    pub def setPositiveSuffix!(_: Region[r], s: String): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setPositiveSuffix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setPositiveSuffix(df1, s)
        )
   
    pub def setRoundingMode!(_: Region[r], mode: RoundingMode): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let DecimalFormat(df1) = df;
            let RoundingMode(mode1) = mode;
            setRoundingMode(df1, mode1)
        )


    ///
    pub def applyPattern!(_: Region[r], patt: String): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.applyPattern(String): Unit \ r;
            let DecimalFormat(df1) = df;
            applyPattern(df1, patt)
        )

    ///
    pub def applyLocalizedPattern!(_: Region[r], patt: String): Setter[DecimalFormat, r] =
        Interop/Flix/Setter.lift(df ->
            import java.text.DecimalFormat.applyLocalizedPattern(String): Unit \ r;
            let DecimalFormat(df1) = df;
            applyLocalizedPattern(df1, patt)
        )



    ///
    pub def toPattern(df: DecimalFormat): String =
        import java.text.DecimalFormat.toPattern(): String \ {};
        let DecimalFormat(df1) = df;
        toPattern(df1)


    ///
    pub def toLocalizedPattern(df: DecimalFormat): String =
        import java.text.DecimalFormat.toLocalizedPattern(): String \ {};
        let DecimalFormat(df1) = df;
        toLocalizedPattern(df1)
}
