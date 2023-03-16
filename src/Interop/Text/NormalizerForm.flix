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

    use Interop/Text.NormalizerForm
    use Interop/Text.NormalizerForm.{NormalizerForm}
    use Interop/Lang.Enum
    use Interop/Lang.Enum.{Enum}
    use Interop/Lang.SubEnum

    // Design note - Basis libraries should define enums so that constructors
    // are in the Basis namespace.

    pub enum NormalizerForm(##java.text.Normalizer$Form)

    instance SubEnum[NormalizerForm] {
        pub def toEnum(x: NormalizerForm): Enum = 
            let NormalizerForm(x1) = x;
            Enum(unchecked_cast(x1 as ##java.lang.Enum))

        pub def fromEnum(x: Enum): NormalizerForm = 
            let Enum(x1) = x;
            NormalizerForm(unchecked_cast(x1 as ##java.text.Normalizer$Form))
    }

}

namespace Interop/Text/NormalizerForm {

    use Interop/Text.NormalizerForm
    use Interop/Text.NormalizerForm.{NormalizerForm}

    pub def getHH(x: NormalizerForm): ##java.text.Normalizer$Form = 
        let NormalizerForm(x1) = x;
        x1

    pub def nfc(): NormalizerForm = 
        import static get java.text.Normalizer$Form.NFC: ##java.text.Normalizer$Form \ {} as get_NFC;
        get_NFC() |> NormalizerForm

    pub def nfd(): NormalizerForm = 
        import static get java.text.Normalizer$Form.NFD: ##java.text.Normalizer$Form \ {} as get_NFD;
        get_NFD() |> NormalizerForm

    pub def nfkc(): NormalizerForm = 
        import static get java.text.Normalizer$Form.NFKC: ##java.text.Normalizer$Form \ {} as get_NFKC;
        get_NFKC() |> NormalizerForm

    pub def nfkd(): NormalizerForm = 
        import static get java.text.Normalizer$Form.NFKD: ##java.text.Normalizer$Form \ {} as get_NFKD;
        get_NFKD() |> NormalizerForm

}
