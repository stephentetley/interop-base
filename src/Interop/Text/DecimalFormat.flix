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
    /// Mutable, no alloc.
    ///
    pub enum DecimalFormat[_: Region](##java.text.DecimalFormat)

    

    instance SubNumberFormat[DecimalFormat] {
        pub def toNumberFormat(fmt: DecimalFormat[r]): NumberFormat[r] = 
            let DecimalFormat(fmt1) = fmt;
            NumberFormat(unsafe_cast fmt1 as ##java.text.NumberFormat)

        pub def fromNumberFormat(fmt: NumberFormat[r]): DecimalFormat[r] = 
            let NumberFormat(fmt1) = fmt;
            DecimalFormat(unsafe_cast fmt1 as ##java.text.DecimalFormat) 
    }

}


namespace Interop/Text/DecimalFormat {

    use Interop/Text.DecimalFormat;
    use Interop/Text.DecimalFormat.{DecimalFormat};
    use Interop/Text.DecimalFormatSymbols;
    use Interop/Text.DecimalFormatSymbols.{DecimalFormatSymbols};
    use Interop/Math.RoundingMode;
    use Interop/Math.RoundingMode.{RoundingMode};
    use Interop/Util.Currency;
    use Interop/Util.Currency.{Currency};

    pub def getHH(df: DecimalFormat[r]): ##java.text.DecimalFormat = 
        let DecimalFormat(df1) = df;
        df1

    pub def wrapHH(_: Region[r], prim: ##java.text.DecimalFormat): DecimalFormat[r] = 
        DecimalFormat(prim)

    ///
    /// Returns a new mutable DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r]): DecimalFormat[r] \ {IO, Write(r)} =
        import new java.text.DecimalFormat(): ##java.text.DecimalFormat \ {IO, r} as newDecimalFormat;
        DecimalFormat(newDecimalFormat())

    ///
    /// Returns a new mutable DecimalFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def newWithPattern(_: Region[r], patt: String): DecimalFormat[r] \ {IO, Write(r)} =
        import new java.text.DecimalFormat(String): ##java.text.DecimalFormat \ {IO, r} as newDecimalFormat;
        DecimalFormat(newDecimalFormat(patt))

    ///
    /// Returns a new mutable DecimalFormat.
    /// Uses DecimalFormatSymbols so not in IO
    ///
    pub def newWithDecimalFormatSymbols(_: Region[r], patt: String, dfs: DecimalFormatSymbols[r]): DecimalFormat[r] \ Write(r) =
        import new java.text.DecimalFormat(String, ##java.text.DecimalFormatSymbols): ##java.text.DecimalFormat \ r as newDecimalFormat;
        let dfs1 = Interop/Text/DecimalFormatSymbols.getHH(dfs);
        DecimalFormat(newDecimalFormat(patt, dfs1))


    pub def hashCode(df: DecimalFormat[r]): Int32 \ Read(r) =
        import java.text.DecimalFormat.hashCode(): Int32 \ r;
        let DecimalFormat(df1) = df;
        hashCode(df1)


    pub def getCurrency(df: DecimalFormat[r]): Result[String, Currency] \ Write(r) =
        try {
            import java.text.DecimalFormat.getCurrency(): ##java.util.Currency \ r;
            let DecimalFormat(df1) = df;
            getCurrency(df1) |> Currency |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def setCurrency!(cur: Currency, df: DecimalFormat[r]): Result[String, Unit] \ Write(r) =
        try {
            import java.text.DecimalFormat.setCurrency(##java.util.Currency): Unit  \ r;
            let DecimalFormat(df1) = df;
            let Currency(cur1) = cur;
            setCurrency(df1, cur1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def getDecimalFormatSymbols(_: Region[r1], df: DecimalFormat[r]): Result[String, DecimalFormatSymbols[r1]] \ { Read(r), Write(r1) } =
        Interop/Flix/Util.try(_ -> {
            import java.text.DecimalFormat.getDecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ {r, r1};
            let DecimalFormat(df1) = df;
            DecimalFormatSymbols(getDecimalFormatSymbols(df1))
        })

    pub def setDecimalFormatSymbols!(syms: DecimalFormatSymbols[r1], df: DecimalFormat[r]): Result[String, Unit] \ { Read(r1), Write(r) } =
        Interop/Flix/Util.try(_ -> {
            import java.text.DecimalFormat.setDecimalFormatSymbols(##java.text.DecimalFormatSymbols): Unit \ {r, r1} ;
            let DecimalFormat(df1) = df;
            let DecimalFormatSymbols(syms1) = syms;
            setDecimalFormatSymbols(df1, syms1)
        })

    pub def setGroupingSize!(sz: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setGroupingSize(Int32): Unit \ r;
        let DecimalFormat(df1) = df;
        setGroupingSize(df1, sz)

    pub def setMaximumIntegerDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMaximumIntegerDigits(Int32): Unit \ r;
        let DecimalFormat(df1) = df;
        setMaximumIntegerDigits(df1, n)

    pub def setMinimumIntegerDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMinimumIntegerDigits(Int32): Unit \ r;
        let DecimalFormat(df1) = df;
        setMinimumIntegerDigits(df1, n)

    pub def setMaximumFractionDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMaximumFractionDigits(Int32): Unit \ r;
        let DecimalFormat(df1) = df;
        setMaximumFractionDigits(df1, n)


    pub def setMinimumFractionDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMinimumFractionDigits(Int32): Unit \ r;
        let DecimalFormat(df1) = df;
        setMinimumFractionDigits(df1, n)


    pub def setNegativePrefix!(s: String, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setNegativePrefix(String): Unit \ r;
        let DecimalFormat(df1) = df;
        setNegativePrefix(df1, s)

    pub def setNegativeSuffix!(s: String, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setNegativeSuffix(String): Unit \ r;
        let DecimalFormat(df1) = df;
        setNegativeSuffix(df1, s)

    pub def setPositivePrefix!(s: String, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setPositivePrefix(String): Unit \ r;
        let DecimalFormat(df1) = df;
        setPositivePrefix(df1, s)

    pub def setPositiveSuffix!(s: String, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setPositiveSuffix(String): Unit \ r;
        let DecimalFormat(df1) = df;
        setPositiveSuffix(df1, s)

   
    pub def setRoundingMode!(mode: RoundingMode, df: DecimalFormat[r]): Result[String, Unit] \ Write(r) = 
        try {
            import java.text.DecimalFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let DecimalFormat(df1) = df;
            let RoundingMode(mode1) = mode;
            setRoundingMode(df1, mode1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    pub def toPattern(df: DecimalFormat[r]): String \ Read(r) =
        import java.text.DecimalFormat.toPattern(): String \ r;
        let DecimalFormat(df1) = df;
        toPattern(df1)


    ///
    pub def toLocalizedPattern(df: DecimalFormat[r]): String \ Read(r) =
        import java.text.DecimalFormat.toLocalizedPattern(): String \ r;
        let DecimalFormat(df1) = df;
        toLocalizedPattern(df1)

    ///
    pub def applyPattern!(patt: String, df: DecimalFormat[r]): Result[String, Unit] \ Write(r) =
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
    pub def applyLocalizedPattern!(patt: String, df: DecimalFormat[r]): Result[String, Unit] \ Write(r) =
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
