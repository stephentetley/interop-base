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
    
    /// Abstract Class
    /// Represents a NumberFormat.
    /// Mutable
    pub enum NumberFormat[_: Region](##java.text.NumberFormat)
    
    instance Scoped[NumberFormat] {
        pub def regionOf(_: NumberFormat[r]): Region[r] = unsafe_cast () as Region[r]
    }

    pub class SubNumberFormat[t: Region -> Type] {
        pub def toNumberFormat[r: Region](s: t[r]): NumberFormat[r]
        pub def fromNumberFormat[r: Region](s: NumberFormat[r]): t[r]
    }

}


namespace Interop/IO/SubNumberFormat {
    
    use Interop/Text.SubNumberFormat;

    pub def getHH[r: Region, format: Region -> Type](nf: format[r]): ##java.text.NumberFormat with SubNumberFormat[format] = 
        Interop/Text/SubNumberFormat.toNumberFormat(nf) |> Interop/Text/NumberFormat.getHH

}

namespace Interop/Text/NumberFormat {

    use Interop/Text.NumberFormat;
    use Interop/Text.NumberFormat.{NumberFormat};
    use Interop/Text.SubNumberFormat;

    use Interop/Lang.Number;
    use Interop/Lang.Number.{Number};
    use Interop/Math.RoundingMode;
    use Interop/Math.RoundingMode.{RoundingMode};
    use Interop/Util.Currency;
    use Interop/Util.Currency.{Currency};
    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    pub def getHH(x: NumberFormat[r]): ##java.text.NumberFormat = 
        let NumberFormat(x1) = x;
        x1

