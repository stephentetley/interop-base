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
    /// Represents a Java LongFunction.
    ///
    /// LongFunction is a builtin functional Interface.
    ///
    pub enum LongFunctionZ[_: Type, _: Eff](##java.util.function.LongFunction)

}


mod Interop.Util.Function.LongFunctionZ {
    
    use Interop.Util.Function.LongFunctionZ
    use Interop.Util.Function.LongFunctionZ.{LongFunctionZ}
    use Interop.Flix.GoesToJava


    pub def makeLongFunctionZ(f: Int64 -> a \ ef): LongFunctionZ[a, ef] with GoesToJava[a] = 
        LongFunctionZ(unchecked_cast((i -> f(i) |> Interop.Flix.GoesToJava.toJavaObject) as ##java.util.function.LongFunction))


    pub def makeLongFunctionZWith(f: Int64 -> a \ ef, castToObj: a -> ##java.lang.Object): LongFunctionZ[a, ef] = 
        LongFunctionZ(unchecked_cast((i -> f(i) |> castToObj) as ##java.util.function.LongFunction))

    pub def apply(getter: ##java.lang.Object -> a1 \ ef1, f: LongFunctionZ[a, ef], value: Int64): a1 \ {ef, ef1} = 
        let LongFunctionZ(f1) = f;
        unchecked_cast(f1(value) as _ \ ef) |> getter

}
