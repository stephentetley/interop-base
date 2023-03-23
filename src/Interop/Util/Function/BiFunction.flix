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

namespace Interop/Util/Function {

    ///
    /// Represents a Java BiFunction.
    ///
    /// BiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BiFunction[_: Type, _: Type, _: Type, _: Bool](##java.util.function.BiFunction)


}


namespace Interop/Util/Function/BiFunction {
    
    use Interop/Util/Function.BiFunction
    use Interop/Util/Function.BiFunction.{BiFunction}
    use Interop/Util/Function.FunctionZ
    use Interop/Util/Function.FunctionZ.{FunctionZ}
    use Interop/Flix.Marshal



    pub def makeBiFunction[a: Type, b: Type, c: Type, ef: Bool]
                            (f: (a, b) -> c \ ef): BiFunction[a, b, c, ef] with Marshal[a], Marshal[b], Marshal[c] = 
        let f1 = (o1, o2) -> {
            let a = Interop/Flix/Marshal.fromJavaObject(o1); 
            let b = Interop/Flix/Marshal.fromJavaObject(o2);
            let ans = f(a, b);
            Interop/Flix/Marshal.toJavaObject(ans)
        };
        BiFunction(unchecked_cast(new ##java.util.function.BiFunction {
            def apply(_this: ##java.util.function.BiFunction, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as ##java.util.function.BiFunction \ {}))


    pub def apply(f: BiFunction[a, b, c, ef], t: a, u: b): c \ ef with Marshal[a], Marshal[b], Marshal[c]  = 
        import java.util.function.BiFunction.apply(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ ef;
        let BiFunction(f1) = f;
        apply(f1, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u)) |> Interop/Flix/Marshal.fromJavaObject

    pub def andThen[a: Type, b: Type, c: Type, d: Type, ef1: Bool, ef2: Bool]
                    (f: BiFunction[a, b, c, ef1], g: FunctionZ[c, d, ef2]): BiFunction[a, b, d, ef1 and ef2] = 
        import java.util.function.BiFunction.andThen(##java.util.function.Function): ##java.util.function.BiFunction \ {};
        let BiFunction(f1) = f;
        let FunctionZ(g1) = g;
        BiFunction(unchecked_cast(andThen(f1, g1) as ##java.util.function.BiFunction))


}
