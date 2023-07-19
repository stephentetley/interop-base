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
    /// Represents a Java IntConsumer.
    ///
    /// IntConsumer is a builtin functional Interface.
    ///
    pub enum IntConsumerZ[_: Eff](##java.util.function.IntConsumer)



}


mod Interop.Util.Function.IntConsumerZ {
    
    use Interop.Util.Function.IntConsumerZ
    use Interop.Util.Function.IntConsumerZ.{IntConsumerZ}


    pub def makeIntConsumerZ(f: Int32 -> Unit \ ef): IntConsumerZ[ef] = 
        IntConsumerZ(unchecked_cast(f as ##java.util.function.IntConsumer))

    pub def accept(i: Int32, f: IntConsumerZ[ef]): Unit \ ef = 
        let IntConsumerZ(f1) = f;
        unchecked_cast(f1(i) as Unit \ ef)


    pub def andThen(f: IntConsumerZ[ef1], g: IntConsumerZ[ef2]): IntConsumerZ[ef1 + ef2] = 
        let IntConsumerZ(f1) = f;
        let IntConsumerZ(g1) = g;
        let fg = n -> {f1(n); g1(n)};
        IntConsumerZ(fg)

}
