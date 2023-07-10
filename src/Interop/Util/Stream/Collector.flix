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
    /// Collector contains an Effect as it is an amalgamation of functions...
    /// TODO - separate effects for supplier, accumulator, combiner and finisher?
    ///
    pub enum Collector[_a: Type, _t: Type, _ef: Eff, _ans: Type] {
        case Collector(##java.util.stream.Collector)
    }


}


mod Interop.Util.Stream.Collector {
    
    use Interop.Util.Stream.Collector
    use Interop.Util.Stream.Collector.{Collector}
    use Interop.Util.Stream.CollectorCharacteristics
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
                characteristics: Vector[CollectorCharacteristics]): Collector[t, a, ef1 + ef2 + ef3 + ef4, ans] = 
        region rc {
            import static java.util.stream.Collector.of(##java.util.function.Supplier, 
                                                    ##java.util.function.BiConsumer,
                                                    ##java.util.function.BinaryOperator, 
                                                    ##java.util.function.Function,
                                                    Array[##java.util.stream.Collector$Characteristics, rc]): ##java.util.stream.Collector \ rc;
            let Supplier(supplier1) = supplier;
            let BiConsumer(accumulator1) = accumulator;
            let BinaryOperator(combiner1) = combiner;
            let FunctionZ(finisher1) = finisher;
            let characteristics1 = Vector.map(Interop.Util.Stream.CollectorCharacteristics.getHH, characteristics) |> Vector.toArray(rc);
            Collector(of(supplier1, accumulator1, combiner1, finisher1, characteristics1))
        } 

    pub def characteristics(c: Collector[t, a, ef, ans]): Vector[CollectorCharacteristics] = region rc {
        import java.util.stream.Collector.characteristics(): ##java.util.Set \ {};
        let Collector(c1) = c;
        characteristics(c1) |> Interop.Util.SetZ.wrapHH(rc) |> Interop.Util.SetZ.toFlixVector
    }

    pub def supplier(c: Collector[t, a, ef, ans]): Supplier[a, ef] =
        import java.util.stream.Collector.supplier(): ##java.util.function.Supplier \ {};
        let Collector(c1) = c;
        Supplier(supplier(c1))

    pub def accumulator(c: Collector[t, a, ef, ans]): BiConsumer[a, t, ef] =
        import java.util.stream.Collector.accumulator(): ##java.util.function.BiConsumer \ {};
        let Collector(c1) = c;
        BiConsumer(accumulator(c1))

    pub def combiner(c: Collector[t, a, ef, ans]): BinaryOperator[a, ef] =
        import java.util.stream.Collector.combiner(): ##java.util.function.BinaryOperator \ {};
        let Collector(c1) = c;
        BinaryOperator(combiner(c1))        

    pub def finisher(c: Collector[t, a, ef, ans]): FunctionZ[a, ans, ef] =
        import java.util.stream.Collector.finisher(): ##java.util.function.Function \ {};
        let Collector(c1) = c;
        FunctionZ(finisher(c1))  

    pub def mapFinisher(f1: FunctionZ[ans, ans1, ef1],
                        c: Collector[t, a, ef, ans]): Collector[t, a, ef + ef1, ans1] =
        let sf = supplier(c);
        let af = accumulator(c);
        let cf = combiner(c);
        let ff = finisher(c);
        let chars = characteristics(c);
        of5(sf, af, cf, Interop.Util.Function.FunctionZ.andThen(ff, f1), chars)

    pub def mapFinisher1(f: ans -> ans1 \ ef1, 
                        c: Collector[t, a, ef, ans]): Collector[t, a, ef + ef1, ans1] with Marshal[ans], Marshal[ans1] =
        let sf = supplier(c);
        let af = accumulator(c);
        let cf = combiner(c);
        let ff = finisher(c);
        let chars = characteristics(c);
        of5(sf, af, cf, Interop.Util.Function.FunctionZ.andThen(ff, Interop.Util.Function.FunctionZ.makeFunctionZ(f)), chars)

}
