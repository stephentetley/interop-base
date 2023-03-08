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

namespace Interop/Text {
    
    ///
    /// Represents a DecimalFormatSymbols object.
    /// "Immutable with Setter"
    ///
    pub enum DecimalFormatSymbols(##java.text.DecimalFormatSymbols)
    

}


namespace Interop/Text/DecimalFormatSymbols {

    use Interop/Text.DecimalFormatSymbols
    use Interop/Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    use Interop/Util.Currency
    use Interop/Util.Locale
    use Interop/Util.Locale.{Locale}
    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def getHH(dfs: DecimalFormatSymbols): ##java.text.DecimalFormatSymbols = 
        let DecimalFormatSymbols(dfs1) = dfs;
        dfs1

    pub def wrapHH(prim: ##java.text.DecimalFormatSymbols): DecimalFormatSymbols = 
        DecimalFormatSymbols(prim)


    pub enum DecimalFormatSymbolsProperty {
        case CurrencyP(Currency)
        case CurrencySymbol(String)
        case DecimalSeparator(Char)
        case Digit(Char)
        case ExponentSeparator(String)
        case Infinity(String)
        case MinusSign(Char)
        case MonetaryDecimalSeparator(Char)
        case NaN(String)
        case PatternSeparator(Char)
        case Percent(Char)
        case PerMill(Char)
        case ZeroDigit(Char)
    }
    

    pub def makeSetter(rc: Region[r], xs: List[DecimalFormatSymbolsProperty]): Setter[DecimalFormatSymbols, r] = 
        def f(x) = match x {
            case CurrencyP(x1)                  => setCurrency!(rc, x1)
            case CurrencySymbol(x1)             => setCurrencySymbol!(rc, x1)
            case DecimalSeparator(x1)           => setDecimalSeparator!(rc, x1)
            case Digit(x1)                      => setDigit!(rc, x1)
            case ExponentSeparator(x1)          => setExponentSeparator!(rc, x1)
            case Infinity(x1)                   => setInfinity!(rc, x1)
            case MinusSign(x1)                  => setMinusSign!(rc, x1)
            case MonetaryDecimalSeparator(x1)   => setMonetaryDecimalSeparator!(rc, x1)
            case NaN(x1)                        => setNaN!(rc, x1)
            case PatternSeparator(x1)           => setPatternSeparator!(rc, x1)
            case Percent(x1)                    => setPercent!(rc, x1)
            case PerMill(x1)                    => setPerMill!(rc, x1)
            case ZeroDigit(x1)                  => setZeroDigit!(rc, x1)
        };
        Interop/Flix/Setter.makeSetter(rc, f, xs)


    ///
    /// Returns a new DecimalFormatSymbols object.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(props: List[DecimalFormatSymbolsProperty]): Result[String, DecimalFormatSymbols] \ IO = region rc {
        import new java.text.DecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ IO as new1;
        DecimalFormatSymbols(new1()) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    ///
    /// Returns a new DecimalFormatSymbols object derived from the locale.
    ///
    pub def newWithLocale(loc: Locale, props: List[DecimalFormatSymbolsProperty]): Result[String, DecimalFormatSymbols] = region rc {
        import new java.text.DecimalFormatSymbols(##java.util.Locale): ##java.text.DecimalFormatSymbols \ {} as new1;
        let Locale(loc1) = loc;
        DecimalFormatSymbols(new1(loc1)) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    pub def equals(x: DecimalFormatSymbols, y: DecimalFormatSymbols): Bool =
        import java.text.DecimalFormatSymbols.equals(##java.lang.Object): Bool \ {};
        let DecimalFormatSymbols(x1) = x;
        let DecimalFormatSymbols(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def hashCode(dfs: DecimalFormatSymbols): Int32 =
        import java.text.DecimalFormatSymbols.hashCode(): Int32 \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        hashCode(dfs1)


    /// This marshals okay...
    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        import static java.text.DecimalFormatSymbols.getAvailableLocales(): Array[##java.util.Locale, rc] \ { Write(rc), IO } ;
        let _ = Array#{} @ rc;
        let xs = getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }


    pub def getInstance(rc: Region[r], fs: Setter[DecimalFormatSymbols, r]): Result[String, DecimalFormatSymbols] \ {IO, Write(r)} = 
        import static java.text.DecimalFormatSymbols.getInstance(): ##java.text.DecimalFormatSymbols \ IO;
        DecimalFormatSymbols(getInstance()) |> Interop/Flix/Setter.apply(rc, fs)


    pub def getInstanceWithLocale(rc: Region[r], loc: Locale, fs: Setter[DecimalFormatSymbols, r]): Result[String, DecimalFormatSymbols] \ {IO, Write(r)} = 
        import static java.text.DecimalFormatSymbols.getInstance(##java.util.Locale): ##java.text.DecimalFormatSymbols \ {IO, r};
        let Locale(loc1) = loc;
        DecimalFormatSymbols(getInstance(loc1))  |> Interop/Flix/Setter.apply(rc, fs)


    pub def getCurrency(dfs: DecimalFormatSymbols): Option[Currency] =
        import java.text.DecimalFormatSymbols.getCurrency(): ##java.util.Currency \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getCurrency(dfs1) |> Object.toOption |> Option.map(Interop/Util/Currency.wrapHH)
        
    pub def setCurrency!(_: Region[r], cur: Currency): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setCurrency(##java.util.Currency): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            let cur1 = Interop/Util/Currency.getHH(cur);
            setCurrency(dfs1, cur1)
        )

    pub def getCurrencySymbol(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getCurrencySymbol(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getCurrencySymbol(dfs1)

    pub def setCurrencySymbol!(_: Region[r], s: String): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setCurrencySymbol(String): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setCurrencySymbol(dfs1, s)
        )

    pub def getDecimalSeparator(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getDecimalSeparator(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getDecimalSeparator(dfs1)

    pub def setDecimalSeparator!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setDecimalSeparator(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setDecimalSeparator(dfs1, c)
        )


    pub def getDigit(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getDigit(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getDigit(dfs1)

    pub def setDigit!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setDigit(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setDigit(dfs1, c)
        )

    pub def getExponentSeparator(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getExponentSeparator(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getExponentSeparator(dfs1)

    pub def setExponentSeparator!(_: Region[r], s: String): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setExponentSeparator(String): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setExponentSeparator(dfs1, s)
        )

    // Java 15

    // pub def getGroupingSeparator(dfs: DecimalFormatSymbols): Char = 
    //     import java.text.DecimalFormatSymbols.getGroupingSeparator(): Char \ {};
    //     let DecimalFormatSymbols(dfs1) = dfs;
    //     getGroupingSeparator(dfs1)

    pub def getInfinity(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getInfinity(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getInfinity(dfs1)

    pub def setInfinity!(_: Region[r], s: String): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setInfinity(String): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setInfinity(dfs1, s)
        )


    pub def getInternationalCurrencySymbol(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getInternationalCurrencySymbol(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getInternationalCurrencySymbol(dfs1)

    pub def setInternationalCurrencySymbol!(_: Region[r], s: String): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setInternationalCurrencySymbol(String): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setInternationalCurrencySymbol(dfs1, s)
        )

    pub def getMinusSign(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getMinusSign(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getMinusSign(dfs1)

    pub def setMinusSign!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setMinusSign(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setMinusSign(dfs1, c)
        )

    pub def getMonetaryDecimalSeparator(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getMonetaryDecimalSeparator(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getMonetaryDecimalSeparator(dfs1)   

    pub def setMonetaryDecimalSeparator!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setMonetaryDecimalSeparator(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setMonetaryDecimalSeparator(dfs1, c)
        )

    // Java 15
    // pub def getMonetaryGroupingSeparator(dfs: DecimalFormatSymbols): Char = 
    //     import java.text.DecimalFormatSymbols.getMonetaryGroupingSeparator(): Char \ {};
    //     let DecimalFormatSymbols(dfs1) = dfs;
    //     getMonetaryGroupingSeparator(dfs1)

    pub def getNaN(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getNaN(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getNaN(dfs1)

    pub def setNaN!(_: Region[r], s: String): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setNaN(String): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setNaN(dfs1, s)
        )

    pub def getPatternSeparator(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getPatternSeparator(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getPatternSeparator(dfs1)

    pub def setPatternSeparator!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setPatternSeparator(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setPatternSeparator(dfs1, c)
        )

    pub def getPercent(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getPercent(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getPercent(dfs1)

    pub def setPercent!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setPercent(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setPercent(dfs1, c)
        )

    pub def getPerMill(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getPerMill(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getPerMill(dfs1)

    pub def setPerMill!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setPerMill(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setPerMill(dfs1, c)
        )

    pub def getZeroDigit(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getZeroDigit(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getZeroDigit(dfs1)        

    pub def setZeroDigit!(_: Region[r], c: Char): Setter[DecimalFormatSymbols, r] =
        Interop/Flix/Setter.lift(dfs ->
            import java.text.DecimalFormatSymbols.setZeroDigit(Char): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            setZeroDigit(dfs1, c)
        )
}
