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


namespace Interop/NIO/File {

    pub enum OpenOption(##java.nio.file.OpenOption)

    pub class ImpOpenOption[t: Type] {
        pub def toOpenOption(s: t): OpenOption
        pub def fromOpenOption(s: OpenOption): t
    }

    instance Interop/Flix.Marshal[OpenOption] {
        pub def toJavaObject(x: OpenOption): ##java.lang.Object =
            let OpenOption(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): OpenOption = 
            OpenOption(unchecked_cast(o as ##java.nio.file.OpenOption))
    }

}
