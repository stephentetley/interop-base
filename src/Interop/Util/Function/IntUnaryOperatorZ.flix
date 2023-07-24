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
    /// Represents a Java IntUnaryOperator.
    ///
    /// IntUnaryOperator is a builtin functional Interface.
    ///
    pub enum IntUnaryOperatorZ[_: Eff](##java.util.function.IntUnaryOperator)


}


mod Interop.Util.Function.IntUnaryOperatorZ {
    
    use Interop.Util.Function.IntUnaryOperatorZ;
    

    pub def makeIntUnaryOperatorZ(f: Int32 -> Int32 \ ef): IntUnaryOperatorZ[ef] = 
        let f1 = i -> {
            unchecked_cast(f(i) as _ \ {})
        };
        IntUnaryOperatorZ(unchecked_cast(f1 as ##java.util.function.IntUnaryOperator))


    // pub def identity(): IntUnaryOperator = 
    //     import static java.util.function.IntUnaryOperator.identity(): ##java.util.function.IntUnaryOperator \ {};
    //     identity() |> IntUnaryOperator

    // pub def andThen(f: IntUnaryOperator, g: IntUnaryOperator): IntUnaryOperator = 
    //     import java.util.function.IntUnaryOperator.andThen(##java.util.function.IntUnaryOperator): ##java.util.function.IntUnaryOperator \ {};
    //     let IntUnaryOperator(f1) = f;
    //     let IntUnaryOperator(g1) = g;
    //     andThen(f1, g1) |> IntUnaryOperator

    // pub def compose(f: IntUnaryOperator, g: IntUnaryOperator): IntUnaryOperator = 
    //     import java.util.function.IntUnaryOperator.compose(##java.util.function.IntUnaryOperator): ##java.util.function.IntUnaryOperator \ {};
    //     let IntUnaryOperator(f1) = f;
    //     let IntUnaryOperator(g1) = g;
    //     compose(f1, g1) |> IntUnaryOperator

}