    pub def wrapHH(_: Region[r], x: ##java.text.NumberFormat): NumberFormat[r] = 
        NumberFormat(x)


    // No constructor as we will not be creating subclasses

    pub def equals(x: NumberFormat[r], y: NumberFormat[r]): Bool =
        import java.text.NumberFormat.equals(##java.lang.Object): Bool \ {};
        let NumberFormat(x1) = x;
        let NumberFormat(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)


    pub def hashCode(nf: NumberFormat[r]): Int32 =
        import java.text.NumberFormat.hashCode(): Int32 \ {};
        let NumberFormat(nf1) = nf;
        hashCode(nf1)


    // pub def clone(nf: NumberFormat[r]): Int32 =
    //     import java.text.NumberFormat.clone(): ##java.lang.Object \ {};
    //     let NumberFormat(nf1) = nf;
    //     (clone(nf1) as ##java.text.NumberFormat) |> NumberFormat


    pub def getInstance(_: Region[r]): NumberFormat[r] \ {IO, Write(r)} = 
        import static java.text.NumberFormat.getInstance(): ##java.text.NumberFormat \ {IO, r};
        getInstance() |> NumberFormat

    pub def parse[r: Region, format: Region -> Type](s: String, nf: format[r]): Result[Number, String] \ Read(r) with SubNumberFormat[format] = 
        try {
            import java.text.NumberFormat.parse(String): ##java.lang.Number \ r;
            let nf1 = Interop/IO/SubNumberFormat.getHH(nf);
            Number(parse(nf1, s)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def formatInt64[r: Region, format: Region -> Type]
                        (n: Int64, nf: format[r]): Result[String, String] \ Read(r) with SubNumberFormat[format] = 
        try {
            import java.text.NumberFormat.format(Int64): String \ r;
            let nf1 = Interop/IO/SubNumberFormat.getHH(nf);
            format(nf1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def formatFloat64[r: Region, format: Region -> Type]
                        (d: Float64, nf: format[r]): Result[String, String] \ Read(r) with SubNumberFormat[format] =  
        try {
            import java.text.NumberFormat.format(Float64): String \ r;
            let nf1 = Interop/IO/SubNumberFormat.getHH(nf);
            format(nf1, d) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def getAvailableLocales(): List[Locale] \ IO = region r {
        import static java.text.NumberFormat.getAvailableLocales(): Array[##java.util.Locale, r] \ { Write(r), IO } ;
        let _ = [] @ r;
        getAvailableLocales() |> Array.toList |> List.map(Locale)
    }
   
    pub def getCurrency[r: Region, format: Region -> Type](nf: format[r]): Result[Currency, String] \ Write(r) with SubNumberFormat[format] = 
        try {
            import java.text.NumberFormat.getCurrency(): ##java.util.Currency \ r;
            let nf1 = Interop/IO/SubNumberFormat.getHH(nf);
            getCurrency(nf1) |> Currency |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
   
    pub def setCurrency!(c: Currency, nf: NumberFormat[r]): Result[Unit, String] \ Write(r) = 
        try {
            import java.text.NumberFormat.setCurrency(##java.util.Currency): Unit \ r;
            let NumberFormat(nf1) = nf;
            let Currency(c1) = c;
            setCurrency(nf1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def isGroupingUsed(nf: NumberFormat[r]): Bool \ Read(r) = 
        import java.text.NumberFormat.isGroupingUsed(): Bool \ r;
        let NumberFormat(nf1) = nf;
        isGroupingUsed(nf1)

    pub def setGroupingUsed!(used: Bool, nf: NumberFormat[r]): Unit \ Write(r) = 
        import java.text.NumberFormat.setGroupingUsed(Bool): Unit \ r;
        let NumberFormat(nf1) = nf;
        setGroupingUsed(nf1, used)


    pub def getMaximumIntegerDigits(nf: NumberFormat[r]): Int32 \ Read(r) = 
        import java.text.NumberFormat.getMaximumIntegerDigits(): Int32 \ r;
        let NumberFormat(nf1) = nf;
        getMaximumIntegerDigits(nf1)

    pub def setMaximumIntegerDigits!(n: Int32, nf: NumberFormat[r]): Unit \ Write(r) = 
        import java.text.NumberFormat.setMaximumIntegerDigits(Int32): Unit \ r;
        let NumberFormat(nf1) = nf;
        setMaximumIntegerDigits(nf1, n)

    pub def getMinimumIntegerDigits(nf: NumberFormat[r]): Int32 \ Read(r) = 
        import java.text.NumberFormat.getMinimumIntegerDigits(): Int32 \ r;
        let NumberFormat(nf1) = nf;
        getMinimumIntegerDigits(nf1)

    pub def setMinimumIntegerDigits!(n: Int32, nf: NumberFormat[r]): Unit \ Write(r) = 
        import java.text.NumberFormat.setMinimumIntegerDigits(Int32): Unit \ r;
        let NumberFormat(nf1) = nf;
        setMinimumIntegerDigits(nf1, n)


    pub def getMaximumFractionDigits(nf: NumberFormat[r]): Int32 \ Read(r) = 
        import java.text.NumberFormat.getMaximumFractionDigits(): Int32 \ r;
        let NumberFormat(nf1) = nf;
        getMaximumFractionDigits(nf1)

    pub def setMaximumFractionDigits!(n: Int32, nf: NumberFormat[r]): Unit \ Write(r) = 
        import java.text.NumberFormat.setMaximumFractionDigits(Int32): Unit \ r;
        let NumberFormat(nf1) = nf;
        setMaximumFractionDigits(nf1, n)

    pub def getMinimumFractionDigits(nf: NumberFormat[r]): Int32 \ Read(r) = 
        import java.text.NumberFormat.getMinimumFractionDigits(): Int32 \ r;
        let NumberFormat(nf1) = nf;
        getMinimumFractionDigits(nf1)

    pub def setMinimumFractionDigits!(n: Int32, nf: NumberFormat[r]): Unit \ Write(r) = 
        import java.text.NumberFormat.setMinimumFractionDigits(Int32): Unit \ r;
        let NumberFormat(nf1) = nf;
        setMinimumFractionDigits(nf1, n)


    pub def getRoundingMode(nf: NumberFormat[r]): RoundingMode \ Read(r) = 
        import java.text.NumberFormat.getRoundingMode(): ##java.math.RoundingMode \ r;
        let NumberFormat(nf1) = nf;
        getRoundingMode(nf1) |> RoundingMode 
   
    pub def setRoundingMode!(mode: RoundingMode, nf: NumberFormat[r]): Result[Unit, String] \ Write(r) = 
        try {
            import java.text.NumberFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let NumberFormat(nf1) = nf;
            let RoundingMode(mode1) = mode;
            setRoundingMode(nf1, mode1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
