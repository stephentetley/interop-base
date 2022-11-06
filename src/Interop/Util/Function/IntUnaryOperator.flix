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
    /// Represents a Java IntUnaryOperator.
    ///
    /// IntUnaryOperator is a builtin functional Interface.
    ///
    pub type alias IntUnaryOperator = ##java.util.function.IntUnaryOperator


}


namespace Interop/Util/Function/IntUnaryOperator {
    
    use Interop/Util/Function.IntUnaryOperator;
    

    pub def makeIntUnaryOperator(f: Int32 -> Int32 \ ef): IntUnaryOperator \ ef = (f as IntUnaryOperator) as \ ef


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
