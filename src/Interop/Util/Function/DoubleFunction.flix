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
    /// Represents a Java DoubleFunction.
    ///
    /// DoubleFunction is a builtin functional Interface.
    ///
    pub type alias DoubleFunction[_: Type] = ##java.util.function.DoubleFunction


    

}


namespace Interop/Util/Function/DoubleFunction {
    
    use Interop/Util/Function.DoubleFunction;
    use Interop/Flix.Marshal;


    pub def makeDoubleFunction(f: Float64 -> a \ ef): DoubleFunction[a] \ ef with Marshal[a] = 
        unchecked_cast((d -> f(d) |> Interop/Flix/Marshal.toJavaObject) as DoubleFunction[a] \ ef)


    pub def makeDoubleFunctionWith(f: Float64 -> a \ ef, castToObj: a -> ##java.lang.Object): DoubleFunction[a] \ ef = 
        unchecked_cast((i -> f(i) |> castToObj) as DoubleFunction[a] \ ef)

}
