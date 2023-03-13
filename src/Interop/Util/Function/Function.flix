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
    /// Represents a Java Function.
    ///
    /// Function is a builtin functional Interface.
    ///
    pub type alias Function[_: Type, _: Type] = ##java.util.function.Function


}


namespace Interop/Util/Function/Function {
    
    use Interop/Util/Function.Function
    use Interop/Flix.Marshal
    use Interop/Flix.MutMarshal


    pub def makeFunction(f: a -> b \ ef): Function[a, b] \ ef with Marshal[a], Marshal[b] = 
        let f1 = obj -> {
            let a = Interop/Flix/Marshal.fromJavaObject(obj); 
            let ans = unchecked_cast(f(a) as _ \ IO);
            Interop/Flix/Marshal.toJavaObject(ans) 
        };
        unchecked_cast(f1 as _ \ ef)


    pub def makeSummaryFinisher[a: Type, b: Type, r: Region, t: Type -> Region -> Type, ef: Bool]
                                (r: Region[r], f: t[a, r] -> b \ ef): Function[t[a, r], b] \ ef with MutMarshal[t], Marshal[b] = 
        let f1 = obj -> {
            let t1 = Interop/Flix/MutMarshal.mmFromJavaObject(r, obj);
            let ans = unchecked_cast(f(t1) as _ \ IO);
            Interop/Flix/Marshal.toJavaObject(ans) 
        };
        unchecked_cast(f1 as _ \ ef)

    pub def makeCollectionFinisher[a: Type, r: Region, t: Type -> Region -> Type, ef: Bool]
                                    (r: Region[r], f: t[a, r] -> t[a, r] \ ef): Function[t[a, r], t[a, r]] \ ef with MutMarshal[t] = 
        let f1 = obj -> {
            let t1 = Interop/Flix/MutMarshal.mmFromJavaObject(r, obj);
            let ans = unchecked_cast(f(t1) as _ \ IO);
            Interop/Flix/MutMarshal.mmToJavaObject(ans) 
        };
        unchecked_cast(f1 as _ \ ef)


    pub def makeFunctionWith(f: a -> b \ ef, toA: ##java.lang.Object -> a, fromB: b -> ##java.lang.Object): Function[a, b] \ ef = 
        unchecked_cast((obj -> f(toA(obj)) |> fromB) as Function[a, b] \ ef)


    pub def apply(f: Function[a, b], t: a): b \ ef with Marshal[a], Marshal[b] =
        let obj = Interop/Flix/Marshal.toJavaObject(t);
        let ans = unchecked_cast(f(obj) as _ \ ef);
        Interop/Flix/Marshal.fromJavaObject(ans)
    


    // pub def andThen(f: Function[a, b], g: Function[b, c]): Function[a, c] = 
    //     import java.util.function.Function.andThen(##java.util.function.Function): ##java.util.function.Function \ {};
    //     andThen(f, g)

    // pub def compose(f: Function[b, c], g: Function[a, b]): Function[a, c] = 
    //     import java.util.function.Function.compose(##java.util.function.Function): ##java.util.function.Function \ {};
    //     let Function(f1) = f;
    //     let Function(g1) = g;
    //     compose(f1, g1) |> Function

}
