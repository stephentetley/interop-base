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
    /// Represents a Java LongBinaryOperator.
    ///
    /// LongBinaryOperator is not a builtin functional Interface so it is created as a new object.
    ///
    /// NOTE - type alias not enum
    ///    
    pub type alias LongBinaryOperator = ##java.util.function.LongBinaryOperator



}


namespace Interop/Util/Function/LongBinaryOperator {
    
    use Interop/Util/Function.LongBinaryOperator
    

    pub def makeLongBinaryOperator(f: (Int64, Int64) -> Int64 \ ef): LongBinaryOperator \ ef = 
        unchecked_cast((new ##java.util.function.LongBinaryOperator {
            def applyAsLong(_this: ##java.util.function.LongBinaryOperator, t: Int64, u: Int64): Int64 = 
                f(t, u)
        }) as _ \ ef)

        
    pub def applyAsLong(t: Int64, u: Int64, f: LongBinaryOperator): Int64 \ ef = 
        import java.util.function.LongBinaryOperator.applyAsLong(Int64, Int64): Int64 \ ef;        
        applyAsLong(f, t, u)


}
