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

mod Interop.Util {

    use Interop.Util.Currency
    use Interop.Util.Currency.{Currency}
    
    ///
    /// Represents a Java Currency.
    /// Immutable 
    pub enum Currency(##java.util.Currency)


    instance ToString[Currency] {
        pub def toString(x: Currency): String = 
            Interop.Util.Currency.toString(x)
    }

    instance Interop.Flix.GoesToJava[Currency] {
        pub def toJavaObject(x: Currency): ##java.lang.Object =
            let Currency(x1) = x;
            checked_cast(x1)
    }

}


mod Interop.Util.Currency {
    
    use Interop.Util.Currency
    use Interop.Util.Currency.{Currency}
    use Locale.{Locale}
    use Interop.Util.SetZ

    pub def getHH(c: Currency): ##java.util.Currency = 
        let Currency(c1) = c;
        c1

    pub def wrapHH(prim: ##java.util.Currency): Currency = 
        Currency(prim)


    /// equals and hashCode not overriden from Object...

    pub def toString(x: Currency): String =
        import java.util.Currency.toString(): String \ {};
        let Currency(x1) = x;
        toString(x1)


    pub def getAvailableCurrencies(r: Region[r]): SetZ[Currency, r] \ IO =
        import static java.util.Currency.getAvailableCurrencies(): ##java.util.Set \ IO ;
        getAvailableCurrencies() |> Interop.Util.SetZ.wrapHH(r)
        


    pub def getCurrencyCode(cur: Currency): String = 
        import java.util.Currency.getCurrencyCode(): String \ {};
        let Currency(cur1) = cur;
        getCurrencyCode(cur1)

    pub def getNumericCode(cur: Currency): Int32 = 
        import java.util.Currency.getNumericCode(): Int32 \ {};
        let Currency(cur1) = cur;
        getNumericCode(cur1)

    pub def getDisplayName(cur: Currency): String = 
        import java.util.Currency.getDisplayName(): String \ {};
        let Currency(cur1) = cur;
        getDisplayName(cur1)

    pub def getSymbol(cur: Currency): String = 
        import java.util.Currency.getSymbol(): String \ {};
        let Currency(cur1) = cur;
        getSymbol(cur1)

    pub def getSymbolWithLocale(loc: Locale, cur: Currency): String = 
        import java.util.Currency.getSymbol(##java.util.Locale): String \ {};
        let Currency(cur1) = cur;
        let Locale(loc1) = loc;
        getSymbol(cur1, loc1)


    pub def getInstance(code: String): Result[String, Currency] \ IO = 
        Result.tryCatch(_ -> {
            import static java.util.Currency.getInstance(String): ##java.util.Currency \ IO;
            getInstance(code) |> Currency
        })

    /// In IO because we get an "instance"...
    pub def getInstanceWithLocale(loc: Locale): Result[String, Currency] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Currency.getInstance(##java.util.Locale): ##java.util.Currency \ IO;
            let Locale(loc1) = loc;
            getInstance(loc1) |> Currency
        })


}
