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
    /// Represents a Java ToDoubleFunction.
    ///
    /// ToDoubleFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum ToDoubleFunction[_: Type, _: Eff](##java.util.function.ToDoubleFunction)


}


mod Interop.Util.Function.ToDoubleFunction {
    
    use Interop.Util.Function.ToDoubleFunction
    use Interop.Util.Function.ToDoubleFunction.{ToDoubleFunction}
    use Interop.Flix.Marshal

    pub def makeToDoubleFunction(f: a -> Float64 \ ef): ToDoubleFunction[a, ef] with Marshal[a]= 
        ToDoubleFunction(unchecked_cast(new ##java.util.function.ToDoubleFunction {
            def applyAsDouble(_this: ##java.util.function.ToDoubleFunction, t: ##java.lang.Object): Float64 = 
                Interop.Flix.Marshal.fromJavaObject(t) |> f
        } as _ \ {}))


    pub def applyAsDouble(f: ToDoubleFunction[a, ef], t: a): Float64 \ ef with Marshal[a]  = 
        import java.util.function.ToDoubleFunction.applyAsDouble(##java.lang.Object): Float64 \ ef;
        let ToDoubleFunction(f1) = f;
        applyAsDouble(f1, Interop.Flix.Marshal.toJavaObject(t))

}
