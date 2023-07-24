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
    /// Represents a Java IntPredicate.
    ///
    /// IntPredicate is a builtin functional Interface.
    ///
    pub enum IntPredicateZ[_: Eff](##java.util.function.IntPredicate)


}


mod Interop.Util.Function.IntPredicateZ {
    
    use Interop.Util.Function.IntPredicateZ
    use Interop.Util.Function.IntPredicateZ.{IntPredicateZ}

    pub def makeIntPredicateZ(f: Int32 -> Bool \ ef): IntPredicateZ[ef] = 
        let f1 = i -> {
            unchecked_cast(f(i) as _ \ {})
        };
        IntPredicateZ(unchecked_cast(f1 as ##java.util.function.IntPredicate))

    pub def test(i: Int32, f: IntPredicateZ[ef]): Bool \ ef = 
        let IntPredicateZ(f1) = f;
        unchecked_cast(f1(i) as _ \ ef)


    pub def negate(f: IntPredicateZ[ef]): IntPredicateZ[ef] = 
        let IntPredicateZ(f1) = f;
        let fn = i -> not f1(i);
        IntPredicateZ(fn)

    pub def andz(f: IntPredicateZ[ef1], g: IntPredicateZ[ef2]): IntPredicateZ[ef1 + ef2] = 
        let IntPredicateZ(f1) = f;
        let IntPredicateZ(g1) = g;
        let fg = i -> f1(i) and g1(i);
        IntPredicateZ(fg)


    pub def orz(f: IntPredicateZ[ef1], g: IntPredicateZ[ef2]): IntPredicateZ[ef1 + ef2] = 
        let IntPredicateZ(f1) = f;
        let IntPredicateZ(g1) = g;
        let fg = i -> f1(i) or g1(i);
        IntPredicateZ(fg)

}
