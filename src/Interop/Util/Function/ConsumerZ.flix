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
    /// Represents a Java Consumer.
    ///
    /// Consumer is a builtin functional Interface.
    ///
    pub enum ConsumerZ[_: Type, _: Eff](##java.util.function.Consumer)



}


mod Interop.Util.Function.ConsumerZ {
    
    use Interop.Util.Function.ConsumerZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Flix.ComesFromJava


    pub def makeConsumerZ(f: a -> Unit \ ef): ConsumerZ[a, ef] with ComesFromJava[a] = 
        ConsumerZ(unchecked_cast((Interop.Flix.ComesFromJava.fromJavaObject >> f) as ##java.util.function.Consumer))

    pub def makeConsumerZ1(fromObject: ##java.lang.Object -> a, f: a -> Unit \ ef): ConsumerZ[a, ef] = 
        let f1 = obj -> {
            let a = fromObject(obj); 
            unchecked_cast(f(a) as _ \ {})
        };
        ConsumerZ(unchecked_cast(f1 as ##java.util.function.Consumer))

    // /// Result?
    // pub def andThen(f: Consumer, g: Consumer): Consumer = 
    //     import java.util.function.Consumer.andThen(##java.util.function.Consumer): ##java.util.function.Consumer \ {};
    //     let IntConsumer(f1) = f;
    //     let IntConsumer(g1) = g;
    //     andThen(f1, g1) |> IntConsumer

}
