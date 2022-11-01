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
    pub enum IntConsumer[_: Bool](##java.util.function.IntConsumer)



}


namespace Interop/Util/Function/IntConsumer {
    
    use Interop/Util/Function.IntConsumer;
    use Interop/Util/Function.IntConsumer.{IntConsumer};
    
    use Interop/Flix.Marshal;

    pub def getHH(x: IntConsumer[ef]): ##java.util.function.IntConsumer = 
        let IntConsumer(x1) = x;
        x1

    pub def makeIntConsumer(f: Int32 -> Unit \ ef): IntConsumer[ef] = 
        let op1 = i -> f(i) as \ IO;
        IntConsumer(op1)


    pub def accept(i: Int32, f: IntConsumer[ef]): Unit \ ef = 
        let IntConsumer(f1) = f;
        (f1(i) as \ ef)

    // /// Result?
    // pub def andThen(f: IntConsumer, g: IntConsumer): IntConsumer = 
    //     import java.util.function.IntConsumer.andThen(##java.util.function.IntConsumer): ##java.util.function.IntConsumer \ {};
    //     let IntConsumer(f1) = f;
    //     let IntConsumer(g1) = g;
    //     andThen(f1, g1) |> IntConsumer

}
