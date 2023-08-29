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
    
    use Interop.Text.NumberFormat.{NumberFormat}
    use Interop.Text.Format.{Format}

    /// Abstract Class
    /// Represents a NumberFormat.
    /// "Immutable with Setter"
    pub enum NumberFormat(##java.text.NumberFormat)

    pub enum MutNumberFormat[_: Region](##java.text.NumberFormat)

    /// NumberFormat "builders" in the JDK return void...
    pub type alias NumberFormatInit[r: Region] = MutNumberFormat[r] -> Result[String, Unit] \ r
    
    pub class SubNumberFormat[t: Type] {
        pub def toNumberFormat(s: t): NumberFormat
        pub def fromNumberFormat(s: NumberFormat): t
    }

    instance SubFormat[NumberFormat] {
        pub def toFormat(fmt: NumberFormat): Format = 
            let NumberFormat(fmt1) = fmt;
            Format(unchecked_cast(fmt1 as ##java.text.Format))

        pub def fromFormat(fmt: Format): NumberFormat = 
            let Format(fmt1) = fmt;
            NumberFormat(unchecked_cast(fmt1 as ##java.text.NumberFormat))
    }

}


mod Interop.Text.NumberFormat {

    use Interop.Text.NumberFormat
    use Interop.Text.NumberFormat.{NumberFormat}
    use Interop.Text.MutNumberFormat
    use Interop.Text.MutNumberFormat.{MutNumberFormat}
    use Interop.Text.NumberFormatInit
    use Interop.Text.SubNumberFormat
    
    use Interop.Lang.Number
    use Interop.Lang.Number.{Number}
    use Interop.Math.RoundingMode
    use Interop.Math.RoundingMode.{RoundingMode}
    use Interop.Util.Currency
    use Interop.Util.Currency.{Currency}
    use Locale.{Locale}

    pub def getHH(nf: NumberFormat): ##java.text.NumberFormat = 
        let NumberFormat(nf1) = nf;
        nf1

    pub def wrapHH(prim: ##java.text.NumberFormat): NumberFormat = 
        NumberFormat(prim)

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


    pub def getInstance(_: Region[r], init: NumberFormatInit[r]): Result[String, NumberFormat] \ IO = 
        import static java.text.NumberFormat.getInstance(): ##java.text.NumberFormat \ IO;
        let nf1 = getInstance();
        MutNumberFormat(nf1) |> init |> Result.map(_ -> NumberFormat(nf1))
        
    


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
        import static java.text.NumberFormat.getAvailableLocales(): Array[##java.util.Locale, rc] \ {rc, IO } ;
        let _ = Array#{} @ rc;
        getAvailableLocales() |> Array.toList |> List.map(Locale)
    }
   
    pub def getCurrency(nf: NumberFormat): Result[String, Currency] = 
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.getCurrency(): ##java.util.Currency \ {};
            let NumberFormat(nf1) = nf;
            getCurrency(nf1) |> Currency
        })
   


    pub def isGroupingUsed(nf: NumberFormat): Bool = 
        import java.text.NumberFormat.isGroupingUsed(): Bool \ {};
        let NumberFormat(nf1) = nf;
        isGroupingUsed(nf1)


    pub def getMaximumIntegerDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMaximumIntegerDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMaximumIntegerDigits(nf1)


    pub def getMinimumIntegerDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMinimumIntegerDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMinimumIntegerDigits(nf1)


    pub def getMaximumFractionDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMaximumFractionDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMaximumFractionDigits(nf1)


    pub def getMinimumFractionDigits(nf: NumberFormat): Int32 = 
        import java.text.NumberFormat.getMinimumFractionDigits(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        getMinimumFractionDigits(nf1)


    pub def isParseIntegerOnly(nf: NumberFormat): Bool = 
        import java.text.NumberFormat.isParseIntegerOnly(): Bool \ {};
        let NumberFormat(nf1) = nf;
        isParseIntegerOnly(nf1)


    pub def getRoundingMode(nf: NumberFormat): RoundingMode = 
        import java.text.NumberFormat.getRoundingMode(): ##java.math.RoundingMode \ {};
        let NumberFormat(nf1) = nf;
        getRoundingMode(nf1) |> RoundingMode 

    /// Setters

    pub def setCurrency!(_: Region[r], c: Currency, nf: MutNumberFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.setCurrency(##java.util.Currency): Unit \ r;
            let MutNumberFormat(nf1) = nf;
            let Currency(c1) = c;
            setCurrency(nf1, c1)
        })

    pub def setGroupingUsed!(_: Region[r], used: Bool, nf: MutNumberFormat[r]): Unit \ r =
        import java.text.NumberFormat.setGroupingUsed(Bool): Unit \ r;
        let MutNumberFormat(nf1) = nf;
        setGroupingUsed(nf1, used)


    pub def setMaximumIntegerDigits!(_: Region[r], n: Int32, nf: MutNumberFormat[r]): Unit \ r =
        import java.text.NumberFormat.setMaximumIntegerDigits(Int32): Unit \ r;
        let MutNumberFormat(nf1) = nf;
        setMaximumIntegerDigits(nf1, n)


    pub def setMinimumIntegerDigits!(n: Int32, nf: MutNumberFormat[r]): Unit \ r =
        import java.text.NumberFormat.setMinimumIntegerDigits(Int32): Unit \ r;
        let MutNumberFormat(nf1) = nf;
        setMinimumIntegerDigits(nf1, n)


    pub def setMaximumFractionDigits!(_: Region[r], n: Int32, nf: MutNumberFormat[r]): Unit \ r =
        import java.text.NumberFormat.setMaximumFractionDigits(Int32): Unit \ r;
        let MutNumberFormat(nf1) = nf;
        setMaximumFractionDigits(nf1, n)

    pub def setMinimumFractionDigits!(_: Region[r], n: Int32, nf: MutNumberFormat[r]): Unit \ r =
        import java.text.NumberFormat.setMinimumFractionDigits(Int32): Unit \ r;
        let MutNumberFormat(nf1) = nf;
        setMinimumFractionDigits(nf1, n)

    pub def setParseIntegerOnly!(_: Region[r], used: Bool, nf: MutNumberFormat[r]): Unit \ r =
        import java.text.NumberFormat.setParseIntegerOnly(Bool): Unit \ r;
        let MutNumberFormat(nf1) = nf;
        setParseIntegerOnly(nf1, used)


    pub def setRoundingMode!(mode: RoundingMode, nf: MutNumberFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.NumberFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let MutNumberFormat(nf1) = nf;
            let RoundingMode(mode1) = mode;
            setRoundingMode(nf1, mode1)
        })

}
