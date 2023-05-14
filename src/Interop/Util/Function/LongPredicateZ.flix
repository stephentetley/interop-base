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



}
