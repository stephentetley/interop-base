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

mod Interop.Text {
    
    use Interop.Text.DecimalFormat
    use Interop.Text.DecimalFormat.{DecimalFormat}
    use Interop.Text.Format
    use Interop.Text.Format.{Format}
    use Interop.Text.NumberFormat
    use Interop.Text.NumberFormat.{NumberFormat}

    ///
    /// Represents a DecimalFormat.
    /// "Immutable with Setter"
    ///
    pub enum DecimalFormat(##java.text.DecimalFormat)

    pub enum MutDecimalFormat[_: Region](##java.text.DecimalFormat)

    /// DecimalFormat "builders" in the JDK return void...
    pub type alias DecimalFormatInit[r: Region] = MutDecimalFormat[r] -> Result[String, Unit] \ r

    instance SubFormat[DecimalFormat] {
        pub def toFormat(fmt: DecimalFormat): Format = 
            let DecimalFormat(fmt1) = fmt;
            Format(unchecked_cast(fmt1 as ##java.text.Format))

        pub def fromFormat(fmt: Format): DecimalFormat = 
            let Format(fmt1) = fmt;
            DecimalFormat(unchecked_cast(fmt1 as ##java.text.DecimalFormat))
    }

    instance SubNumberFormat[DecimalFormat] {
        pub def toNumberFormat(fmt: DecimalFormat): NumberFormat = 
            let DecimalFormat(fmt1) = fmt;
            NumberFormat(unchecked_cast(fmt1 as ##java.text.NumberFormat))

        pub def fromNumberFormat(fmt: NumberFormat): DecimalFormat = 
            let NumberFormat(fmt1) = fmt;
            DecimalFormat(unchecked_cast(fmt1 as ##java.text.DecimalFormat))
    }
}


mod Interop.Text.DecimalFormat {

    use Interop.Text.DecimalFormat
    use Interop.Text.DecimalFormat.{DecimalFormat}
    use Interop.Text.MutDecimalFormat
    use Interop.Text.MutDecimalFormat.{MutDecimalFormat}
    use Interop.Text.DecimalFormatInit

    use Interop.Text.DecimalFormatSymbols
    use Interop.Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    use Interop.Math.RoundingMode
    use Interop.Math.RoundingMode.{RoundingMode}
    use Interop.Util.Currency
    use Interop.Util.Currency.{Currency}

    pub def getHH(df: DecimalFormat): ##java.text.DecimalFormat = 
        let DecimalFormat(df1) = df;
        df1

    pub def wrapHH(prim: ##java.text.DecimalFormat): DecimalFormat = 
        DecimalFormat(prim)


    ///
    /// Returns a new DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r], init: DecimalFormatInit[r]): Result[String, DecimalFormat] \ IO =
        import new java.text.DecimalFormat(): ##java.text.DecimalFormat \ IO as new1;
        let nf1 = new1();
        MutDecimalFormat(nf1) |> init |> Result.map(_ -> DecimalFormat(nf1))
    

    ///
    /// Returns a new DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def newWithPattern(_: Region[r], patt: String, init: DecimalFormatInit[r]): Result[String, DecimalFormat] \ IO =
        import new java.text.DecimalFormat(String): ##java.text.DecimalFormat \ IO as new1;
        let nf1 = new1(patt);
        MutDecimalFormat(nf1) |> init |> Result.map(_ -> DecimalFormat(nf1))
    


    ///
    /// Returns a new mutable DecimalFormat.
    /// Uses DecimalFormatSymbols so not in IO
    ///
    pub def newWithDecimalFormatSymbols(_: Region[r], 
                                        patt: String, 
                                        syms: DecimalFormatSymbols, 
                                        init: DecimalFormatInit[r]): Result[String, DecimalFormat] \ r = 
        import new java.text.DecimalFormat(String, ##java.text.DecimalFormatSymbols): ##java.text.DecimalFormat \ {} as new1;
        let syms1 = Interop.Text.DecimalFormatSymbols.getHH(syms);
        let nf1 = new1(patt, syms1);
        MutDecimalFormat(nf1) |> init |> Result.map(_ -> DecimalFormat(nf1))


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


    pub def getDecimalFormatSymbols(df: DecimalFormat): Result[String, DecimalFormatSymbols] =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.getDecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ {};
            let DecimalFormat(df1) = df;
            DecimalFormatSymbols(getDecimalFormatSymbols(df1))
        })

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

    /// Setters


    pub def setCurrency!(cur: Currency, df: MutDecimalFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.setCurrency(##java.util.Currency): Unit  \ r;
            let MutDecimalFormat(df1) = df;
            let Currency(cur1) = cur;
            setCurrency(df1, cur1)
        })


    /// 
    pub def setDecimalFormatSymbols!(syms: DecimalFormatSymbols, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setDecimalFormatSymbols(##java.text.DecimalFormatSymbols): Unit \ r ;
        let MutDecimalFormat(df1) = df;
        let DecimalFormatSymbols(syms1) = syms;
        setDecimalFormatSymbols(df1, syms1)
        

    pub def setDecimalSeparatorAlwaysShown!(shown: Bool, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setDecimalSeparatorAlwaysShown(Bool): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setDecimalSeparatorAlwaysShown(df1, shown)

    pub def setGroupingSize!(sz: Int32, df: MutDecimalFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.setGroupingSize(Int32): Unit \ r;
            let MutDecimalFormat(df1) = df;
            setGroupingSize(df1, sz)
        })

    pub def setMaximumIntegerDigits!(n: Int32, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setMaximumIntegerDigits(Int32): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setMaximumIntegerDigits(df1, n)

    pub def setMinimumIntegerDigits!(n: Int32, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setMinimumIntegerDigits(Int32): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setMinimumIntegerDigits(df1, n)


    pub def setMaximumFractionDigits!(n: Int32, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setMaximumFractionDigits(Int32): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setMaximumFractionDigits(df1, n)


    pub def setMinimumFractionDigits!(n: Int32, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setMinimumFractionDigits(Int32): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setMinimumFractionDigits(df1, n)
        

    pub def setMultiplier!(n: Int32, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setMultiplier(Int32): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setMultiplier(df1, n)


    pub def setNegativePrefix!(s: String, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setNegativePrefix(String): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setNegativePrefix(df1, s)


    pub def setNegativeSuffix!(s: String, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setNegativeSuffix(String): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setNegativeSuffix(df1, s)

    pub def setParseBigDecimal!(pbd: Bool, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setParseBigDecimal(Bool): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setParseBigDecimal(df1, pbd)


    pub def setPositivePrefix!(s: String, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setPositivePrefix(String): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setPositivePrefix(df1, s)

    pub def setPositiveSuffix!(s: String, df: MutDecimalFormat[r]): Unit \ r =
        import java.text.DecimalFormat.setPositiveSuffix(String): Unit \ r;
        let MutDecimalFormat(df1) = df;
        setPositiveSuffix(df1, s)
   
    pub def setRoundingMode!(mode: RoundingMode, df: MutDecimalFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let MutDecimalFormat(df1) = df;
            let RoundingMode(mode1) = mode;
            setRoundingMode(df1, mode1)
        })

    ///
    pub def applyPattern!(patt: String, df: MutDecimalFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.applyPattern(String): Unit \ r;
            let MutDecimalFormat(df1) = df;
            applyPattern(df1, patt)
        })

    ///
    pub def applyLocalizedPattern!(patt: String, df: MutDecimalFormat[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormat.applyLocalizedPattern(String): Unit \ r;
            let MutDecimalFormat(df1) = df;
            applyLocalizedPattern(df1, patt)
        })

}
