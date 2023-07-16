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
    /// Represents a Java ToDoubleBiFunction.
    ///
    /// ToDoubleBiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum ToDoubleBiFunction[_: Type, _: Type, _: Eff](##java.util.function.ToDoubleBiFunction)


}


mod Interop.Util.Function.ToDoubleBiFunction {
    
    use Interop.Util.Function.ToDoubleBiFunction
    use Interop.Util.Function.ToDoubleBiFunction.{ToDoubleBiFunction}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava

    pub def makeToDoubleBiFunction(f: (a, b) -> Float64 \ ef): ToDoubleBiFunction[a, b, ef] with ComesFromJava[a], ComesFromJava[b] = 
        ToDoubleBiFunction(unchecked_cast(new ##java.util.function.ToDoubleBiFunction {
            def applyAsDouble(_this: ##java.util.function.ToDoubleBiFunction, t: ##java.lang.Object, u: ##java.lang.Object): Float64 = 
                let a1 = Interop.Flix.ComesFromJava.fromJavaObject(t);
                let b1 = Interop.Flix.ComesFromJava.fromJavaObject(u);
                f(a1, b1)
        } as _ \ {}))


    pub def applyAsDouble(f: ToDoubleBiFunction[a, b, ef], t: a, u: b): Float64 \ ef with GoesToJava[a], GoesToJava[b] = 
        import java.util.function.ToDoubleBiFunction.applyAsDouble(##java.lang.Object, ##java.lang.Object): Float64 \ ef;
        let ToDoubleBiFunction(f1) = f;
        applyAsDouble(f1, Interop.Flix.GoesToJava.toJavaObject(t), Interop.Flix.GoesToJava.toJavaObject(u))

}
