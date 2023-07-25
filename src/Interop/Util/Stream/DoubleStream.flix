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
    /// Represents a Java DoubleStream.
    ///
    pub enum DoubleStream[_: Eff, r: Region] { 
        case DoubleStream(Region[r], ##java.util.stream.DoubleStream)
    }


}


mod Interop.Util.Stream.DoubleStream {
    
    use Interop.Util.Stream.DoubleStream
    use Interop.Util.Stream.DoubleStream.{DoubleStream}
    use Interop.Util.Stream.Stream
    use Interop.Util.Stream.Stream.{Stream}
    use Interop.Util.DoubleSummaryStatistics
    use Interop.Util.DoubleSummaryStatistics.{DoubleSummaryStatistics}
    use Interop.Util.OptionalDouble
    use Interop.Util.OptionalDouble.{OptionalDouble}
    use Interop.Util.Function.DoubleConsumerZ
    use Interop.Util.Function.DoubleConsumerZ.{DoubleConsumerZ}
    use Interop.Util.Function.DoubleFunctionZ
    use Interop.Util.Function.DoubleFunctionZ.{DoubleFunctionZ}
    use Interop.Util.Function.DoublePredicateZ
    use Interop.Util.Function.DoublePredicateZ.{DoublePredicateZ}
    use Interop.Util.Function.DoubleSupplier
    use Interop.Util.Function.DoubleSupplier.{DoubleSupplier}
    use Interop.Util.Function.DoubleUnaryOperatorZ
    use Interop.Util.Function.DoubleUnaryOperatorZ.{DoubleUnaryOperatorZ}
    

