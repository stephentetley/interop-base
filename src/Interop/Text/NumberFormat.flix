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
    
    /// Abstract Class
    /// Represents a NumberFormat.
    /// Mutable
    pub enum NumberFormat[_: Region](##java.text.NumberFormat)

    pub class SubNumberFormat[t: Region -> Type] {
        pub def toNumberFormat[r: Region](s: t[r]): NumberFormat[r]
        pub def fromNumberFormat[r: Region](s: NumberFormat[r]): t[r]
    }

}


namespace Interop/Text/NumberFormat {

    use Interop/Text.NumberFormat;
    use Interop/Text.NumberFormat.{NumberFormat};

    use Interop/Lang.Number;
    use Interop/Lang.Number.{Number};

    pub def getHH(x: NumberFormat[r]): ##java.text.NumberFormat = 
        let NumberFormat(x1) = x;
        x1

    pub def parse(s: String, nf: NumberFormat[r]): Result[Number, String] \ Read(r) = 
        try {
            import java.text.NumberFormat.parse(String): ##java.lang.Number & r;
            let NumberFormat(nf1) = nf;
            Number(parse(nf1, s)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }

    pub def formatInt64(n: Int64, nf: NumberFormat[r]): Result[String, String] \ Read(r) = 
        try {
            import java.text.NumberFormat.format(Int64): String & r;
            let NumberFormat(nf1) = nf;
            format(nf1, n) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }

    pub def formatFloat64(d: Float64, nf: NumberFormat[r]): Result[String, String] \ Read(r) = 
        try {
            import java.text.NumberFormat.format(Float64): String & r;
            let NumberFormat(nf1) = nf;
            format(nf1, d) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & r;
                Err(getMessage(ex))
        }


}
