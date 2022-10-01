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
    /// Imperative.
    ///
    pub enum DecimalFormatSymbols[_: Region](##java.text.DecimalFormatSymbols)
    
    instance Scoped[DecimalFormatSymbols] {
        pub def regionOf(_: DecimalFormatSymbols[r]): Region[r] = () as Region[r]
    }


}


namespace Interop/Text/DecimalFormatSymbols {

    use Interop/Text.DecimalFormatSymbols;
    use Interop/Text.DecimalFormatSymbols.{DecimalFormatSymbols};
    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    pub def getHH(dfs: DecimalFormatSymbols[r]): ##java.text.DecimalFormatSymbols = 
        let DecimalFormatSymbols(dfs1) = dfs;
        dfs1

    pub def wrapHH(_: Region[r], dfs: ##java.text.DecimalFormatSymbols): DecimalFormatSymbols[r] = 
        DecimalFormatSymbols(dfs)

    ///
    /// Returns a new mutable DecimalFormatSymbols object.
    /// Uses the (implicit) default locale, hence in IO
    ///
    pub def new(_: Region[r]): DecimalFormatSymbols[r] \ {IO, Write(r)} =
        import new java.text.DecimalFormatSymbols(): ##java.text.DecimalFormatSymbols \ {IO, r} as newDecimalFormatSymbols;
        newDecimalFormatSymbols() |> DecimalFormatSymbols

    ///
    /// Returns a new mutable DecimalFormatSymbols object derived from the locale.
    ///
    pub def newWithLocale(_: Region[r], loc: Locale): DecimalFormatSymbols[r] \ Write(r) =
        import new java.text.DecimalFormatSymbols(##java.util.Locale): ##java.text.DecimalFormatSymbols \ r as newDecimalFormatSymbols;
        let Locale(loc1) = loc;
        newDecimalFormatSymbols(loc1) |> DecimalFormatSymbols

}