    pub def getHH(x: DoubleStream[ef, r]): ##java.util.stream.DoubleStream = 
        let DoubleStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.DoubleStream): DoubleStream[ef, r] = DoubleStream(rc, prim)


    pub def doubleStreamIterator(rc: Region[r1], s: DoubleStream[ef, r]): Iterator[Int64, ef + r + r1, r1] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {} as mkIterator;
        let DoubleStream(_, s1) = s;
        let iter1 = mkIterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let iter2 = checked_ecast(Interop.Util.IteratorZ.wrapHH(rc, iter1));
        Interop.Util.IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.empty(): ##java.util.stream.DoubleStream \ {};
        DoubleStream(rc, checked_ecast(empty()))

    pub def ofFloat64(rc: Region[r], i: Float64): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.of(Float64): ##java.util.stream.DoubleStream \ {};
        DoubleStream(rc, checked_ecast(of(i)))

    pub def ofArray(rc: Region[r1], arr: Array[Float64, r]): DoubleStream[ef, r1] = 
        import static java.util.stream.DoubleStream.of(Array[Float64, r]): ##java.util.stream.DoubleStream \ {};
        DoubleStream(rc, checked_ecast(of(arr)))

    pub def ofVector(rc: Region[r], v: Vector[Float64]): DoubleStream[ef + r, r] \ r =  
        import static java.util.stream.DoubleStream.of(Array[Float64, r]): ##java.util.stream.DoubleStream \ {};
        let arr = Vector.toArray(rc, v);
        DoubleStream(rc, checked_ecast(of(arr)))

    pub def iterate(rc: Region[r], seed: Float64, f: DoubleUnaryOperatorZ[ef]): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.iterate(Float64, ##java.util.function.DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {};
        let DoubleUnaryOperatorZ(f1) = f;
        DoubleStream(rc, checked_ecast(iterate(seed, f1)))

    pub def generate(rc: Region[r], f: DoubleSupplier[ef]): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.generate(##java.util.function.DoubleSupplier): ##java.util.stream.DoubleStream \ {};
        let DoubleSupplier(s1) = f;
        DoubleStream(rc, generate(s1))


    pub def boxed(rc: Region[r1], s: DoubleStream[ef, r]): Stream[##java.lang.Double, ef, r1] = 
        import java.util.stream.DoubleStream.boxed(): ##java.util.stream.Stream \ {};
        let DoubleStream(_, s1) = s;
        Stream(rc, checked_ecast(boxed(s1)))

    pub def count(s: DoubleStream[ef, r]): Int64 \ {ef, r} = 
        import java.util.stream.DoubleStream.count(): Int64 \ {ef, r};
        let DoubleStream(_, s1) = s;
        count(s1)

    pub def concat(s: DoubleStream[ef1, r], t: DoubleStream[ef2, r]): DoubleStream[ef1 + ef2, r] = 
        import static java.util.stream.DoubleStream.concat(##java.util.stream.DoubleStream, ##java.util.stream.DoubleStream): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let DoubleStream(_, t1) = t;
        DoubleStream(rc, checked_ecast(concat(s1, t1)))


    pub def filter(p: DoublePredicateZ[ef1], s: DoubleStream[ef, r]): DoubleStream[ef + ef1, r] = 
        import java.util.stream.DoubleStream.filter(##java.util.function.DoublePredicate): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let DoublePredicateZ(p1) = p;
        DoubleStream(rc, filter(s1, p1))

    pub def dropWhile(p: DoublePredicateZ[ef1], s: DoubleStream[ef, r]): DoubleStream[ef + ef1, r] = 
        import java.util.stream.DoubleStream.dropWhile(##java.util.function.DoublePredicate): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let DoublePredicateZ(p1) = p;
        DoubleStream(rc, dropWhile(s1, p1))

    pub def limit(size: Int64, s: DoubleStream[ef, r]): DoubleStream[ef, r] = 
        import java.util.stream.DoubleStream.limit(Int64): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        DoubleStream(rc, checked_ecast(limit(s1, size)))

    pub def map(f: DoubleUnaryOperatorZ[ef1], s: DoubleStream[ef, r]): DoubleStream[ef + ef1, r] = 
        import java.util.stream.DoubleStream.map(##java.util.function.DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let DoubleUnaryOperatorZ(f1) = f;
        DoubleStream(rc, checked_ecast(map(s1, f1)))

    pub def flatMap(f: DoubleFunctionZ[DoubleStream[ef, r], ef], s: DoubleStream[ef, r]): DoubleStream[ef, r] = 
        import java.util.stream.DoubleStream.flatMap(##java.util.function.DoubleFunction): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let DoubleFunctionZ(f1) = f;
        DoubleStream(rc, checked_ecast(flatMap(s1, f1)))


    pub def forEach(f: DoubleConsumerZ[ef1], s: DoubleStream[ef, r]): Unit \ {ef, ef1, r} = 
        import java.util.stream.DoubleStream.forEach(##java.util.function.DoubleConsumer): Unit \ {ef, ef1, r};
        let DoubleConsumerZ(f1) = f;
        let DoubleStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(s: DoubleStream[ef, r]): Array[Float64, r] \ r = 
        import java.util.stream.DoubleStream.toArray(): Array[Float64, r] \ r;
        let DoubleStream(_, s1) = s;
        toArray(s1)


    pub def average(s: DoubleStream[ef, r]): OptionalDouble \ r = 
        import java.util.stream.DoubleStream.average(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: DoubleStream[ef, r]): DoubleSummaryStatistics[r1] \ { ef, r, r1 } = 
        import java.util.stream.DoubleStream.summaryStatistics(): ##java.util.DoubleSummaryStatistics \ { ef, r, r1 };
        let DoubleStream(_, s1) = s;
        DoubleSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch(f: DoublePredicateZ[ef1], s: DoubleStream[ef, r]): Bool \ {ef, ef1, r} = 
        import java.util.stream.DoubleStream.anyMatch(##java.util.function.DoublePredicate): Bool \ {ef, ef1, r};
        let DoubleStream(_, s1) = s;
        let DoublePredicateZ(f1) = f;
        anyMatch(s1, f1)

    pub def allMatch(f: DoublePredicateZ[ef1], s: DoubleStream[ef, r]): Bool \ {ef, ef1, r} = 
        import java.util.stream.DoubleStream.allMatch(##java.util.function.DoublePredicate): Bool \ {ef, ef1, r};
        let DoubleStream(_, s1) = s;
        let DoublePredicateZ(f1) = f;
        allMatch(s1, f1)


    pub def noneMatch(f: DoublePredicateZ[ef1], s: DoubleStream[ef, r]): Bool \ {ef, ef1, r} = 
        import java.util.stream.DoubleStream.noneMatch(##java.util.function.DoublePredicate): Bool \ {ef, ef1, r};
        let DoubleStream(_, s1) = s;
        let DoublePredicateZ(f1) = f;
        noneMatch(s1, f1)


    pub def findFirst(s: DoubleStream[ef, r]): Option[Float64] \ {ef, r} = 
        import java.util.stream.DoubleStream.findFirst(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        findFirst(s1) |> Interop.Util.OptionalDouble.hhToOption

    pub def findAny(s: DoubleStream[ef, r]): Option[Float64] \ {ef, r} = 
        import java.util.stream.DoubleStream.findAny(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        findAny(s1) |> Interop.Util.OptionalDouble.hhToOption

    pub def max(s: DoubleStream[ef, r]): Option[Float64] \ {ef, r} = 
        import java.util.stream.DoubleStream.max(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        max(s1) |> Interop.Util.OptionalDouble.hhToOption

    pub def min(s: DoubleStream[ef, r]): Option[Float64] \ {ef, r} = 
        import java.util.stream.DoubleStream.min(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        min(s1) |> Interop.Util.OptionalDouble.hhToOption

    pub def sorted(s: DoubleStream[ef, r]): DoubleStream[ef, r] = 
        import java.util.stream.DoubleStream.sorted(): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        DoubleStream(rc, checked_ecast(sorted(s1)))
        
}
