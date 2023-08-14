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
    pub enum BinaryOperator[_: Type, _: Eff](##java.util.function.BinaryOperator)



}


mod Interop.Util.Function.BinaryOperator {
    
    use Interop.Util.Function.BinaryOperator
    use Interop.Util.Function.BinaryOperator.{BinaryOperator}
    use Interop.Flix.GoesToJava
    

    pub def makeBinaryOperator(getter: ##java.lang.Object -> a \ ef1,
                                f: (a, a) -> a \ ef): BinaryOperator[a, ef + ef1] with GoesToJava[a] = 
        let f1 = (o1, o2) -> {
            let a = getter(o1); 
            let b = getter(o2); 
            let ans = f(a, b);
            Interop.Flix.GoesToJava.toJavaObject(ans)
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

    pub def apply(getter: ##java.lang.Object -> a1 \ ef1, t: a, u: a, f: BinaryOperator[a, ef]): a1 \ {ef, ef1} with GoesToJava[a] = 
        import java.util.function.BinaryOperator.apply(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ ef; 
        let BinaryOperator(f1) = f;
        apply(f1, Interop.Flix.GoesToJava.toJavaObject(t), Interop.Flix.GoesToJava.toJavaObject(u)) |> getter


}
