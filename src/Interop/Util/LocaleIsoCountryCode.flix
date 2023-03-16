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
    
    /// 
    /// Enum
    /// 
    pub enum LocaleIsoCountryCode(##java.util.Locale$IsoCountryCode)


}



namespace Interop/Util/LocaleIsoCountryCode {

    use Interop/Util.LocaleIsoCountryCode
    use Interop/Util.LocaleIsoCountryCode.{LocaleIsoCountryCode}

    pub def getHH(x: LocaleIsoCountryCode): ##java.util.Locale$IsoCountryCode = 
        let LocaleIsoCountryCode(x1) = x;
        x1


    pub def part1_alpha2(): LocaleIsoCountryCode = 
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA2: ##java.util.Locale$IsoCountryCode \ {} as get_PART1_ALPHA2;
        get_PART1_ALPHA2() |> LocaleIsoCountryCode

    pub def part1_alpha3(): LocaleIsoCountryCode = 
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA3: ##java.util.Locale$IsoCountryCode \ {} as get_PART1_ALPHA3;
        get_PART1_ALPHA3() |> LocaleIsoCountryCode

    pub def part3(): LocaleIsoCountryCode = 
        import static get java.util.Locale$IsoCountryCode.PART3: ##java.util.Locale$IsoCountryCode \ {} as get_PART3;
        get_PART3() |> LocaleIsoCountryCode
        

}
