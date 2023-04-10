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

mod Interop.Text {
    
    /// Abstract Class
    /// Represents a NumberFormat.
    /// "Immutable with Setter"
    pub enum NumberFormat(##java.text.NumberFormat)

    
    pub class SubNumberFormat[t: Type] {
        pub def toNumberFormat(s: t): NumberFormat
        pub def fromNumberFormat(s: NumberFormat): t
    }

}


mod Interop.Text.NumberFormat {

    use Interop.Text.NumberFormat
    use Interop.Text.NumberFormat.{NumberFormat}
    use Interop.Text.SubNumberFormat
    use Interop.Text.NumberFormat.NumberFormatProperty
    use Interop.Text.NumberFormat.NumberFormatProperty.{
        CurrencyP, GroupingUsed, MaximumFractionDigits, MaximumIntegerDigits,
        MinimumFractionDigits, MinimumIntegerDigits, ParseIntegerOnly, RoundingModeP
    }

    use Interop.Lang.Number
    use Interop.Lang.Number.{Number}
    use Interop.Math.RoundingMode
    use Interop.Math.RoundingMode.{RoundingMode}
    use Interop.Util.Currency
    use Interop.Util.Currency.{Currency}
    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}
    use Interop.Flix.Setter
    use Interop.Flix.Setter.Setter

    pub def getHH(nf: NumberFormat): ##java.text.NumberFormat = 
        let NumberFormat(nf1) = nf;
        nf1

