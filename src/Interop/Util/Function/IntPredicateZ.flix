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
    pub enum IntPredicateZ[_: Bool](##java.util.function.IntPredicate)


}


mod Interop.Util.Function.IntPredicateZ {
    
    use Interop.Util.Function.IntPredicateZ
    use Interop.Util.Function.IntPredicateZ.{IntPredicateZ}

    pub def makeIntPredicateZ(f: Int32 -> Bool \ ef): IntPredicateZ[ef] = 
        IntPredicateZ(unchecked_cast(f as ##java.util.function.IntPredicate))



    // pub def negate(f: IntPredicate): IntPredicate = 
    //     import java.util.function.IntPredicate.negate(): ##java.util.function.IntPredicate \ {};
    //     let IntPredicate(f1) = f;
    //     negate(f1) |> IntPredicate

    // pub def andz(f: IntPredicate, g: IntPredicate): IntPredicate = 
    //     import java.util.function.IntPredicate.and(##java.util.function.IntPredicate): ##java.util.function.IntPredicate \ {} as and1;
    //     let IntPredicate(f1) = f;
    //     let IntPredicate(g1) = g;
    //     and1(f1, g1) |> IntPredicate

    // pub def orz(f: IntPredicate, g: IntPredicate): IntPredicate = 
    //     import java.util.function.IntPredicate.or(##java.util.function.IntPredicate): ##java.util.function.IntPredicate \ {} as or1;
    //     let IntPredicate(f1) = f;
    //     let IntPredicate(g1) = g;
    //     or1(f1, g1) |> IntPredicate

}
