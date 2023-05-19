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
    
    ///
    /// Represents a DecimalFormatSymbols object.
    /// "Immutable with Setter"
    ///
    pub enum DecimalFormatSymbols(##java.text.DecimalFormatSymbols)
    
    pub enum MutDecimalFormatSymbols[_: Region](##java.text.DecimalFormatSymbols)

    /// DecimalFormatSymbols "builders" in the JDK return void...
    pub type alias DecimalFormatSymbolsInit[r: Region] = MutDecimalFormatSymbols[r] -> Result[String, Unit] \ r

}


mod Interop.Text.DecimalFormatSymbols {

    use Interop.Text.DecimalFormatSymbols
    use Interop.Text.DecimalFormatSymbols.{DecimalFormatSymbols}
    use Interop.Text.MutDecimalFormatSymbols
    use Interop.Text.MutDecimalFormatSymbols.{MutDecimalFormatSymbols}
    use Interop.Text.DecimalFormatSymbolsInit

    use Interop.Util.Currency
    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}

    pub def getHH(dfs: DecimalFormatSymbols): ##java.text.DecimalFormatSymbols = 
        let DecimalFormatSymbols(dfs1) = dfs;
        dfs1

    pub def wrapHH(prim: ##java.text.DecimalFormatSymbols): DecimalFormatSymbols = 
        DecimalFormatSymbols(prim)


    ///
    /// Returns a new DecimalFormatSymbols object.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r], init: DecimalFormatSymbolsInit[r]): Result[String, DecimalFormatSymbols] \ IO =
        import new java.text.DecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ IO as new1;
        let dfs1 = new1();
        MutDecimalFormatSymbols(dfs1) |> init |> Result.map(_ -> DecimalFormatSymbols(dfs1))

    ///
    /// Returns a new DecimalFormatSymbols object derived from the locale.
    ///
    pub def newWithLocale(_: Region[r], loc: Locale, init: DecimalFormatSymbolsInit[r]): Result[String, DecimalFormatSymbols] \ r =
        import new java.text.DecimalFormatSymbols(##java.util.Locale): ##java.text.DecimalFormatSymbols \ {} as new1;
        let Locale(loc1) = loc;
        let dfs1 = new1(loc1);
        MutDecimalFormatSymbols(dfs1) |> init |> Result.map(_ -> DecimalFormatSymbols(dfs1))


    pub def equals(x: DecimalFormatSymbols, y: DecimalFormatSymbols): Bool =
        import java.text.DecimalFormatSymbols.equals(##java.lang.Object): Bool \ {};
        let DecimalFormatSymbols(x1) = x;
        let DecimalFormatSymbols(y1) = y;
        equals(x1, checked_cast(y1))

    pub def hashCode(dfs: DecimalFormatSymbols): Int32 =
        import java.text.DecimalFormatSymbols.hashCode(): Int32 \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        hashCode(dfs1)


    /// This marshals okay...
    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        import static java.text.DecimalFormatSymbols.getAvailableLocales(): Array[##java.util.Locale, rc] \ {IO, rc} ;
        let _ = Array#{} @ rc;
        let xs = getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }


    pub def getInstance(_: Region[r], init: DecimalFormatSymbolsInit[r]): Result[String, DecimalFormatSymbols] \ {IO, r} = 
        import static java.text.DecimalFormatSymbols.getInstance(): ##java.text.DecimalFormatSymbols \ IO;
        let dfs1 = getInstance();
        MutDecimalFormatSymbols(dfs1) |> init |> Result.map(_ -> DecimalFormatSymbols(dfs1))

    pub def getInstanceWithLocale(_: Region[r], loc: Locale, init: DecimalFormatSymbolsInit[r]): Result[String, DecimalFormatSymbols] \ {IO, r} = 
        import static java.text.DecimalFormatSymbols.getInstance(##java.util.Locale): ##java.text.DecimalFormatSymbols \ {IO, r};
        let Locale(loc1) = loc;
        let dfs1 = getInstance(loc1);
        MutDecimalFormatSymbols(dfs1) |> init |> Result.map(_ -> DecimalFormatSymbols(dfs1))


    pub def getCurrency(dfs: DecimalFormatSymbols): Option[Currency] =
        import java.text.DecimalFormatSymbols.getCurrency(): ##java.util.Currency \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getCurrency(dfs1) |> Object.toOption |> Option.map(Interop.Util.Currency.wrapHH)

    pub def getCurrencySymbol(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getCurrencySymbol(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getCurrencySymbol(dfs1)

    pub def getDecimalSeparator(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getDecimalSeparator(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getDecimalSeparator(dfs1)


    pub def getDigit(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getDigit(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getDigit(dfs1)

    pub def getExponentSeparator(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getExponentSeparator(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getExponentSeparator(dfs1)

    // Java 15

    // pub def getGroupingSeparator(dfs: DecimalFormatSymbols): Char = 
    //     import java.text.DecimalFormatSymbols.getGroupingSeparator(): Char \ {};
    //     let DecimalFormatSymbols(dfs1) = dfs;
    //     getGroupingSeparator(dfs1)

    pub def getInfinity(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getInfinity(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getInfinity(dfs1)


    pub def getInternationalCurrencySymbol(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getInternationalCurrencySymbol(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getInternationalCurrencySymbol(dfs1)

    pub def getMinusSign(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getMinusSign(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getMinusSign(dfs1)

    pub def getMonetaryDecimalSeparator(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getMonetaryDecimalSeparator(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getMonetaryDecimalSeparator(dfs1)   

    // Java 15
    // pub def getMonetaryGroupingSeparator(dfs: DecimalFormatSymbols): Char = 
    //     import java.text.DecimalFormatSymbols.getMonetaryGroupingSeparator(): Char \ {};
    //     let DecimalFormatSymbols(dfs1) = dfs;
    //     getMonetaryGroupingSeparator(dfs1)

    pub def getNaN(dfs: DecimalFormatSymbols): String = 
        import java.text.DecimalFormatSymbols.getNaN(): String \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getNaN(dfs1)

    pub def getPatternSeparator(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getPatternSeparator(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getPatternSeparator(dfs1)

    pub def getPercent(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getPercent(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getPercent(dfs1)

    pub def getPerMill(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getPerMill(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getPerMill(dfs1)


    pub def getZeroDigit(dfs: DecimalFormatSymbols): Char = 
        import java.text.DecimalFormatSymbols.getZeroDigit(): Char \ {};
        let DecimalFormatSymbols(dfs1) = dfs;
        getZeroDigit(dfs1)        


    /// Setters

        
    pub def setCurrency!(cur: Currency, dfs: MutDecimalFormatSymbols[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormatSymbols.setCurrency(##java.util.Currency): Unit \ r;
            let MutDecimalFormatSymbols(dfs1) = dfs;
            let cur1 = Interop.Util.Currency.getHH(cur);
            setCurrency(dfs1, cur1)
        })

    pub def setCurrencySymbol!(s: String, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setCurrencySymbol(String): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setCurrencySymbol(dfs1, s)


    pub def setDecimalSeparator!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setDecimalSeparator(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setDecimalSeparator(dfs1, c)

    pub def setDigit!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setDigit(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setDigit(dfs1, c)


    pub def setExponentSeparator!(s: String, dfs: MutDecimalFormatSymbols[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.text.DecimalFormatSymbols.setExponentSeparator(String): Unit \ r;
            let MutDecimalFormatSymbols(dfs1) = dfs;
            setExponentSeparator(dfs1, s)
        })

    pub def setInfinity!(s: String, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setInfinity(String): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setInfinity(dfs1, s)


    pub def setInternationalCurrencySymbol!(s: String, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setInternationalCurrencySymbol(String): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setInternationalCurrencySymbol(dfs1, s)

    pub def setMinusSign!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setMinusSign(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setMinusSign(dfs1, c)

    pub def setMonetaryDecimalSeparator!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setMonetaryDecimalSeparator(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setMonetaryDecimalSeparator(dfs1, c)


    pub def setNaN!(s: String, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setNaN(String): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setNaN(dfs1, s)


    pub def setPatternSeparator!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setPatternSeparator(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setPatternSeparator(dfs1, c)


    pub def setPercent!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setPercent(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setPercent(dfs1, c)


    pub def setPerMill!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setPerMill(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setPerMill(dfs1, c)


    pub def setZeroDigit!(c: Char, dfs: MutDecimalFormatSymbols[r]): Unit \ r =
        import java.text.DecimalFormatSymbols.setZeroDigit(Char): Unit \ r;
        let MutDecimalFormatSymbols(dfs1) = dfs;
        setZeroDigit(dfs1, c)

}
