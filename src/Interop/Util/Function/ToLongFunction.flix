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
    /// Represents a Java ToLongFunction.
    ///
    /// ToLongFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum ToLongFunction[_: Type, _: Bool](##java.util.function.ToLongFunction)


}


mod Interop.Util.Function.ToLongFunction {
    
    use Interop.Util.Function.ToLongFunction
    use Interop.Util.Function.ToLongFunction.{ToLongFunction}
    use Interop.Flix.Marshal

    pub def makeToLongFunction(f: a -> Int64 \ ef): ToLongFunction[a, ef] with Marshal[a]= 
        ToLongFunction(unchecked_cast(new ##java.util.function.ToLongFunction {
            def applyAsLong(_this: ##java.util.function.ToLongFunction, t: ##java.lang.Object): Int64 = 
                Interop.Flix.Marshal.fromJavaObject(t) |> f
        } as _ \ {}))


    pub def applyAsLong(f: ToLongFunction[a, ef], t: a): Int64 \ ef with Marshal[a]  = 
        import java.util.function.ToLongFunction.applyAsLong(##java.lang.Object): Int64 \ ef;
        let ToLongFunction(f1) = f;
        applyAsLong(f1, Interop.Flix.Marshal.toJavaObject(t))

}
