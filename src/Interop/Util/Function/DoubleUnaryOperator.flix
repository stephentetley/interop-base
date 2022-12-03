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
    /// Represents a Java DoubleUnaryOperator.
    ///
    /// DoubleUnaryOperator is a builtin functional Interface.
    ///
    pub type alias DoubleUnaryOperator = ##java.util.function.DoubleUnaryOperator


}


namespace Interop/Util/Function/DoubleUnaryOperator {
    
    use Interop/Util/Function.DoubleUnaryOperator;
    

    pub def makeDoubleUnaryOperator(f: Float64 -> Float64 \ ef): DoubleUnaryOperator \ ef = unsafe_cast f as DoubleUnaryOperator \ ef



}
