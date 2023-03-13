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
    /// Represents a Java IntBinaryOperator.
    ///
    /// IntBinaryOperator is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias IntBinaryOperator = ##java.util.function.IntBinaryOperator


}


namespace Interop/Util/Function/IntBinaryOperator {
    
    use Interop/Util/Function.IntBinaryOperator;
    

    pub def makeIntBinaryOperator(f: (Int32, Int32) -> Int32 \ ef): IntBinaryOperator \ ef = 
        unchecked_cast((new ##java.util.function.IntBinaryOperator {
            def applyAsInt(_this: ##java.util.function.IntBinaryOperator, i: Int32, j: Int32): Int32 = f(i, j)
        }) as _ \ ef)


}
