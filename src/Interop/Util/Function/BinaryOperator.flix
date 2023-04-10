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
    /// Represents a Java BinaryOperator.
    ///
    /// BinaryOperator is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BinaryOperator[_: Type, _: Bool](##java.util.function.BinaryOperator)



}


mod Interop.Util.Function.BinaryOperator {
    
    use Interop.Util.Function.BinaryOperator
    use Interop.Util.Function.BinaryOperator.{BinaryOperator}
    use Interop.Flix.Marshal
    use Interop.Flix.MutMarshal
    

    pub def makeBinaryOperator(f: (a, a) -> a \ ef): BinaryOperator[a, ef] with Marshal[a] = 
        let f1 = (o1, o2) -> {
            let a = Interop.Flix.Marshal.fromJavaObject(o1); 
            let b = Interop.Flix.Marshal.fromJavaObject(o2); 
            let ans = f(a, b);
            Interop.Flix.Marshal.toJavaObject(ans)
        };
        BinaryOperator(unchecked_cast(new ##java.util.function.BinaryOperator {
            def apply(_this: ##java.util.function.BinaryOperator, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as _ \ {}))


    pub def makeCombiner[a: Type, r: Region, t: Type -> Region -> Type, ef: Bool]
                        (r: Region[r], f: (t[a, r], t[a, r]) -> t[a, r] \ef): BinaryOperator[t[a, r], ef] with MutMarshal[t] = 
        let f1 = (o1, o2) -> {
            let a = Interop.Flix.MutMarshal.mmFromJavaObject(r, o1); 
            let b = Interop.Flix.MutMarshal.mmFromJavaObject(r, o2); 
            let ans = f(a, b);
            Interop.Flix.MutMarshal.mmToJavaObject(ans)
        };
        BinaryOperator(unchecked_cast(new ##java.util.function.BinaryOperator {
            def apply(_this: ##java.util.function.BinaryOperator, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as _ \ {}))

    pub def makeBinaryOperator2(f: (a, a) -> a \ ef, castToObj: a -> ##java.lang.Object, castToA: ##java.lang.Object -> a): BinaryOperator[a, ef] = 
        let f1 = (o1, o2) -> {
            let a = castToA(o1); 
            let b = castToA(o2); 
            let ans = f(a, b);
            castToObj(ans)
        };
        BinaryOperator(unchecked_cast(new ##java.util.function.BinaryOperator {
            def apply(_this: ##java.util.function.BinaryOperator, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as _ \ {}))

    pub def apply(t: a, u: a, f: BinaryOperator[a, ef]): a \ ef with Marshal[a] = 
        import java.util.function.BinaryOperator.apply(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ ef;        
        let BinaryOperator(f1) = f;
        apply(f1, Interop.Flix.Marshal.toJavaObject(t), Interop.Flix.Marshal.toJavaObject(u)) |> Interop.Flix.Marshal.fromJavaObject


}
