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
    /// Represents a RuleBasedCollator.
    /// Subclass of Collator
    /// "Immutable with Setter"
    ///
    pub enum RuleBasedCollator(##java.text.RuleBasedCollator)


    instance SubCollator[RuleBasedCollator] {
        pub def toCollator(x: RuleBasedCollator): Collator = 
            let RuleBasedCollator(x1) = x;
            Collator(unsafe_cast x1 as ##java.text.Collator)
        
        pub def fromCollator(x: Collator): RuleBasedCollator = 
            let Collator(x1) = x;
            RuleBasedCollator(unsafe_cast x1 as ##java.text.RuleBasedCollator)

    }


}

namespace Interop/Text/RuleBasedCollator {

    use Interop/Text.RuleBasedCollator
    use Interop/Text.RuleBasedCollator.{RuleBasedCollator}
    use Interop/Text.Collator.{CollatorProperty}
    use Interop/Util.Locale
    use Interop/Util.Locale.{Locale}
    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def getHH(c: RuleBasedCollator): ##java.text.RuleBasedCollator = 
        let RuleBasedCollator(c1) = c;
        c1


    pub def wrapHH(prim: ##java.text.RuleBasedCollator): RuleBasedCollator = 
        RuleBasedCollator(prim)

    pub def makeSetter(rc: Region[r], xs: List[CollatorProperty]): Setter[RuleBasedCollator, r] =         
        Interop/Text/Collator.makeSetter(rc, xs) |> Interop/Flix/Setter.castSetter(Interop/Text/SubCollator.toCollator)

    ///
    /// New RuleBasedCollator.
    ///
    pub def new(rules: String, props: List[CollatorProperty]): Result[String, RuleBasedCollator] = region rc {
        import new java.text.RuleBasedCollator(String): ##java.text.RuleBasedCollator \ {} as new1;
        RuleBasedCollator(new1(rules)) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    pub def hashCode(c: RuleBasedCollator): Int32 = 
        import java.text.RuleBasedCollator.hashCode(): Int32 \ {};
        let RuleBasedCollator(c1) = c;
        hashCode(c1)


    pub def getRules(c: RuleBasedCollator): String = 
        import java.text.RuleBasedCollator.getRules(): String\ {};
        let RuleBasedCollator(c1) = c;
        getRules(c1)
        
}
