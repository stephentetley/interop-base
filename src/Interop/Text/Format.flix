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
    
    /// Abstract Class
    pub enum Format(##java.text.Format)


    pub class SubFormat[t: Type] {
        pub def toFormat(s: t): Format
        pub def fromFormat(s: Format): t
    }

}


mod Interop.Text.Format {

    use Interop.Text.Format
    use Interop.Text.Format.{Format}

    pub def getHH(f: Format): ##java.text.Format = 
        let Format(f1) = f;
        f1

    pub def wrapHH(prim: ##java.text.Format): Format = 
        Format(prim)

    // No constructor - abstract base class

    pub def format(obj: ##java.lang.Object, fmt: Format): Result[String, String] = 
        Result.tryCatch(_ -> {
            import java.text.Format.format(##java.lang.Object): String \ {};
            let Format(fmt1) = fmt;
            format(fmt1, obj)
        })

    pub def parseObject(s: String, fmt: Format): Result[String, ##java.lang.Object] = 
        Result.tryCatch(_ -> {
            import java.text.Format.parseObject(String): ##java.lang.Object \ {};
            let Format(fmt1) = fmt;
            parseObject(fmt1, s)
        })

}
