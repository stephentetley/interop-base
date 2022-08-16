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
    /// Imperative.
    ///
    pub enum DecimalFormat[_: Region](##java.text.DecimalFormat)

    instance SubNumberFormat[DecimalFormat] {
        pub def toNumberFormat(o: DecimalFormat[r]): NumberFormat[r] = 
            let DecimalFormat(o1) = o;
            NumberFormat(o1 as ##java.text.NumberFormat)

        pub def fromNumberFormat(o: NumberFormat[r]): DecimalFormat[r] = 
            let NumberFormat(o1) = o;
            DecimalFormat(o1 as ##java.text.DecimalFormat) 
    }

}


namespace Interop/Text/DecimalFormat {

    use Interop/Text.DecimalFormat;
    use Interop/Text.DecimalFormat.{DecimalFormat};

    pub def getHH(df: DecimalFormat[r]): ##java.text.DecimalFormat = 
        let DecimalFormat(df1) = df;
        df1

    ///
    /// Returns a new mutable DecimalFormat.
    ///
    pub def new(_: Region[r]): DecimalFormat[r] \ Write(r) =
        import new java.text.DecimalFormat(): ##java.text.DecimalFormat & r as newDecimalFormat;
        newDecimalFormat() |> DecimalFormat

    ///
    /// Returns a new mutable DecimalFormat.
    ///
    pub def newWithPattern(_: Region[r], patt: String): DecimalFormat[r] \ Write(r) =
        import new java.text.DecimalFormat(String): ##java.text.DecimalFormat & r as newDecimalFormat;
        newDecimalFormat(patt) |> DecimalFormat


    pub def setGroupingSize!(sz: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setGroupingSize(Int32): Unit & r;
        let DecimalFormat(df1) = df;
        setGroupingSize(df1, sz)

    pub def setMaximumIntegerDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMaximumIntegerDigits(Int32): Unit & r;
        let DecimalFormat(df1) = df;
        setMaximumIntegerDigits(df1, n)

    pub def setMinimumIntegerDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMinimumIntegerDigits(Int32): Unit & r;
        let DecimalFormat(df1) = df;
        setMinimumIntegerDigits(df1, n)

    pub def setMaximumFractionDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMaximumFractionDigits(Int32): Unit & r;
        let DecimalFormat(df1) = df;
        setMaximumFractionDigits(df1, n)


    pub def setMinimumFractionDigits!(n: Int32, df: DecimalFormat[r]): Unit \ Write(r) =
        import java.text.DecimalFormat.setMinimumFractionDigits(Int32): Unit & r;
        let DecimalFormat(df1) = df;
        setMinimumFractionDigits(df1, n)

    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def toPattern(df: DecimalFormat[r]): String \ Read(r) =
        import java.text.DecimalFormat.toPattern(): String & r;
        let DecimalFormat(df1) = df;
        toPattern(df1)


}
