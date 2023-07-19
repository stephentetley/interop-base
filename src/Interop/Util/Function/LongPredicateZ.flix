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
    /// Represents a Java LongPredicate.
    ///
    /// LongPredicate is a builtin functional Interface.
    ///
    pub enum LongPredicateZ[_: Eff](##java.util.function.LongPredicate)


}


mod Interop.Util.Function.LongPredicateZ {
    
    use Interop.Util.Function.LongPredicateZ
    use Interop.Util.Function.LongPredicateZ.{LongPredicateZ}

    pub def makeLongPredicateZ(f: Int64 -> Bool \ ef): LongPredicateZ[ef] = 
        LongPredicateZ(unchecked_cast(f as ##java.util.function.LongPredicate))


    pub def test(i: Int64, f: LongPredicateZ[ef]): Bool \ ef = 
        let LongPredicateZ(f1) = f;
        unchecked_cast(f1(i) as _ \ ef)


    pub def negate(f: LongPredicateZ[ef]): LongPredicateZ[ef] = 
        let LongPredicateZ(f1) = f;
        let fn = i -> not f1(i);
        LongPredicateZ(fn)

    pub def andz(f: LongPredicateZ[ef1], g: LongPredicateZ[ef2]): LongPredicateZ[ef1 + ef2] = 
        let LongPredicateZ(f1) = f;
        let LongPredicateZ(g1) = g;
        let fg = i -> f1(i) and g1(i);
        LongPredicateZ(fg)


    pub def orz(f: LongPredicateZ[ef1], g: LongPredicateZ[ef2]): LongPredicateZ[ef1 + ef2] = 
        let LongPredicateZ(f1) = f;
        let LongPredicateZ(g1) = g;
        let fg = i -> f1(i) or g1(i);
        LongPredicateZ(fg)

}
