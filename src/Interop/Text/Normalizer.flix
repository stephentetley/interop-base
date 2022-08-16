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

    use Interop/Text.NormalizerForm;
    use Interop/Text.NormalizerForm.{NormalizerForm};

    pub def normalize(nform: NormalizerForm, src: String): Result[String, String] =
        import static java.text.Normalizer.normalize(##java.lang.CharSequence, ##java.text.Normalizer$Form): String & Pure;
        try {
            let NormalizerForm(nform1) = nform;
            normalize(src as ##java.lang.CharSequence, nform1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }

    pub def isNormalized(nform: NormalizerForm, src: String): Result[Bool, String] =
        import static java.text.Normalizer.isNormalized(##java.lang.CharSequence, ##java.text.Normalizer$Form): Bool & Pure;
        try {
            let NormalizerForm(nform1) = nform;
            isNormalized(src as ##java.lang.CharSequence, nform1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }
}
