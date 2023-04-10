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
    /// Represents a Java BiPredicate.
    ///
    /// BiPredicate is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BiPredicate[_: Type, _: Type, _: Bool](##java.util.function.BiPredicate)

}


mod Interop.Util.Function.BiPredicate {
    
    use Interop.Util.Function.BiPredicate
    use Interop.Flix.Marshal


    pub def makeBiPredicate(f: (a, b) -> Bool \ ef): BiPredicate[a, b, ef] with Marshal[a], Marshal[b] = 
        let f1 = (o1, o2) -> {
            let a = Interop.Flix.Marshal.fromJavaObject(o1); 
            let b = Interop.Flix.Marshal.fromJavaObject(o2);
            f(a, b)
        };
        BiPredicate(unchecked_cast(new ##java.util.function.BiPredicate {
            def test(_this: ##java.util.function.BiPredicate, t: ##java.lang.Object, u: ##java.lang.Object): Bool = 
                f1(t, u)
        } as _ \ {}))


        
    pub def test(t: a, u: b, f: BiPredicate[a, b, ef]): Bool \ ef with Marshal[a], Marshal[b] = 
        import java.util.function.BiPredicate.test(##java.lang.Object, ##java.lang.Object): Bool \ ef;
        let BiPredicate(f1) = f;
        test(f1, Interop.Flix.Marshal.toJavaObject(t), Interop.Flix.Marshal.toJavaObject(u))

}
