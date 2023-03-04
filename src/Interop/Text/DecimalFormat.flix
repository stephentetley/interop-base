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
    /// Represents a DecimalFormat.
    /// "Immutable with Setter"
    ///
    pub enum DecimalFormat(##java.text.DecimalFormat)

    

    instance SubNumberFormat[DecimalFormat] {
        pub def toNumberFormat(fmt: DecimalFormat): NumberFormat = 
            let DecimalFormat(fmt1) = fmt;
            NumberFormat(unsafe_cast fmt1 as ##java.text.NumberFormat)

        pub def fromNumberFormat(fmt: NumberFormat): DecimalFormat = 
            let NumberFormat(fmt1) = fmt;
            DecimalFormat(unsafe_cast fmt1 as ##java.text.DecimalFormat) 
    }

}


namespace Interop/Text/DecimalFormat {

    use Interop/Text.DecimalFormat
    use Interop/Text.DecimalFormat.{DecimalFormat}
    use Interop/Text.DecimalFormatSymbols
    use Interop/Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    use Interop/Math.RoundingMode
    use Interop/Math.RoundingMode.{RoundingMode}
    use Interop/Util.Currency
    use Interop/Util.Currency.{Currency}
    use Interop/Flix.ResultSetter
    use Interop/Flix.ResultSetter.ResultSetter

    pub def getHH(df: DecimalFormat): ##java.text.DecimalFormat = 
        let DecimalFormat(df1) = df;
        df1

    pub def wrapHH(prim: ##java.text.DecimalFormat): DecimalFormat = 
        DecimalFormat(prim)

    ///
    /// Returns a new DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(rc: Region[r], fs: List[ResultSetter[DecimalFormat, r]]): Result[String, DecimalFormat] \ {IO, Write(r)} =
        import new java.text.DecimalFormat(): ##java.text.DecimalFormat \ IO as new1;
        DecimalFormat(new1()) |> Interop/Flix/ResultSetter.apply(rc, fs)

    ///
    /// Returns a new DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def newWithPattern(rc: Region[r], patt: String, fs: List[ResultSetter[DecimalFormat, r]]): Result[String, DecimalFormat] \ {IO, Write(r)} =
        import new java.text.DecimalFormat(String): ##java.text.DecimalFormat \ IO as new1;
        DecimalFormat(new1(patt)) |> Interop/Flix/ResultSetter.apply(rc, fs)

    ///
    /// Returns a new mutable DecimalFormat.
    /// Uses DecimalFormatSymbols so not in IO
    ///
    pub def newWithDecimalFormatSymbols(rc: Region[r], 
                                        patt: String, 
                                        syms: DecimalFormatSymbols, 
                                        fs: List[ResultSetter[DecimalFormat, r]]): Result[String, DecimalFormat] \ Write(r) =
        import new java.text.DecimalFormat(String, ##java.text.DecimalFormatSymbols): ##java.text.DecimalFormat \ {} as new1;
        let syms1 = Interop/Text/DecimalFormatSymbols.getHH(syms);
        DecimalFormat(new1(patt, syms1)) |> Interop/Flix/ResultSetter.apply(rc, fs)


    pub def hashCode(df: DecimalFormat): Int32 =
        import java.text.DecimalFormat.hashCode(): Int32 \ {};
        let DecimalFormat(df1) = df;
        hashCode(df1)


    pub def getCurrency(df: DecimalFormat): Result[String, Currency] =
        Interop/Flix/Util.try(_ -> {
            import java.text.DecimalFormat.getCurrency(): ##java.util.Currency \ {};
            let DecimalFormat(df1) = df;
            getCurrency(df1) |> Currency
        })


    pub def setCurrency!(cur: Currency): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setCurrency(##java.util.Currency): Unit  \ r;
            let DecimalFormat(df1) = df;
            let Currency(cur1) = cur;
            setCurrency(df1, cur1)
        )


    pub def getDecimalFormatSymbols(df: DecimalFormat): Result[String, DecimalFormatSymbols] =
        Interop/Flix/Util.try(_ -> {
            import java.text.DecimalFormat.getDecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ {};
            let DecimalFormat(df1) = df;
            DecimalFormatSymbols(getDecimalFormatSymbols(df1))
        })

    /// TODO - remove region from DecimalFormatSymbols and make "immutable with Setter"
    pub def setDecimalFormatSymbols!(syms: DecimalFormatSymbols): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setDecimalFormatSymbols(##java.text.DecimalFormatSymbols): Unit \ r ;
            let DecimalFormat(df1) = df;
            let DecimalFormatSymbols(syms1) = syms;
            setDecimalFormatSymbols(df1, syms1)
        )

    pub def setGroupingSize!(sz: Int32): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setGroupingSize(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setGroupingSize(df1, sz)
        )

    pub def setMaximumIntegerDigits!(n: Int32): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setMaximumIntegerDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMaximumIntegerDigits(df1, n)
        )

    pub def setMinimumIntegerDigits!(n: Int32): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setMinimumIntegerDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMinimumIntegerDigits(df1, n)
        )

    pub def setMaximumFractionDigits!(n: Int32): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setMaximumFractionDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMaximumFractionDigits(df1, n)
        )


    pub def setMinimumFractionDigits!(n: Int32): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setMinimumFractionDigits(Int32): Unit \ r;
            let DecimalFormat(df1) = df;
            setMinimumFractionDigits(df1, n)
        )


    pub def setNegativePrefix!(s: String): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setNegativePrefix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setNegativePrefix(df1, s)
        )

    pub def setNegativeSuffix!(s: String): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setNegativeSuffix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setNegativeSuffix(df1, s)
        )

    pub def setPositivePrefix!(s: String): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setPositivePrefix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setPositivePrefix(df1, s)
        )

    pub def setPositiveSuffix!(s: String): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setPositiveSuffix(String): Unit \ r;
            let DecimalFormat(df1) = df;
            setPositiveSuffix(df1, s)
        )
   
    pub def setRoundingMode!(mode: RoundingMode): ResultSetter[DecimalFormat, r] =
        Interop/Flix/ResultSetter.try(df ->
            import java.text.DecimalFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let DecimalFormat(df1) = df;
            let RoundingMode(mode1) = mode;
            setRoundingMode(df1, mode1)
        )


    ///
    pub def toPattern(df: DecimalFormat): String \ Read(r) =
        import java.text.DecimalFormat.toPattern(): String \ r;
        let DecimalFormat(df1) = df;
        toPattern(df1)


    ///
    pub def toLocalizedPattern(df: DecimalFormat): String \ Read(r) =
        import java.text.DecimalFormat.toLocalizedPattern(): String \ r;
        let DecimalFormat(df1) = df;
        toLocalizedPattern(df1)

    ///
    pub def applyPattern!(patt: String, df: DecimalFormat): Result[String, Unit] \ Write(r) =
        try {
            import java.text.DecimalFormat.applyPattern(String): Unit \ r;
            let DecimalFormat(df1) = df;
            applyPattern(df1, patt) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    ///
    pub def applyLocalizedPattern!(patt: String, df: DecimalFormat): Result[String, Unit] \ Write(r) =
        try {
            import java.text.DecimalFormat.applyLocalizedPattern(String): Unit \ r;
            let DecimalFormat(df1) = df;
            applyLocalizedPattern(df1, patt) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
