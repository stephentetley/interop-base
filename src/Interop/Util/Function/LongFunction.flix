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
    /// Represents a Java LongFunction.
    ///
    /// LongFunction is a builtin functional Interface.
    ///
    pub type alias LongFunction[_: Type] = ##java.util.function.LongFunction


    

}


namespace Interop/Util/Function/LongFunction {
    
    use Interop/Util/Function.LongFunction;
    use Interop/Flix.Marshal;


    pub def makeLongFunction(f: Int64 -> a \ ef): LongFunction[a] \ ef with Marshal[a] = 
        ((i -> f(i) |> Interop/Flix/Marshal.toJavaObject) as LongFunction[a]) as \ ef


    pub def makeLongFunctionWith(f: Int64 -> a \ ef, cast: a -> ##java.lang.Object): LongFunction[a] \ ef = 
        ((i -> f(i) |> cast) as LongFunction[a]) as \ ef

}
