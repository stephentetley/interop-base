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
    /// Represents a Java IntToLongFunction.
    ///
    /// IntToLongFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum IntToLongFunction[_: Eff](##java.util.function.IntToLongFunction)


}


mod Interop.Util.Function.IntToLongFunction {
    
    use Interop.Util.Function.IntToLongFunction
    use Interop.Util.Function.IntToLongFunction.{IntToLongFunction}

    pub def makeIntToLongFunction(f: Int32 -> Int64 \ ef): IntToLongFunction[ef] = 
        IntToLongFunction(unchecked_cast(new ##java.util.function.IntToLongFunction {
            def applyAsLong(_this: ##java.util.function.IntToLongFunction, i: Int32): Int64 = 
                f(i)
        } as _ \ {}))


    pub def applyAsLong(f: IntToLongFunction[ef], i: Int32): Int64 \ ef  = 
        import java.util.function.IntToLongFunction.applyAsLong(Int32): Int64 \ ef;
        let IntToLongFunction(f1) = f;
        applyAsLong(f1, i)

}
