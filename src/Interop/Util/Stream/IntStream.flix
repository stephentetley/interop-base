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
    /// Represents a Java IntStream.
    ///
    pub enum IntStream[_r: Region](##java.util.stream.IntStream)

    instance Scoped[IntStream] {
        pub def regionOf(_: IntStream[r]): Region[r] = () as Region[r]
    }


}


namespace Interop/Util/Stream/IntStream {
    
    use Interop/Util/Stream.IntStream;
    use Interop/Util/Stream.IntStream.{IntStream};
    use Interop/Util/Stream.DoubleStream;
    use Interop/Util/Stream.DoubleStream.{DoubleStream};
    use Interop/Util/Stream.LongStream;
    use Interop/Util/Stream.LongStream.{LongStream};
    use Interop/Util.IntSummaryStatistics;
    use Interop/Util.IntSummaryStatistics.{IntSummaryStatistics};
    use Interop/Util.OptionalDouble;
    use Interop/Util.OptionalDouble.{OptionalDouble};
    use Interop/Util.OptionalInt;
    use Interop/Util.OptionalInt.{OptionalInt};
    use Interop/Util/Function.IntConsumer;
    use Interop/Util/Function.IntConsumer.{IntConsumer};
    use Interop/Util/Function.IntPredicate;
    use Interop/Util/Function.IntPredicate.{IntPredicate};
    use Interop/Util/Function.IntSupplier;
    use Interop/Util/Function.IntSupplier.{IntSupplier};
    use Interop/Util/Function.IntUnaryOperator;
    use Interop/Util/Function.IntUnaryOperator.{IntUnaryOperator};
    use Interop/Flix.Marshal;

    pub def getHH(x: IntStream[r]): ##java.util.stream.IntStream = 
        let IntStream(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.util.stream.IntStream): IntStream[r] = IntStream(prim)

    pub def intStreamIterator(s: IntStream[r]): Iterator[Int32, r] \ Write(r) =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ r;
        let r = Scoped.regionOf(s);
        let IntStream(s1) = s;
        let iter1 = iterator(s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(r, iter1);
        Interop/Util/IteratorZ.iterator(iter2)

    pub def empty(_: Region[r]): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.empty(): ##java.util.stream.IntStream \ r;
        empty() |> IntStream

    pub def ofInt32(_: Region[r], i: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.of(Int32): ##java.util.stream.IntStream \ r;
        of(i) |> IntStream

    pub def ofArray(_: Region[r], arr: Array[Int32, r2]): IntStream[r] \ {Write(r), Read(r2)} = 
        import static java.util.stream.IntStream.of(Array[Int32, r2]): ##java.util.stream.IntStream \ {r, r2};
        of(arr) |> IntStream


    pub def iterate(_: Region[r], seed: Int32, op: IntUnaryOperator): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.iterate(Int32, ##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ r;
        let IntUnaryOperator(op1) = op;
        iterate(seed, op1) |> IntStream

    pub def generate(_: Region[r], s: IntSupplier): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.generate(##java.util.function.IntSupplier): ##java.util.stream.IntStream \ r;
        let IntSupplier(s1) = s;
        generate(s1) |> IntStream


    pub def range(_: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.range(Int32, Int32): ##java.util.stream.IntStream \ r;
        range(b, e) |> IntStream

    pub def rangeClosed(_: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.rangeClosed(Int32, Int32): ##java.util.stream.IntStream \ r;
        rangeClosed(b, e) |> IntStream


    pub def concat(s: IntStream[r], t: IntStream[r]): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.concat(##java.util.stream.IntStream, ##java.util.stream.IntStream): ##java.util.stream.IntStream \ r;
        let IntStream(s1) = s;
        let IntStream(t1) = t;
        concat(s1, t1) |> IntStream


    pub def filter(p: IntPredicate, s: IntStream[r]): IntStream[r] \ Write(r) = 
        import java.util.stream.IntStream.filter(##java.util.function.IntPredicate): ##java.util.stream.IntStream \ r;
        let IntStream(s1) = s;
        let IntPredicate(p1) = p;
        filter(s1, p1) |> IntStream

    pub def dropWhile(p: IntPredicate, s: IntStream[r]): IntStream[r] \ Write(r) = 
        import java.util.stream.IntStream.dropWhile(##java.util.function.IntPredicate): ##java.util.stream.IntStream \ r;
        let IntStream(s1) = s;
        let IntPredicate(p1) = p;
        dropWhile(s1, p1) |> IntStream

    pub def map(op: IntUnaryOperator, s: IntStream[r]): IntStream[r] \ Write(r) = 
        import java.util.stream.IntStream.map(##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ r;
        let IntStream(s1) = s;
        let IntUnaryOperator(op1) = op;
        map(s1, op1) |> IntStream

    pub def forEach(f: IntConsumer, s: IntStream[r]): Unit \ Read(r) = 
        import java.util.stream.IntStream.forEach(##java.util.function.IntConsumer): Unit \ r;
        let IntStream(s1) = s;
        let IntConsumer(f1) = f;
        forEach(s1, f1)


    pub def average(s: IntStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.IntStream.average(): ##java.util.OptionalDouble \ r;
        let IntStream(s1) = s;
        average(s1) |> OptionalDouble

    
    pub def summaryStatistics(s: IntStream[r]): IntSummaryStatistics[r] \ Read(r) = 
        import java.util.stream.IntStream.summaryStatistics(): ##java.util.IntSummaryStatistics \ r;
        let IntStream(s1) = s;
        summaryStatistics(s1) |> IntSummaryStatistics

    pub def anyMatch(f: IntPredicate, s: IntStream[r]): Bool \ Read(r) = 
        import java.util.stream.IntStream.anyMatch(##java.util.function.IntPredicate): Bool \ r;
        let IntStream(s1) = s;
        let IntPredicate(f1) = f;
        anyMatch(s1, f1)

    pub def allMatch(f: IntPredicate, s: IntStream[r]): Bool \ Read(r) = 
        import java.util.stream.IntStream.allMatch(##java.util.function.IntPredicate): Bool \ r;
        let IntStream(s1) = s;
        let IntPredicate(f1) = f;
        allMatch(s1, f1)


    pub def noneMatch(f: IntPredicate, s: IntStream[r]): Bool \ Read(r) = 
        import java.util.stream.IntStream.noneMatch(##java.util.function.IntPredicate): Bool \ r;
        let IntStream(s1) = s;
        let IntPredicate(f1) = f;
        noneMatch(s1, f1)

    pub def findFirst(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.findFirst(): ##java.util.OptionalInt \ r;
        let IntStream(s1) = s;
        findFirst(s1) |> OptionalInt

    pub def findAny(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.findAny(): ##java.util.OptionalInt \ r;
        let IntStream(s1) = s;
        findAny(s1) |> OptionalInt

    pub def max(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.max(): ##java.util.OptionalInt \ r;
        let IntStream(s1) = s;
        max(s1) |> OptionalInt

    pub def min(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.min(): ##java.util.OptionalInt \ r;
        let IntStream(s1) = s;
        min(s1) |> OptionalInt


    pub def asLongStream(s: IntStream[r]): LongStream[r] \ Write(r) = 
        import java.util.stream.IntStream.asLongStream(): ##java.util.stream.LongStream \ r;
        let IntStream(s1) = s;
        asLongStream(s1) |> LongStream

    pub def asDoubleStream(s: IntStream[r]): DoubleStream[r] \ Write(r) = 
        import java.util.stream.IntStream.asDoubleStream(): ##java.util.stream.DoubleStream \ r;
        let IntStream(s1) = s;
        asDoubleStream(s1) |> DoubleStream

}
