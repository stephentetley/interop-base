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
    pub enum LocaleCategory(##java.util.Locale$Category)


}



namespace Interop/Util/LocaleCategory {

    use Interop/Util.LocaleCategory
    use Interop/Util.LocaleCategory.{LocaleCategory}

    pub def getHH(x: LocaleCategory): ##java.util.Locale$Category = 
        let LocaleCategory(x1) = x;
        x1

    pub def display(): LocaleCategory = 
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category \ {} as get_DISPLAY;
        get_DISPLAY() |> LocaleCategory

    pub def format(): LocaleCategory = 
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category \ {} as get_FORMAT;
        get_FORMAT() |> LocaleCategory

}
