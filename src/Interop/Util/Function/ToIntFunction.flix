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
    /// Represents a Java ToIntFunction.
    ///
    /// ToIntFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum ToIntFunction[_: Type, _: Bool](##java.util.function.ToIntFunction)


}


mod Interop.Util.Function.ToIntFunction {
    
    use Interop.Util.Function.ToIntFunction
    use Interop.Util.Function.ToIntFunction.{ToIntFunction}
    use Interop.Flix.Marshal

    pub def makeToIntFunction(f: a -> Int32 \ ef): ToIntFunction[a, ef] with Marshal[a]= 
        ToIntFunction(unchecked_cast(new ##java.util.function.ToIntFunction {
            def applyAsInt(_this: ##java.util.function.ToIntFunction, t: ##java.lang.Object): Int32 = 
                Interop.Flix.Marshal.fromJavaObject(t) |> f
        } as _ \ {}))


    pub def applyAsInt(f: ToIntFunction[a, ef], t: a): Int32 \ ef with Marshal[a]  = 
        import java.util.function.ToIntFunction.applyAsInt(##java.lang.Object): Int32 \ ef;
        let ToIntFunction(f1) = f;
        applyAsInt(f1, Interop.Flix.Marshal.toJavaObject(t))

}
