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

mod Interop.Text {
    
    use Interop.Text.ChoiceFormat
    use Interop.Text.ChoiceFormat.{ChoiceFormat}
    use Interop.Text.NumberFormat
    use Interop.Text.NumberFormat.{NumberFormat}

    ///
    /// Represents a ChoiceFormat.
    /// "Immutable with Setter"
    ///
    pub enum ChoiceFormat(##java.text.ChoiceFormat)

    instance SubNumberFormat[ChoiceFormat] {
        pub def toNumberFormat(fmt: ChoiceFormat): NumberFormat = 
            let ChoiceFormat(fmt1) = fmt;
            NumberFormat(unchecked_cast(fmt1 as ##java.text.NumberFormat))

        pub def fromNumberFormat(fmt: NumberFormat): ChoiceFormat = 
            let NumberFormat(fmt1) = fmt;
            ChoiceFormat(unchecked_cast(fmt1 as ##java.text.ChoiceFormat))
    }

}


mod Interop.Text.ChoiceFormat {

    use Interop.Text.ChoiceFormat
    use Interop.Text.ChoiceFormat.{ChoiceFormat}
    use Interop.Math.RoundingMode
   
    pub def getHH(cf: ChoiceFormat): ##java.text.ChoiceFormat = 
        let ChoiceFormat(cf1) = cf;
        cf1

    pub def wrapHH(prim: ##java.text.ChoiceFormat): ChoiceFormat = 
        ChoiceFormat(prim)

    ///
    /// Returns a new ChoiceFormat.
    ///
    pub def new(pattern: String): ChoiceFormat =
        import java_new java.text.ChoiceFormat(String): ##java.text.ChoiceFormat \ {} as new1;
        ChoiceFormat(new1(pattern))

    ///
    /// Returns a new ChoiceFormat.
    ///
    pub def newWithChoices(limits: List[Float64], formats: List[String]): Result[String, ChoiceFormat] =
        Result.tryCatch(_ -> {
            region rc {
                import java_new java.text.ChoiceFormat(Array[Float64, rc], Array[String, rc]): ##java.text.ChoiceFormat \ {} as new1;
                let limits1 = List.toArray(rc, limits);
                let formats1 = List.toArray(rc, formats);
                ChoiceFormat(new1(limits1, formats1))
            }
        })


    ///
    pub def toPattern(cf: ChoiceFormat): String =
        import java.text.ChoiceFormat.toPattern(): String \ {};
        let ChoiceFormat(cf1) = cf;
        toPattern(cf1)

}
