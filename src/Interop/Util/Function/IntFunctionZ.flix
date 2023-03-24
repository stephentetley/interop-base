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

namespace Interop/Util/Function {

    ///
    /// Represents a Java IntFunction.
    ///
    /// IntFunction is a builtin functional Interface.
    ///
    pub enum IntFunctionZ[_: Type, _: Bool](##java.util.function.IntFunction)

}


namespace Interop/Util/Function/IntFunctionZ {
    
    use Interop/Util/Function.IntFunctionZ
    use Interop/Util/Function.IntFunctionZ.{IntFunctionZ}
    use Interop/Flix.Marshal


    pub def makeIntFunctionZ(f: Int32 -> a \ ef): IntFunctionZ[a, ef] with Marshal[a] = 
        IntFunctionZ(unchecked_cast((i -> f(i) |> Interop/Flix/Marshal.toJavaObject) as ##java.util.function.IntFunction))

    pub def makeIntFunctionZWith(f: Int32 -> a \ ef, castToObj: a -> ##java.lang.Object): IntFunctionZ[a, ef] = 
        IntFunctionZ(unchecked_cast((i -> f(i) |> castToObj) as ##java.util.function.IntFunction))

}
