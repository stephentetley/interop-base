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
    /// Represents a Java IntToDoubleFunction.
    ///
    /// IntToDoubleFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum IntToDoubleFunction[_: Eff](##java.util.function.IntToDoubleFunction)


}


mod Interop.Util.Function.IntToDoubleFunction {
    
    use Interop.Util.Function.IntToDoubleFunction
    use Interop.Util.Function.IntToDoubleFunction.{IntToDoubleFunction}

    pub def makeIntToDoubleFunction(f: Int32 -> Float64 \ ef): IntToDoubleFunction[ef] = 
        IntToDoubleFunction(unchecked_cast(new ##java.util.function.IntToDoubleFunction {
            def applyAsDouble(_this: ##java.util.function.IntToDoubleFunction, i: Int32): Float64 = 
                f(i)
        } as _ \ {}))


    pub def applyAsDouble(f: IntToDoubleFunction[ef], i: Int32): Float64 \ ef  = 
        import java.util.function.IntToDoubleFunction.applyAsDouble(Int32): Float64 \ ef;
        let IntToDoubleFunction(f1) = f;
        applyAsDouble(f1, i)

}
