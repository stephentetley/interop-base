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
    /// Represents a Java DoubleConsumer.
    ///
    /// DoubleConsumer is a builtin functional Interface.
    ///
    pub enum DoubleConsumerZ[_: Bool](##java.util.function.DoubleConsumer)



}


mod Interop.Util.Function.DoubleConsumerZ {
    
    use Interop.Util.Function.DoubleConsumerZ
    use Interop.Util.Function.DoubleConsumerZ.DoubleConsumerZ

    pub def makeDoubleConsumerZ(f: Float64 -> Unit \ ef): DoubleConsumerZ[ef] = 
        DoubleConsumerZ(unchecked_cast(f as ##java.util.function.DoubleConsumer))


}
