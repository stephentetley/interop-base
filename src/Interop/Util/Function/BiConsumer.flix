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
    /// Represents a Java BiConsumer.
    ///
    /// BiConsumer is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BiConsumer[_: Type, _: Type, _: Eff](##java.util.function.BiConsumer)

}


mod Interop.Util.Function.BiConsumer {
    
    use Interop.Util.Function.BiConsumer
    use Interop.Util.Function.BiConsumer.{BiConsumer}
    use Interop.Flix.GoesToJava
    use Interop.Flix.ColMarshal



    pub def makeBiConsumer(getterA: ##java.lang.Object -> a \ ef1,
                            getterB: ##java.lang.Object -> b \ ef2, 
                            f: (a, b) -> Unit \ ef): BiConsumer[a, b, ef + ef1 + ef2] = 
        let f1 = (o1, o2) -> {
            let a = getterA(o1); 
            let b = getterB(o2);
            f(a, b)
        };
        BiConsumer(unchecked_cast(new ##java.util.function.BiConsumer {
            def accept(_this: ##java.util.function.BiConsumer, t: ##java.lang.Object, u: ##java.lang.Object): Unit = 
                f1(t, u)
        } as _ \ {}))

        
    pub def accept(t: a, u: b, f: BiConsumer[a, b, ef]): Unit \ ef with GoesToJava[a], GoesToJava[b] = 
        import java.util.function.BiConsumer.accept(##java.lang.Object, ##java.lang.Object): Unit \ ef;
        let BiConsumer(f1) = f;
        accept(f1, Interop.Flix.GoesToJava.toJavaObject(t), Interop.Flix.GoesToJava.toJavaObject(u))

}
