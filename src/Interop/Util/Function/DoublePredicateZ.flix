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
    /// Represents a Java DoublePredicate.
    ///
    /// DoublePredicate is a builtin functional Interface.
    ///
    pub enum DoublePredicateZ[_: Eff](##java.util.function.DoublePredicate)


}


mod Interop.Util.Function.DoublePredicateZ {
    
    use Interop.Util.Function.DoublePredicateZ
    use Interop.Util.Function.DoublePredicateZ.{DoublePredicateZ}

    pub def makeDoublePredicateZ(f: Float64 -> Bool \ ef): DoublePredicateZ[ef] = 
        DoublePredicateZ(unchecked_cast(f as ##java.util.function.DoublePredicate))


    pub def test(d: Float64, f: DoublePredicateZ[ef]): Bool \ ef = 
        let DoublePredicateZ(f1) = f;
        unchecked_cast(f1(d) as _ \ ef)


    pub def negate(f: DoublePredicateZ[ef]): DoublePredicateZ[ef] = 
        let DoublePredicateZ(f1) = f;
        let fn = i -> not f1(i);
        DoublePredicateZ(fn)

    pub def andz(f: DoublePredicateZ[ef1], g: DoublePredicateZ[ef2]): DoublePredicateZ[ef1 + ef2] = 
        let DoublePredicateZ(f1) = f;
        let DoublePredicateZ(g1) = g;
        let fg = i -> f1(i) and g1(i);
        DoublePredicateZ(fg)


    pub def orz(f: DoublePredicateZ[ef1], g: DoublePredicateZ[ef2]): DoublePredicateZ[ef1 + ef2] = 
        let DoublePredicateZ(f1) = f;
        let DoublePredicateZ(g1) = g;
        let fg = i -> f1(i) or g1(i);
        DoublePredicateZ(fg)

}
