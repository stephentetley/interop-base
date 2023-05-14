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
    /// Represents a Java Function.
    ///
    /// Function is a builtin functional Interface.
    ///
    pub enum FunctionZ[_: Type, _: Type, _: Eff](##java.util.function.Function)


}


mod Interop.Util.Function.FunctionZ {
    
    use Interop.Util.Function.FunctionZ
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Flix.Marshal
    use Interop.Flix.MutMarshal


    pub def makeFunctionZ(f: a -> b \ ef): FunctionZ[a, b, ef] with Marshal[a], Marshal[b] = 
        let f1 = obj -> {
            let a = Interop.Flix.Marshal.fromJavaObject(obj); 
            let ans = unchecked_cast(f(a) as _ \ {});
            Interop.Flix.Marshal.toJavaObject(ans) 
        };
        FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))


    pub def makeSummaryFinisher[a: Type, b: Type, r: Region, t: Type -> Region -> Type, ef: Eff]
                                (r: Region[r], f: t[a, r] -> b \ ef): FunctionZ[t[a, r], b, ef] with MutMarshal[t], Marshal[b] = 
        let f1 = obj -> {
            let t1 = Interop.Flix.MutMarshal.mmFromJavaObject(r, obj);
            let ans = unchecked_cast(f(t1) as _ \ IO);
            Interop.Flix.Marshal.toJavaObject(ans) 
        };
        FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))

    pub def makeCollectionFinisher[a: Type, r: Region, t: Type -> Region -> Type, ef: Eff]
                                    (r: Region[r], f: t[a, r] -> t[a, r] \ ef): FunctionZ[t[a, r], t[a, r], ef] with MutMarshal[t] = 
        let f1 = obj -> {
            let t1 = Interop.Flix.MutMarshal.mmFromJavaObject(r, obj);
            let ans = unchecked_cast(f(t1) as _ \ IO);
            Interop.Flix.MutMarshal.mmToJavaObject(ans) 
        };
        FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))



    pub def makeFunctionZWith(f: a -> b \ ef, toA: ##java.lang.Object -> a, fromB: b -> ##java.lang.Object): FunctionZ[a, b, ef] = 
        FunctionZ(unchecked_cast((obj -> f(toA(obj)) |> fromB) as ##java.util.function.Function))


    pub def apply(f: FunctionZ[a, b, ef], t: a): b \ ef with Marshal[a], Marshal[b] =
        let obj = Interop.Flix.Marshal.toJavaObject(t);
        let FunctionZ(f1) = f;
        let ans = unchecked_cast(f1(obj) as _ \ ef);
        Interop.Flix.Marshal.fromJavaObject(ans)
    


    // pub def andThen(f: Function[a, b], g: Function[b, c]): Function[a, c] = 
    //     import java.util.function.Function.andThen(##java.util.function.Function): ##java.util.function.Function \ {};
    //     andThen(f, g)

    // pub def compose(f: Function[b, c], g: Function[a, b]): Function[a, c] = 
    //     import java.util.function.Function.compose(##java.util.function.Function): ##java.util.function.Function \ {};
    //     let Function(f1) = f;
    //     let Function(g1) = g;
    //     compose(f1, g1) |> Function

}
