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
    /// Represents a Java IntFunction (int -> a).
    ///
    /// IntFunction is a builtin functional Interface.
    ///
    pub enum IntFunctionZ[_: Type, _: Eff](##java.util.function.IntFunction)

}


mod Interop.Util.Function.IntFunctionZ {
    
    use Interop.Util.Function.IntFunctionZ
    use Interop.Util.Function.IntFunctionZ.{IntFunctionZ}
    use Interop.Flix.GoesToJava

    pub def makeIntFunctionZ(f: Int32 -> a \ ef): IntFunctionZ[a, ef] with GoesToJava[a] =  
        let f1 = i -> {
            let ans = unchecked_cast(f(i) as _ \ {});
            Interop.Flix.GoesToJava.toJavaObject(ans) 
        };
        IntFunctionZ(unchecked_cast(f1 as ##java.util.function.IntFunction))


    pub def makeIntFunctionZWith(f: Int32 -> a \ ef, castToObj: a -> ##java.lang.Object): IntFunctionZ[a, ef] = 
        IntFunctionZ(unchecked_cast((i -> f(i) |> castToObj) as ##java.util.function.IntFunction))

    pub def apply(getter: ##java.lang.Object -> a1 \ ef1, f: IntFunctionZ[a, ef], value: Int32): a1 \ {ef, ef1} = 
        let IntFunctionZ(f1) = f;
        unchecked_cast(f1(value) as _ \ ef) |> getter
    

}
