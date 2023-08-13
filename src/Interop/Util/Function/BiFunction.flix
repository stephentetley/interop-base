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
    /// Represents a Java BiFunction.
    ///
    /// BiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BiFunction[_: Type, _: Type, _: Type, _: Eff](##java.util.function.BiFunction)


}


mod Interop.Util.Function.BiFunction {
    
    use Interop.Util.Function.BiFunction
    use Interop.Util.Function.BiFunction.{BiFunction}
    use Interop.Util.Function.FunctionZ
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Flix.GoesToJava



    pub def makeBiFunction(getterA: ##java.lang.Object -> a \ ef1,
                            getterB: ##java.lang.Object -> b \ ef2, 
                            f: (a, b) -> c \ ef): BiFunction[a, b, c, ef + ef1 + ef2] with GoesToJava[c] = 
        let f1 = (o1, o2) -> {
            let a = getterA(o1); 
            let b = getterB(o2);
            let ans = f(a, b);
            Interop.Flix.GoesToJava.toJavaObject(ans)
        };
        BiFunction(unchecked_cast(new ##java.util.function.BiFunction {
            def apply(_this: ##java.util.function.BiFunction, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as ##java.util.function.BiFunction \ {}))


    pub def apply(getter: ##java.lang.Object -> c1 \ ef1, 
                    f: BiFunction[a, b, c, ef], 
                    t: a, u: b): c1 \ {ef, ef1} with GoesToJava[a], GoesToJava[b] = 
        import java.util.function.BiFunction.apply(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ ef;
        let BiFunction(f1) = f;
        apply(f1, Interop.Flix.GoesToJava.toJavaObject(t), Interop.Flix.GoesToJava.toJavaObject(u)) |> getter

    pub def andThen[a: Type, b: Type, c: Type, d: Type, ef1: Eff, ef2: Eff]
                    (f: BiFunction[a, b, c, ef1], g: FunctionZ[c, d, ef2]): BiFunction[a, b, d, ef1 + ef2] = 
        import java.util.function.BiFunction.andThen(##java.util.function.Function): ##java.util.function.BiFunction \ {};
        let BiFunction(f1) = f;
        let FunctionZ(g1) = g;
        BiFunction(unchecked_cast(andThen(f1, g1) as ##java.util.function.BiFunction))


}
