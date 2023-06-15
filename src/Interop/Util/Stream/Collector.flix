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

mod Interop.Util.Stream {


    ///
    /// Represents a Java Collector.
    ///
    pub enum Collector[_a: Type, _t: Type, _r: Type] {
        case Collector(##java.util.stream.Collector)
    }


}


mod Interop.Util.Stream.Collector {
    
    use Interop.Util.Stream.Collector
    use Interop.Util.Stream.Collector.{Collector}
    use Interop.Util.Function.BiConsumer
    use Interop.Util.Function.BiConsumer.{BiConsumer}
    use Interop.Util.Function.BinaryOperator
    use Interop.Util.Function.BinaryOperator.{BinaryOperator}
    use Interop.Util.Function.FunctionZ
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Util.Function.Supplier
    use Interop.Util.Function.Supplier.{Supplier}
    use Interop.Flix.Marshal


    pub def of5(supplier: Supplier[a, ef1], 
                accumulator: BiConsumer[a, t, ef2],
                combiner: BinaryOperator[a, ef3],
                finisher: FunctionZ[a, ans, ef4], 
                characteristics: Array[##java.util.stream.Collector$Characteristics, r]): Collector[t, a, ans] \ {ef1, ef2, ef3, ef4, r} = 
        import static java.util.stream.Collector.of(##java.util.function.Supplier, 
                                                    ##java.util.function.BiConsumer,
                                                    ##java.util.function.BinaryOperator, 
                                                    ##java.util.function.Function,
                                                    Array[##java.util.stream.Collector$Characteristics, r]): ##java.util.stream.Collector \ {ef1, ef2, ef3, ef4, r};
        let Supplier(supplier1) = supplier;
        let BiConsumer(accumulator1) = accumulator;
        let BinaryOperator(combiner1) = combiner;
        let FunctionZ(finisher1) = finisher;
        Collector(of(supplier1, accumulator1, combiner1, finisher1, characteristics))

    // /// TODO Supplier should be mutable...
    // pub def supplier(c: Collector[t, a, ans]): Supplier[a] \ r =
    //     import java.util.stream.Collector.supplier(): ##java.util.function.Supplier \ r;
    //     let Collector(c1) = c;
    //     supplier(c1)


}
