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
    pub enum IntBinaryOperator(##java.util.function.IntBinaryOperator)


}


namespace Interop/Util/Function/IntBinaryOperator {
    
    use Interop/Util/Function.IntBinaryOperator;
    use Interop/Util/Function.IntBinaryOperator.{IntBinaryOperator};
    
    pub def getHH(x: IntBinaryOperator): ##java.util.function.IntBinaryOperator = 
        let IntBinaryOperator(x1) = x;
        x1


    pub def makeIntBinaryOperator(f: (Int32, Int32) -> Int32 \ ef): IntBinaryOperator \ ef = 
        let op1 = 
            new ##java.util.function.IntBinaryOperator {
                def applyAsInt(_this: ##java.util.function.IntBinaryOperator, i: Int32, j: Int32): Int32 = f(i, j)
            } as \ ef;
        IntBinaryOperator(op1)


}
