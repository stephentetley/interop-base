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
    use Interop/Util/Function.Function
    use Interop/Flix.Marshal



    pub def makeBiFunction(f: (a, b) -> c \ ef): BiFunction[a, b, c, ef] with Marshal[a], Marshal[b], Marshal[c] = 
        let f1 = (o1, o2) -> {
            let a = Interop/Flix/Marshal.fromJavaObject(o1); 
            let b = Interop/Flix/Marshal.fromJavaObject(o2);
            let ans = f(a, b);
            Interop/Flix/Marshal.toJavaObject(ans)
        };
        BiFunction(unchecked_cast(new ##java.util.function.BiFunction {
            def apply(_this: ##java.util.function.BiFunction, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as _ \ {}))


    pub def apply(f: BiFunction[a, b, c, ef], t: a, u: b): c \ ef with Marshal[a], Marshal[b], Marshal[c]  = 
        import java.util.function.BiFunction.apply(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ ef;
        let BiFunction(f1) = f;
        apply(f1, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u)) |> Interop/Flix/Marshal.fromJavaObject

    pub def andThen(f: BiFunction[a, b, c, ef], g: Function[c, d]): BiFunction[a, b, d, ef] = 
        import java.util.function.BiFunction.andThen(##java.util.function.Function): ##java.util.function.BiFunction \ {ef};
        let BiFunction(f1) = f;
        BiFunction(unchecked_cast(andThen(f1, g) as _ \ {}))


}
