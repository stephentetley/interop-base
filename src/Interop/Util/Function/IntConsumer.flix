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
    /// Represents a Java IntConsumer.
    ///
    /// IntConsumer is a builtin functional Interface.
    ///
    pub type alias IntConsumer = ##java.util.function.IntConsumer



}


namespace Interop/Util/Function/IntConsumer {
    
    use Interop/Util/Function.IntConsumer


    pub def makeIntConsumer(f: Int32 -> Unit \ ef): IntConsumer \ ef = unchecked_cast(f as IntConsumer \ ef)


    // /// Result?
    // pub def andThen(f: IntConsumer, g: IntConsumer): IntConsumer = 
    //     import java.util.function.IntConsumer.andThen(##java.util.function.IntConsumer): ##java.util.function.IntConsumer \ {};
    //     let IntConsumer(f1) = f;
    //     let IntConsumer(g1) = g;
    //     andThen(f1, g1) |> IntConsumer

}
