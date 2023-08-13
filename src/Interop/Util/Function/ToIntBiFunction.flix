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
    /// Represents a Java ToIntBiFunction.
    ///
    /// ToIntBiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum ToIntBiFunction[_: Type, _: Type, _: Eff](##java.util.function.ToIntBiFunction)


}


mod Interop.Util.Function.ToIntBiFunction {
    
    use Interop.Util.Function.ToIntBiFunction
    use Interop.Util.Function.ToIntBiFunction.{ToIntBiFunction}
    use Interop.Flix.GoesToJava

    pub def makeToIntBiFunction(getterA: ##java.lang.Object -> a \ ef1,
                                    getterB: ##java.lang.Object -> b \ ef2,
                                    f: (a, b) -> Int32 \ ef): ToIntBiFunction[a, b, ef + ef1 + ef2] = 
        ToIntBiFunction(unchecked_cast(new ##java.util.function.ToIntBiFunction {
            def applyAsInt(_this: ##java.util.function.ToIntBiFunction, t: ##java.lang.Object, u: ##java.lang.Object): Int32 = 
                let a1 = getterA(t);
                let b1 = getterB(u);
                f(a1, b1)
        } as _ \ {}))


    pub def applyAsInt(f: ToIntBiFunction[a, b, ef], t: a, u: b): Int32 \ ef with GoesToJava[a], GoesToJava[b] = 
        import java.util.function.ToIntBiFunction.applyAsInt(##java.lang.Object, ##java.lang.Object): Int32 \ ef;
        let ToIntBiFunction(f1) = f;
        applyAsInt(f1, Interop.Flix.GoesToJava.toJavaObject(t), Interop.Flix.GoesToJava.toJavaObject(u))

}
