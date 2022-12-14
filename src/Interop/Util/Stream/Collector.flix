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

namespace Interop/Util/Stream {


    ///
    /// Represents a Java Collector.
    ///
    pub type alias Collector[_: Type, _: Type, _: Type] = ##java.util.stream.Collector



}


namespace Interop/Util/Stream/Collector {
    
    use Interop/Util/Stream.Collector
    use Interop/Util/Function.BiConsumer
    use Interop/Util/Function.BinaryOperator
    use Interop/Util/Function.Function
    use Interop/Util/Function.Supplier
    use Interop/Flix.Marshal


    pub def of5(supplier: Supplier[a], 
                accumulator: BiConsumer[a, t],
                combiner: BinaryOperator[a],
                finisher: Function[a, ans], 
                characteristics: Array[##java.util.stream.Collector$Characteristics, r]): Collector[t, a, ans] \ Read(r) = 
        import static java.util.stream.Collector.of(##java.util.function.Supplier, 
                                                    ##java.util.function.BiConsumer,
                                                    ##java.util.function.BinaryOperator, 
                                                    ##java.util.function.Function,
                                                    Array[##java.util.stream.Collector$Characteristics, r]): ##java.util.stream.Collector \ r;
        of(supplier, accumulator, combiner, finisher, characteristics)

    // /// TODO Supplier should be mutable...
    // pub def supplier(c: Collector[t, a, ans]): Supplier[a] \ Read(r) =
    //     import java.util.stream.Collector.supplier(): ##java.util.function.Supplier \ r;
    //     let Collector(c1) = c;
    //     supplier(c1)


}
