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

mod Interop.Text {
    
    use Interop.Text.RuleBasedCollator
    use Interop.Text.RuleBasedCollator.{RuleBasedCollator}
    use Interop.Text.Collator
    use Interop.Text.Collator.{Collator}
    
    ///
    /// Represents a RuleBasedCollator.
    /// Subclass of Collator
    /// "Immutable after init"
    ///
    pub enum RuleBasedCollator(##java.text.RuleBasedCollator)


    instance SubCollator[RuleBasedCollator] {
        pub def toCollator(x: RuleBasedCollator): Collator = 
            let RuleBasedCollator(x1) = x;
            Collator(unchecked_cast(x1 as ##java.text.Collator))
        
        pub def fromCollator(x: Collator): RuleBasedCollator = 
            let Collator(x1) = x;
            RuleBasedCollator(unchecked_cast(x1 as ##java.text.RuleBasedCollator))

    }


}

mod Interop.Text.RuleBasedCollator {

    use Interop.Text.RuleBasedCollator
    use Interop.Text.RuleBasedCollator.{RuleBasedCollator}
    use Interop.Text.Collator.{Collator}
    use Interop.Text.MutCollator
    use Interop.Text.MutCollator.{MutCollator}
    use Interop.Text.CollatorInit
    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}

    pub def getHH(c: RuleBasedCollator): ##java.text.RuleBasedCollator = 
        let RuleBasedCollator(c1) = c;
        c1


    pub def wrapHH(prim: ##java.text.RuleBasedCollator): RuleBasedCollator = 
        RuleBasedCollator(prim)

    ///
    /// New RuleBasedCollator.
    ///
    pub def new(_: Region[r], rules: String, init: CollatorInit[r]): Result[String, RuleBasedCollator] \ r = 
        Result.tryCatch(_ -> {
            import new java.text.RuleBasedCollator(String): ##java.text.RuleBasedCollator \ {} as new1;
            let rbc1 = new1(rules);
            let c1   = unchecked_cast(rbc1 as ##java.text.Collator); 
            let _    = MutCollator(c1) |> init;
            RuleBasedCollator(rbc1)
        })

    pub def hashCode(c: RuleBasedCollator): Int32 = 
        import java.text.RuleBasedCollator.hashCode(): Int32 \ {};
        let RuleBasedCollator(c1) = c;
        hashCode(c1)


    pub def getRules(c: RuleBasedCollator): String = 
        import java.text.RuleBasedCollator.getRules(): String\ {};
        let RuleBasedCollator(c1) = c;
        getRules(c1)
        
}
