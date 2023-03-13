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
    /// Represents a Java Predicate.
    ///
    /// Predicate is a builtin functional Interface.
    ///
    pub type alias Predicate[_: Type] = ##java.util.function.Predicate


}


namespace Interop/Util/Function/Predicate {
    
    use Interop/Util/Function.Predicate;
    use Interop/Flix.Marshal

    pub def makePredicate(f: a -> Bool \ ef): Predicate[a] \ ef with Marshal[a] = 
        unchecked_cast(unchecked_cast(obj -> f(Interop/Flix/Marshal.fromJavaObject(obj)) as Predicate[a]) as _ \ ef)




    // pub def andz(f: Predicate, g: Predicate): IntPredicate = 
    //     import java.util.function.Predicate.and(##java.util.function.Predicate): ##java.util.function.Predicate \ {} as and1;
    //     let Predicate(f1) = f;
    //     let Predicate(g1) = g;
    //     and1(f1, g1) |> Predicate

    // pub def orz(f: Predicate, g: Predicate): Predicate = 
    //     import java.util.function.IntPredicate.or(##java.util.function.Predicate): ##java.util.function.Predicate \ {} as or1;
    //     let Predicate(f1) = f;
    //     let Predicate(g1) = g;
    //     or1(f1, g1) |> Predicate

}
