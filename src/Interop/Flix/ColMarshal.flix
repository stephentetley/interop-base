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

mod Interop.Flix {

    /// Marshal class for `Type -> Region -> Type` types.
    pub class ColMarshal[t: Type -> Region -> Type] {
        pub def colToJavaObject(x: t[a, r]): ##java.lang.Object

        pub def colFromJavaObject(rc: Region[r], o: ##java.lang.Object): t[a, r]
    }

}


