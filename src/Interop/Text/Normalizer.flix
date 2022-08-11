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


// java.text.Normalizer is a utility class (only has static methods)

namespace Interop/Text/Normalizer {

    ///
    pub enum NormalizerForm with Eq, Order, ToString, Hash, Boxable {
        case Nfc
        case Nfd
        case Nfkc
        case Nfkd
    }

    pub def marshal(x: NormalizerForm): ##java.text.Normalizer$Form =
        import static get java.text.Normalizer$Form.NFC: ##java.text.Normalizer$Form & Pure as getNFC;
        import static get java.text.Normalizer$Form.NFD: ##java.text.Normalizer$Form & Pure as getNFD;
        import static get java.text.Normalizer$Form.NFKC: ##java.text.Normalizer$Form & Pure as getNFKC;
        import static get java.text.Normalizer$Form.NFKD: ##java.text.Normalizer$Form & Pure as getNFKD;
        match x {
            case Nfc    => getNFC()
            case Nfd    => getNFD()
            case Nfkc   => getNFKC()
            case Nfkd   => getNFKD()
        }

    pub def unmarshal(x: ##java.text.Normalizer$Form): NormalizerForm =
        import static get java.text.Normalizer$Form.NFC: ##java.text.Normalizer$Form & Pure as getNFC;
        import static get java.text.Normalizer$Form.NFD: ##java.text.Normalizer$Form & Pure as getNFD;
        import static get java.text.Normalizer$Form.NFKC: ##java.text.Normalizer$Form & Pure as getNFKC;
        import static get java.text.Normalizer$Form.NFKD: ##java.text.Normalizer$Form & Pure as getNFKD;
        match x {
            case x1 if primEquals(x1, getNFC())    => Nfc
            case x1 if primEquals(x1, getNFD())    => Nfd
            case x1 if primEquals(x1, getNFKC())   => Nfkc
            case x1 if primEquals(x1, getNFKD())   => Nfkd
        }

    /// Warning - is this reference equality or value equality?
    def primEquals(x: ##java.text.Normalizer$Form, y: ##java.text.Normalizer$Form): Bool =
        import java.lang.Enum.equals(##java.lang.Object): Bool & Pure;
        equals(x as ##java.lang.Enum, y as ##java.lang.Object)

    pub def normalize(nform: NormalizerForm, src: String): Result[String, String] =
        import static java.text.Normalizer.normalize(##java.lang.CharSequence, ##java.text.Normalizer$Form): String & Pure;
        try {
            let nform1 = marshal(nform);
            normalize(src as ##java.lang.CharSequence, nform1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }

    pub def isNormalized(nform: NormalizerForm, src: String): Result[Bool, String] =
        import static java.text.Normalizer.isNormalized(##java.lang.CharSequence, ##java.text.Normalizer$Form): Bool & Pure;
        try {
            let nform1 = marshal(nform);
            isNormalized(src as ##java.lang.CharSequence, nform1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }
}