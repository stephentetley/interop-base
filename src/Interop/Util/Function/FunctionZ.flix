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
    use Interop.Flix.GoesToJava
    use Interop.Flix.ColMarshal


    pub def makeFunctionZ(getter: ##java.lang.Object -> a \ ef1, f: a -> b \ ef): FunctionZ[a, b, ef + ef1] with GoesToJava[b] = 
        let f1 = obj -> {
            let a = getter(obj); 
            let ans = unchecked_cast(f(a) as _ \ {});
            Interop.Flix.GoesToJava.toJavaObject(ans) 
        };
        FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))

    pub def makeSummaryFinisher[a: Type, b: Type, r: Region, t: Type -> Region -> Type, ef: Eff]
                                (rc: Region[r], f: t[a, r] -> b \ ef): FunctionZ[t[a, r], b, ef] with ColMarshal[t], GoesToJava[b] = 
        let f1 = obj -> {
            let t1 = Interop.Flix.ColMarshal.colFromJavaObject(rc, obj);
            let ans = unchecked_cast(f(t1) as _ \ IO);
            Interop.Flix.GoesToJava.toJavaObject(ans) 
        };
        FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))

    pub def makeCollectionFinisher[a: Type, r: Region, t: Type -> Region -> Type, ef: Eff]
                                    (rc: Region[r], f: t[a, r] -> t[a, r] \ ef): FunctionZ[t[a, r], t[a, r], ef] with ColMarshal[t], GoesToJava[t[a,r]], GoesToJava[a] = 
        let f1 = obj -> {
            let t1 = Interop.Flix.ColMarshal.colFromJavaObject(rc, obj);
            let ans = unchecked_cast(f(t1) as _ \ IO);
            Interop.Flix.GoesToJava.toJavaObject(ans) 
        };
        FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))



    pub def makeFunctionZWith(f: a -> b \ ef, toA: ##java.lang.Object -> a, fromB: b -> ##java.lang.Object): FunctionZ[a, b, ef] = 
        FunctionZ(unchecked_cast((obj -> f(toA(obj)) |> fromB) as ##java.util.function.Function))


    pub def apply(getter: ##java.lang.Object -> b1 \ ef1, f: FunctionZ[a, b, ef], t: a): b1 \ {ef, ef1} with GoesToJava[a] =
        let obj = Interop.Flix.GoesToJava.toJavaObject(t);
        let FunctionZ(f1) = f;
        let ans = unchecked_cast(f1(obj) as _ \ ef);
        getter(ans)
    

    pub def andThen(f: FunctionZ[a, b, ef], g: FunctionZ[b, c, ef1]): FunctionZ[a, c, ef + ef1] = 
        let FunctionZ(f1) = f;
        let FunctionZ(g1) = g;
        let fg1 = obj -> {let b = g1(obj); f1(b)};
        FunctionZ(unchecked_cast((obj -> fg1(obj)) as ##java.util.function.Function))


    pub def compose(f: FunctionZ[b, c, ef1], g: FunctionZ[a, b, ef]): FunctionZ[a, c, ef + ef1] = 
        let FunctionZ(f1) = f;
        let FunctionZ(g1) = g;
        let fg1 = obj -> {let b = g1(obj); f1(b)};
        FunctionZ(unchecked_cast((obj -> fg1(obj)) as ##java.util.function.Function))

}
