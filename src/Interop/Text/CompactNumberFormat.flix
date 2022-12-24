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
    /// Represents a CompactNumberFormat.
    /// Imperative.
    ///
    /// Note the JDK appears to discourage using this class directly. e.g. use the
    /// abstract base class `NumberFormat` instantiated with the factory method `getCompactNumberInstance`.
    ///
    pub enum CompactNumberFormat[_: Region](##java.text.CompactNumberFormat)
    

    instance SubNumberFormat[CompactNumberFormat] {
        pub def toNumberFormat(o: CompactNumberFormat[r]): NumberFormat[r] = 
            let CompactNumberFormat(o1) = o;
            NumberFormat(unsafe_cast o1 as ##java.text.NumberFormat)

        pub def fromNumberFormat(o: NumberFormat[r]): CompactNumberFormat[r] = 
            let NumberFormat(o1) = o;
            CompactNumberFormat(unsafe_cast o1 as ##java.text.CompactNumberFormat) 
    }

}


namespace Interop/Text/CompactNumberFormat {

    use Interop/Text.CompactNumberFormat
    use Interop/Text.CompactNumberFormat.{CompactNumberFormat}
    use Interop/Math.RoundingMode
    use Interop/Math.RoundingMode.{RoundingMode}

    pub def getHH(fmt: CompactNumberFormat[r]): ##java.text.CompactNumberFormat = 
        let CompactNumberFormat(fmt1) = fmt;
        fmt1

    pub def wrapHH(_: Region[r], x: ##java.text.CompactNumberFormat): CompactNumberFormat[r] = 
        CompactNumberFormat(x)

/*
    ///
    /// Returns a new mutable CompactNumberFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r]): CompactNumberFormat[r] \ {IO, Write(r)} =
        import new java.text.CompactNumberFormat(): ##java.text.CompactNumberFormat \ {IO, r} as newDecimalFormat;
        newDecimalFormat() |> CompactNumberFormat

    ///
    /// Returns a new mutable CompactNumberFormat.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def newWithPattern(_: Region[r], patt: String): CompactNumberFormat[r] \ {IO, Write(r)} =
        import new java.text.CompactNumberFormat(String): ##java.text.CompactNumberFormat \ {IO, r} as newDecimalFormat;
        newDecimalFormat(patt) |> CompactNumberFormat

    ///
    /// Returns a new mutable CompactNumberFormat.
    /// Uses DecimalFormatSymbols so not in IO
    ///
    pub def newWithDecimalFormatSymbols(_: Region[r], patt: String, dfs: DecimalFormatSymbols[r]): CompactNumberFormat[r] \ Write(r) =
        import new java.text.CompactNumberFormat(String, ##java.text.DecimalFormatSymbols): ##java.text.CompactNumberFormat \ r as newDecimalFormat;
        let dfs1 = Interop/Text/DecimalFormatSymbols.getHH(dfs);
        newDecimalFormat(patt, dfs1) |> CompactNumberFormat
*/

    pub def equals(x: CompactNumberFormat[r], y: CompactNumberFormat[r]): Bool =
        import java.text.CompactNumberFormat.equals(##java.lang.Object): Bool \ {};
        let CompactNumberFormat(x1) = x;
        let CompactNumberFormat(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

    pub def hashCode(nf: CompactNumberFormat[r]): Int32 \ Read(r) =
        import java.text.CompactNumberFormat.hashCode(): Int32 \ r;
        let CompactNumberFormat(nf1) = nf;
        hashCode(nf1)


    pub def formatInt64(n: Int64, nf: CompactNumberFormat[r]): Result[String, String] \ Read(r)= 
        Interop/Text/SubNumberFormat.toNumberFormat(nf)
            |> Interop/Text/NumberFormat.formatInt64(n)

    pub def formatFloat64(d: Float64, nf: CompactNumberFormat[r]): Result[String, String] \ Read(r) =  
        Interop/Text/SubNumberFormat.toNumberFormat(nf)
            |> Interop/Text/NumberFormat.formatFloat64(d)





    pub def getGroupingSize(nf: CompactNumberFormat[r]): Int32 \ Read(r) =
        import java.text.CompactNumberFormat.getGroupingSize(): Int32 \ Read(r);
        let CompactNumberFormat(nf1) = nf;
        getGroupingSize(nf1)


    pub def setGroupingSize!(n: Int32, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setGroupingSize(Int32): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setGroupingSize(nf1, n)


    pub def setGroupingUsed!(used: Bool, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setGroupingUsed(Bool): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setGroupingUsed(nf1, used)

    pub def setMaximumFractionDigits!(n: Int32, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setMaximumFractionDigits(Int32): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setMaximumFractionDigits(nf1, n)


    pub def setMaximumIntegerDigits!(n: Int32, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setMaximumIntegerDigits(Int32): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setMaximumIntegerDigits(nf1, n)

    pub def setMinimumFractionDigits!(n: Int32, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setMinimumFractionDigits(Int32): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setMinimumFractionDigits(nf1, n)

    pub def setMinimumIntegerDigits!(n: Int32, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setMinimumIntegerDigits(Int32): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setMinimumIntegerDigits(nf1, n)


    pub def setParseBigDecimal!(value: Bool, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setParseBigDecimal(Bool): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setParseBigDecimal(nf1, value)


    pub def setParseIntegerOnly!(value: Bool, nf: CompactNumberFormat[r]): Unit \ Write(r) =
        import java.text.CompactNumberFormat.setParseIntegerOnly(Bool): Unit \ r;
        let CompactNumberFormat(nf1) = nf;
        setParseIntegerOnly(nf1, value)


    pub def getRoundingMode(nf: CompactNumberFormat[r]): RoundingMode \ Read(r) = 
        import java.text.CompactNumberFormat.getRoundingMode(): ##java.math.RoundingMode \ Read(r);
        let CompactNumberFormat(nf1) = nf;
        getRoundingMode(nf1) |> RoundingMode

    pub def setRoundingMode!(mode: RoundingMode, nf: CompactNumberFormat[r]): Result[Unit, String] \ Write(r) = 
        try {
            import java.text.CompactNumberFormat.setRoundingMode(##java.math.RoundingMode): Unit \ r;
            let CompactNumberFormat(nf1) = nf;
            let RoundingMode(mode1) = mode;
            setRoundingMode(nf1, mode1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }






}
