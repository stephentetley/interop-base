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
    /// Represents a Java ToDoubleFunction.
    ///
    /// ToDoubleFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias ToDoubleFunction[_: Type] = ##java.util.function.ToDoubleFunction


}


namespace Interop/Util/Function/ToDoubleFunction {
    
    use Interop/Util/Function.ToDoubleFunction
    use Interop/Flix.Marshal

    pub def makeToDoubleFunction(f: a -> Float64 \ ef): ToDoubleFunction[a] \ ef with Marshal[a]= 
        new ##java.util.function.ToDoubleFunction {
            def applyAsDouble(_this: ##java.util.function.ToDoubleFunction, t: ##java.lang.Object): Float64 = 
                Interop/Flix/Marshal.fromJavaObject(t) |> f
        } as \ ef


    pub def applyAsInt(f: ToDoubleFunction[a], t: a): Float64 \ ef with Marshal[a]  = 
        import java.util.function.ToDoubleFunction.applyAsDouble(##java.lang.Object): Float64 \ ef;
        applyAsDouble(f, Interop/Flix/Marshal.toJavaObject(t))

}
