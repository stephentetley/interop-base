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
    pub enum PredicateZ[_: Type, _: Bool](##java.util.function.Predicate)


}


mod Interop.Util.Function.PredicateZ {
    
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.Marshal

    pub def makePredicateZ(f: a -> Bool \ ef): PredicateZ[a, ef] with Marshal[a] = 
        PredicateZ(unchecked_cast(obj -> f(Interop.Flix.Marshal.fromJavaObject(obj)) as ##java.util.function.Predicate))




    // pub def andz(f: Predicate, g: Predicate): Predicate = 
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
