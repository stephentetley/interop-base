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
    /// Represents a Java BiConsumer.
    ///
    /// BiConsumer is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BiConsumer[_: Type, _: Type, _: Bool](##java.util.function.BiConsumer)

}


namespace Interop/Util/Function/BiConsumer {
    
    use Interop/Util/Function.BiConsumer
    use Interop/Util/Function.BiConsumer.{BiConsumer}
    use Interop/Flix.Marshal
    use Interop/Flix.MutMarshal



    pub def makeBiConsumer(f: (a, b) -> Unit \ ef): BiConsumer[a, b, ef] with Marshal[a], Marshal[b] = 
        let f1 = (o1, o2) -> {
            let a = Interop/Flix/Marshal.fromJavaObject(o1); 
            let b = Interop/Flix/Marshal.fromJavaObject(o2);
            f(a, b)
        };
        BiConsumer(unchecked_cast(new ##java.util.function.BiConsumer {
            def accept(_this: ##java.util.function.BiConsumer, t: ##java.lang.Object, u: ##java.lang.Object): Unit = 
                f1(t, u)
        } as _ \ {}))


    /// Collector imposes arg order: collection * element
    pub def makeAccumulator[a: Type, r: Region, t: Type -> Region -> Type, ef: Bool]
                            (r: Region[r], f: (t[a, r], a) -> Unit \ ef): BiConsumer[t[a, r], a, ef] with Marshal[a], MutMarshal[t] = 
        let f1 = (o1, o2) -> {
            let t = Interop/Flix/MutMarshal.mmFromJavaObject(r, o1); 
            let a = Interop/Flix/Marshal.fromJavaObject(o2);
            f(t, a)
        };
        BiConsumer(unchecked_cast(new ##java.util.function.BiConsumer {
            def accept(_this: ##java.util.function.BiConsumer, t: ##java.lang.Object, u: ##java.lang.Object): Unit = 
                f1(t, u)
        } as _ \ {}))


    pub def makeBiConsumer2(f: (a, b) -> Unit \ ef, 
                            castToA: ##java.lang.Object -> a,
                            castToB: ##java.lang.Object -> b): BiConsumer[a, b, ef] = 
        let f1 = (o1, o2) -> {
            let a = castToA(o1); 
            let b = castToB(o2);
            f(a, b)
        };
        BiConsumer(unchecked_cast(new ##java.util.function.BiConsumer {
            def accept(_this: ##java.util.function.BiConsumer, t: ##java.lang.Object, u: ##java.lang.Object): Unit = 
                f1(t, u)
        } as _ \ {}))

        
    pub def accept(t: a, u: b, f: BiConsumer[a, b, ef]): Unit \ ef with Marshal[a], Marshal[b] = 
        import java.util.function.BiConsumer.accept(##java.lang.Object, ##java.lang.Object): Unit \ ef;
        let BiConsumer(f1) = f;
        accept(f1, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u))

}
