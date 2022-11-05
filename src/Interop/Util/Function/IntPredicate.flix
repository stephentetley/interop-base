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
    /// Represents a Java IntPredicate.
    ///
    pub enum IntPredicate[_: Bool](##java.util.function.IntPredicate)


}


namespace Interop/Util/Function/IntPredicate {
    
    use Interop/Util/Function.IntPredicate;
    use Interop/Util/Function.IntPredicate.{IntPredicate};
    
    pub def getHH(x: IntPredicate[ef]): ##java.util.function.IntPredicate = 
        let IntPredicate(x1) = x;
        x1


    pub def makeIntPredicate(f: Int32 -> Bool \ ef): IntPredicate[ef] = 
        let op1 = i -> f(i) as \ IO;
        IntPredicate(op1)

        
    pub def test(i: Int32, f: IntPredicate[ef]): Bool \ ef = 
        let IntPredicate(f1) = f;
        (f1(i) as \ ef)

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