    pub def wrapHH(prim: ##java.text.NumberFormat): NumberFormat = 
        NumberFormat(prim)


    pub enum NumberFormatProperty {
        case CurrencyP(Currency)
        case GroupingUsed(Bool)
        case MaximumFractionDigits(Int32)
        case MaximumIntegerDigits(Int32)
        case MinimumFractionDigits(Int32)
        case MinimumIntegerDigits(Int32)
        case ParseIntegerOnly(Bool)
        case RoundingModeP(RoundingMode)
    }

    pub def makeSetter(rc: Region[r], xs: List[NumberFormatProperty]): Setter[NumberFormat, r] = 
        def f(x) = match x {
            case CurrencyP(x1)                  => setCurrency!(rc, x1)
            case GroupingUsed(x1)               => setGroupingUsed!(rc, x1)
            case MaximumFractionDigits(x1)      => setMaximumFractionDigits!(rc, x1)
            case MaximumIntegerDigits(x1)       => setMaximumIntegerDigits!(rc, x1)
            case MinimumFractionDigits(x1)      => setMinimumFractionDigits!(rc, x1)
            case MinimumIntegerDigits(x1)       => setMinimumIntegerDigits!(rc, x1)
            case ParseIntegerOnly(x1)           => setParseIntegerOnly!(rc, x1)
            case RoundingModeP(x1)              => setRoundingMode!(rc, x1)
        };
        Interop.Flix.Setter.makeSetter(rc, f, xs)


    // No constructor / SPI / use getInstance

    pub def equals(x: NumberFormat, y: NumberFormat): Bool =
        import java.text.NumberFormat.equals(##java.lang.Object): Bool \ {};
        let NumberFormat(x1) = x;
        let NumberFormat(y1) = y;
        equals(x1, checked_cast(y1))


    pub def hashCode(nf: NumberFormat): Int32 =
        import java.text.NumberFormat.hashCode(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        hashCode(nf1)


    // pub def clone(nf: NumberFormat): Int32 =
    //     import java.text.NumberFormat.clone(): ##java.lang.Object \ {};
    //     let NumberFormat(nf1) = nf;
    //     (clone(nf1) as ##java.text.NumberFormat) |> NumberFormat


    pub def getInstance(props: List[NumberFormatProperty]): Result[String, NumberFormat] \ IO = region rc {
        import static java.text.NumberFormat.getInstance(): ##java.text.NumberFormat \ IO;
        NumberFormat(getInstance()) |> Interop.Flix.Setter.apply(rc, makeSetter(rc, props))
    }


    pub def parse(s: String, nf: NumberFormat): Result[String, Number] = 
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.parse(String): ##java.lang.Number \ {};
            let NumberFormat(nf1) = nf;
            Number(parse(nf1, s))
        })

    pub def formatInt64(n: Int64, nf: NumberFormat): Result[String, String] = 
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.format(Int64): String \ {};
            let NumberFormat(nf1) = nf;
            format(nf1, n)
        })

    pub def formatFloat64(d: Float64, nf: NumberFormat): Result[String, String] =  
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.format(Float64): String \ {};
            let NumberFormat(nf1) = nf;
            format(nf1, d)
        })


    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        import static java.text.NumberFormat.getAvailableLocales(): Array[##java.util.Locale, rc] \ { Write(rc), IO } ;
        let _ = Array#{} @ rc;
        getAvailableLocales() |> Array.toList |> List.map(Locale)
    }
   
    pub def getCurrency(nf: NumberFormat): Result[String, Currency] = 
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.getCurrency(): ##java.util.Currency \ {};
            let NumberFormat(nf1) = nf;
            getCurrency(nf1) |> Currency
        })
   
    pub def setCurrency!(_: Region[r], c: Currency): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setCurrency(##java.util.Currency): Unit \ r;
            let NumberFormat(nf1) = nf;
            let Currency(c1) = c;
            setCurrency(nf1, c1)
        )


    pub def isGroupingUsed(nf: NumberFormat): Bool = 
        import java.text.NumberFormat.isGroupingUsed(): Bool \ {};
        let NumberFormat(nf1) = nf;
        isGroupingUsed(nf1)

    pub def setGroupingUsed!(_: Region[r], used: Bool): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setGroupingUsed(Bool): Unit \ r;
            let NumberFormat(nf1) = nf;
            setGroupingUsed(nf1, used)
        )

    pub def getMaximumIntegerDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMaximumIntegerDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMaximumIntegerDigits(nf1)

    pub def setMaximumIntegerDigits!(_: Region[r], n: Int32): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setMaximumIntegerDigits(Int32): Unit \ r;
            let NumberFormat(nf1) = nf;
            setMaximumIntegerDigits(nf1, n)
        )

    pub def getMinimumIntegerDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMinimumIntegerDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMinimumIntegerDigits(nf1)

    pub def setMinimumIntegerDigits!(_: Region[r], n: Int32): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setMinimumIntegerDigits(Int32): Unit \ r;
            let NumberFormat(nf1) = nf;
            setMinimumIntegerDigits(nf1, n)
        )

    pub def getMaximumFractionDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMaximumFractionDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMaximumFractionDigits(nf1)

    pub def setMaximumFractionDigits!(_: Region[r], n: Int32): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setMaximumFractionDigits(Int32): Unit \ r;
            let NumberFormat(nf1) = nf;
            setMaximumFractionDigits(nf1, n)
        )

    pub def getMinimumFractionDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMinimumFractionDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMinimumFractionDigits(nf1)

    pub def setMinimumFractionDigits!(_: Region[r], n: Int32): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setMinimumFractionDigits(Int32): Unit \ r;
            let NumberFormat(nf1) = nf;
            setMinimumFractionDigits(nf1, n)
        )


    pub def isParseIntegerOnly(nf: NumberFormat): Bool = 
        import java.text.NumberFormat.isParseIntegerOnly(): Bool \ {};
        let NumberFormat(nf1) = nf;
        isParseIntegerOnly(nf1)

    pub def setParseIntegerOnly!(_: Region[r], used: Bool): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setParseIntegerOnly(Bool): Unit \ r;
            let NumberFormat(nf1) = nf;
            setParseIntegerOnly(nf1, used)
        )

    pub def getRoundingMode(nf: NumberFormat): RoundingMode = 
        import java.text.NumberFormat.getRoundingMode(): ##java.math.RoundingMode \ {};
        let NumberFormat(nf1) = nf;
        getRoundingMode(nf1) |> RoundingMode 
   
    pub def setRoundingMode!(_: Region[r], mode: RoundingMode): Setter[NumberFormat, r] =
        Interop.Flix.Setter.lift(nf ->
            import java.text.NumberFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let NumberFormat(nf1) = nf;
            let RoundingMode(mode1) = mode;
            setRoundingMode(nf1, mode1)
        )

}
