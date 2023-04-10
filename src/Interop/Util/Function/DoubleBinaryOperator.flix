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

mod Interop.Util.Function {

    ///
    /// Represents a Java DoubleBinaryOperator.
    ///
    /// DoubleBinaryOperator is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum DoubleBinaryOperator[_: Bool](##java.util.function.DoubleBinaryOperator)



}


mod Interop.Util.Function.DoubleBinaryOperator {
    
    use Interop.Util.Function.DoubleBinaryOperator
    use Interop.Util.Function.DoubleBinaryOperator.{DoubleBinaryOperator}

    pub def makeDoubleBinaryOperator(f: (Float64, Float64) -> Float64 \ ef): DoubleBinaryOperator[ef] = 
        DoubleBinaryOperator(unchecked_cast(new ##java.util.function.DoubleBinaryOperator {
            def applyAsDouble(_this: ##java.util.function.DoubleBinaryOperator, t: Float64, u: Float64): Float64 = 
                f(t, u)
        } as _ \ {}))

        
    pub def apply(t: Float64, u: Float64, f: DoubleBinaryOperator[ef]): Float64 \ ef = 
        import java.util.function.DoubleBinaryOperator.applyAsDouble(Float64, Float64): Float64 \ ef;        
        let DoubleBinaryOperator(f1) = f;
        applyAsDouble(f1, t, u)


}
