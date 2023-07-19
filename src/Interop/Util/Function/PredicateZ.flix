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
    /// Represents a Java Predicate.
    ///
    /// Predicate is a builtin functional Interface.
    ///
    pub enum PredicateZ[_: Type, _: Eff](##java.util.function.Predicate)


}


mod Interop.Util.Function.PredicateZ {
    
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava

    pub def makePredicateZ(f: a -> Bool \ ef): PredicateZ[a, ef] with ComesFromJava[a] = 
        PredicateZ(unchecked_cast(obj -> f(Interop.Flix.ComesFromJava.fromJavaObject(obj)) as ##java.util.function.Predicate))



    pub def test(x: a, f: PredicateZ[a, ef]): Bool \ ef with GoesToJava[a] =  
        let PredicateZ(f1) = f;
        unchecked_cast(f1(Interop.Flix.GoesToJava.toJavaObject(x)) as _ \ ef)

    pub def negate(f: PredicateZ[a, ef]): PredicateZ[a, ef] with GoesToJava[a] = 
        let PredicateZ(f1) = f;
        let fn = x -> not f1(Interop.Flix.GoesToJava.toJavaObject(x));
        PredicateZ(fn)


    pub def andz(f: PredicateZ[a, ef1], g: PredicateZ[a, ef2]): PredicateZ[a, ef1 + ef2] = 
        let PredicateZ(f1) = f;
        let PredicateZ(g1) = g;
        let fg = x -> {let obj = Interop.Flix.GoesToJava.toJavaObject(x); f1(obj) and g1(obj)};
        PredicateZ(fg)


    pub def orz(f: PredicateZ[a, ef1], g: PredicateZ[a, ef2]): PredicateZ[a, ef1 + ef2] = 
        let PredicateZ(f1) = f;
        let PredicateZ(g1) = g;
        let fg = x -> {let obj = Interop.Flix.GoesToJava.toJavaObject(x); f1(obj) or g1(obj)};
        PredicateZ(fg)

}
