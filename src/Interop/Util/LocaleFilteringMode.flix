/*
 * Copyright 2023 Stephen Tetley
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

namespace Interop/Util {

    use Interop/Util.LocaleFilteringMode
    use Interop/Util.LocaleFilteringMode.{LocaleFilteringMode}
    use Interop/Lang.Enum
    use Interop/Lang.Enum.{Enum}
    
    /// 
    /// Enum
    ///
    pub enum LocaleFilteringMode(##java.util.Locale$FilteringMode)


    instance Interop/Lang.SubEnum[LocaleFilteringMode] {
        pub def toEnum(x: LocaleFilteringMode): Enum = 
            let LocaleFilteringMode(x1) = x;
            Enum(unchecked_cast(x1 as ##java.lang.Enum))

        pub def fromEnum(x: Enum): LocaleFilteringMode = 
            let Enum(x1) = x;
            LocaleFilteringMode(unchecked_cast(x1 as ##java.util.Locale$FilteringMode))
    }

}



namespace Interop/Util/LocaleFilteringMode {

    use Interop/Util.LocaleFilteringMode
    use Interop/Util.LocaleFilteringMode.{LocaleFilteringMode}

    pub def getHH(x: LocaleFilteringMode): ##java.util.Locale$FilteringMode = 
        let LocaleFilteringMode(x1) = x;
        x1

    pub def autoselect_filtering(): LocaleFilteringMode = 
        import static get java.util.Locale$FilteringMode.AUTOSELECT_FILTERING: ##java.util.Locale$FilteringMode \ {} as get_AUTOSELECT_FILTERING;
        get_AUTOSELECT_FILTERING() |> LocaleFilteringMode

    pub def extended_filtering(): LocaleFilteringMode = 
        import static get java.util.Locale$FilteringMode.EXTENDED_FILTERING: ##java.util.Locale$FilteringMode \ {} as get_EXTENDED_FILTERING;
        get_EXTENDED_FILTERING() |> LocaleFilteringMode
    
    pub def ignore_extended_ranges(): LocaleFilteringMode = 
        import static get java.util.Locale$FilteringMode.IGNORE_EXTENDED_RANGES: ##java.util.Locale$FilteringMode \ {} as get_IGNORE_EXTENDED_RANGES;
        get_IGNORE_EXTENDED_RANGES() |> LocaleFilteringMode

    pub def map_extended_ranges(): LocaleFilteringMode = 
        import static get java.util.Locale$FilteringMode.MAP_EXTENDED_RANGES: ##java.util.Locale$FilteringMode \ {} as get_MAP_EXTENDED_RANGES;
        get_MAP_EXTENDED_RANGES() |> LocaleFilteringMode

    pub def reject_extended_ranges(): LocaleFilteringMode =         
        import static get java.util.Locale$FilteringMode.REJECT_EXTENDED_RANGES: ##java.util.Locale$FilteringMode \ {} as get_REJECT_EXTENDED_RANGES;
        get_REJECT_EXTENDED_RANGES() |> LocaleFilteringMode



}
