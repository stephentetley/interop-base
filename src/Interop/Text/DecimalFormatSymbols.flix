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
    /// Represents a DecimalFormatSymbols.
    /// Mutable, no alloc.
    ///
    pub enum DecimalFormatSymbols[_: Region](##java.text.DecimalFormatSymbols)
    

}


namespace Interop/Text/DecimalFormatSymbols {

    use Interop/Text.DecimalFormatSymbols;
    use Interop/Text.DecimalFormatSymbols.{DecimalFormatSymbols};
    use Interop/Util.Currency;
    use Interop/Util.Currency.{Currency};
    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    pub def getHH(dfs: DecimalFormatSymbols[r]): ##java.text.DecimalFormatSymbols = 
        let DecimalFormatSymbols(dfs1) = dfs;
        dfs1

    pub def wrapHH(_: Region[r], prim: ##java.text.DecimalFormatSymbols): DecimalFormatSymbols[r] = 
        DecimalFormatSymbols(prim)

    ///
    /// Returns a new mutable DecimalFormatSymbols object.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r]): DecimalFormatSymbols[r] \ {IO, Write(r)} =
        import new java.text.DecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ {IO, r} as newDecimalFormatSymbols;
        DecimalFormatSymbols(newDecimalFormatSymbols())

    ///
    /// Returns a new mutable DecimalFormatSymbols object derived from the locale.
    ///
    pub def newWithLocale(_: Region[r], loc: Locale): DecimalFormatSymbols[r] \ Write(r) =
        import new java.text.DecimalFormatSymbols(##java.util.Locale): ##java.text.DecimalFormatSymbols \ r as newDecimalFormatSymbols;
        let Locale(loc1) = loc;
        DecimalFormatSymbols(newDecimalFormatSymbols(loc1))


    pub def equals(x: DecimalFormatSymbols[r], y: DecimalFormatSymbols[r]): Bool \ Read(r) =
        import java.text.DecimalFormatSymbols.equals(##java.lang.Object): Bool \ r;
        let DecimalFormatSymbols(x1) = x;
        let DecimalFormatSymbols(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def hashCode(dfs: DecimalFormatSymbols[r]): Int32 \ Read(r) =
        import java.text.DecimalFormatSymbols.hashCode(): Int32 \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        hashCode(dfs1)


    /// This marshals okay...
    pub def getAvailableLocales(): List[Locale] \ IO = region r {
        import static java.text.DecimalFormatSymbols.getAvailableLocales(): Array[##java.util.Locale, r] \ { Write(r), IO } ;
        let _ = Array#{} @ r;
        let xs = getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }


    pub def getInstance(_: Region[r]): DecimalFormatSymbols[r] \ {IO, Write(r)} = 
        import static java.text.DecimalFormatSymbols.getInstance(): ##java.text.DecimalFormatSymbols \ {IO, r};
        DecimalFormatSymbols(getInstance())


    pub def getInstanceWithLocale(_: Region[r], loc: Locale): Result[String, DecimalFormatSymbols[r]] \ {IO, Write(r)} = 
        Interop/Flix/Util.try(_ -> {
            import static java.text.DecimalFormatSymbols.getInstance(##java.util.Locale): ##java.text.DecimalFormatSymbols \ {IO, r};
            let Locale(loc1) = loc;
            DecimalFormatSymbols(getInstance(loc1))
        })

    pub def getCurrency(dfs: DecimalFormatSymbols[r]): Option[Currency] \ Read(r) =
        import java.text.DecimalFormatSymbols.getCurrency(): ##java.util.Currency \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getCurrency(dfs1) |> Object.toOption |> Option.map(Currency)
        
    pub def setCurrency!(cur: Currency, dfs: DecimalFormatSymbols[r]): Result[String, Unit] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.text.DecimalFormatSymbols.setCurrency(##java.util.Currency): Unit \ r;
            let DecimalFormatSymbols(dfs1) = dfs;
            let Currency(cur1) = cur;
            setCurrency(dfs1, cur1)
        })

    pub def getCurrencySymbol(dfs: DecimalFormatSymbols[r]): String \ Read(r) = 
        import java.text.DecimalFormatSymbols.getCurrencySymbol(): String \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getCurrencySymbol(dfs1)

    pub def setCurrencySymbol!(s: String, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setCurrencySymbol(String): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setCurrencySymbol(dfs1, s)


    pub def getDecimalSeparator(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getDecimalSeparator(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getDecimalSeparator(dfs1)

    pub def setDecimalSeparator!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setDecimalSeparator(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setDecimalSeparator(dfs1, c)


    pub def getDigit(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getDigit(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getDigit(dfs1)

    pub def setDigit!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setDigit(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setDigit(dfs1, c)

    pub def getExponentSeparator(dfs: DecimalFormatSymbols[r]): String \ Read(r) = 
        import java.text.DecimalFormatSymbols.getExponentSeparator(): String \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getExponentSeparator(dfs1)

    pub def setExponentSeparator!(s: String, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setExponentSeparator(String): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setExponentSeparator(dfs1, s)

    // Java 15

    // pub def getGroupingSeparator(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
    //     import java.text.DecimalFormatSymbols.getGroupingSeparator(): Char \ r;
    //     let DecimalFormatSymbols(dfs1) = dfs;
    //     getGroupingSeparator(dfs1)

    pub def getInfinity(dfs: DecimalFormatSymbols[r]): String \ Read(r) = 
        import java.text.DecimalFormatSymbols.getInfinity(): String \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getInfinity(dfs1)

    pub def setInfinity!(s: String, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setInfinity(String): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setInfinity(dfs1, s)


    pub def getInternationalCurrencySymbol(dfs: DecimalFormatSymbols[r]): String \ Read(r) = 
        import java.text.DecimalFormatSymbols.getInternationalCurrencySymbol(): String \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getInternationalCurrencySymbol(dfs1)

    pub def setInternationalCurrencySymbol!(s: String, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setInternationalCurrencySymbol(String): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setInternationalCurrencySymbol(dfs1, s)


    pub def getMinusSign(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getMinusSign(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getMinusSign(dfs1)

    pub def setMinusSign!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setMinusSign(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setMinusSign(dfs1, c)


    pub def getMonetaryDecimalSeparator(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getMonetaryDecimalSeparator(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getMonetaryDecimalSeparator(dfs1)   

    pub def setMonetaryDecimalSeparator!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setMonetaryDecimalSeparator(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setMonetaryDecimalSeparator(dfs1, c)

    // Java 15
    // pub def getMonetaryGroupingSeparator(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
    //     import java.text.DecimalFormatSymbols.getMonetaryGroupingSeparator(): Char \ r;
    //     let DecimalFormatSymbols(dfs1) = dfs;
    //     getMonetaryGroupingSeparator(dfs1)

    pub def getNaN(dfs: DecimalFormatSymbols[r]): String \ Read(r) = 
        import java.text.DecimalFormatSymbols.getNaN(): String \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getNaN(dfs1)

    pub def setNaN!(s: String, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setNaN(String): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setNaN(dfs1, s)


    pub def getPatternSeparator(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getPatternSeparator(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getPatternSeparator(dfs1)

    pub def setPatternSeparator!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setPatternSeparator(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setPatternSeparator(dfs1, c)


    pub def getPercent(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getPercent(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getPercent(dfs1)

    pub def setPercent!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setPercent(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setPercent(dfs1, c)

    pub def getPerMill(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getPerMill(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getPerMill(dfs1)

    pub def setPerMill!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setPerMill(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setPerMill(dfs1, c)

    pub def getZeroDigit(dfs: DecimalFormatSymbols[r]): Char \ Read(r) = 
        import java.text.DecimalFormatSymbols.getZeroDigit(): Char \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        getZeroDigit(dfs1)        

    pub def setZeroDigit!(c: Char, dfs: DecimalFormatSymbols[r]): Unit \ Write(r) =
        import java.text.DecimalFormatSymbols.setZeroDigit(Char): Unit \ r;
        let DecimalFormatSymbols(dfs1) = dfs;
        setZeroDigit(dfs1, c)

}
