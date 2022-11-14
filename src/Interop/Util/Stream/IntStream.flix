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
    
    use Interop/Util/Stream.IntStream
    use Interop/Util/Stream.IntStream.{IntStream}
    use Interop/Util/Stream.DoubleStream
    use Interop/Util/Stream.DoubleStream.{DoubleStream}
    use Interop/Util/Stream.LongStream
    use Interop/Util/Stream.LongStream.{LongStream}
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}
    use Interop/Util.IntSummaryStatistics
    use Interop/Util.IntSummaryStatistics.{IntSummaryStatistics}
    use Interop/Util.OptionalDouble
    use Interop/Util.OptionalDouble.{OptionalDouble}
    use Interop/Util.OptionalInt
    use Interop/Util.OptionalInt.{OptionalInt}
    use Interop/Util/Function.IntConsumer
    use Interop/Util/Function.IntFunction
    use Interop/Util/Function.IntPredicate
    use Interop/Util/Function.IntSupplier
    use Interop/Util/Function.IntUnaryOperator
    use Interop/Flix.Marshal

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

    pub def iterate(_: Region[r], seed: Int32, f: Int32 -> Int32 \ ef): IntStream[r] \ {Write(r), ef} = 
        import static java.util.stream.IntStream.iterate(Int32, IntUnaryOperator): ##java.util.stream.IntStream \ {r, ef};
        let f1 = Interop/Util/Function/IntUnaryOperator.makeIntUnaryOperator(f);
        iterate(seed, f1) |> IntStream

    pub def generate(_: Region[r], f: Unit -> Int32 \ ef): IntStream[r] \ {Write(r), ef} = 
        import static java.util.stream.IntStream.generate(IntSupplier): ##java.util.stream.IntStream \ r;
        let s1 = Interop/Util/Function/IntSupplier.makeIntSupplier(f);
        generate(s1) |> IntStream


    pub def range(_: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.range(Int32, Int32): ##java.util.stream.IntStream \ r;
        range(b, e) |> IntStream

    pub def rangeClosed(_: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.rangeClosed(Int32, Int32): ##java.util.stream.IntStream \ r;
        rangeClosed(b, e) |> IntStream

    pub def boxed(s: IntStream[r]): Stream[##java.lang.Integer, r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.boxed(): ##java.util.stream.Stream \ {r, ef};
        let IntStream(s1) = s;
        boxed(s1) |> Stream

    pub def count(s: IntStream[r]): Int64 \ Read(r) = 
        import java.util.stream.IntStream.count(): Int64 \ r;
        let IntStream(s1) = s;
        count(s1)

    pub def concat(s: IntStream[r], t: IntStream[r]): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.concat(##java.util.stream.IntStream, ##java.util.stream.IntStream): ##java.util.stream.IntStream \ r;
        let IntStream(s1) = s;
        let IntStream(t1) = t;
        concat(s1, t1) |> IntStream


    pub def filter(p: Int32 -> Bool \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.filter(IntPredicate): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(s1) = s;
        let p1 = Interop/Util/Function/IntPredicate.makeIntPredicate(p);
        filter(s1, p1) |> IntStream

    pub def dropWhile(p: Int32 -> Bool \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.dropWhile(IntPredicate): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(s1) = s;
        let p1 = Interop/Util/Function/IntPredicate.makeIntPredicate(p);
        dropWhile(s1, p1) |> IntStream

    pub def map(f: Int32 -> Int32 \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.map(IntUnaryOperator): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(s1) = s;
        let f1 = Interop/Util/Function/IntUnaryOperator.makeIntUnaryOperator(f);
        map(s1, f1) |> IntStream

    /// This is a bit wild - tests suggest it works...
    pub def flatMap(f: Int32 -> IntStream[r] \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.flatMap(IntFunction[##java.util.stream.IntStream]): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(s1) = s;
        let f1 = Interop/Util/Function/IntFunction.makeIntFunctionWith(f, t -> {let IntStream(t1) = t; t1 as ##java.lang.Object});
        (flatMap(s1, f1) as \ {Write(r), ef}) |> IntStream


    pub def forEach(f: Int32 -> Unit \ ef, s: IntStream[r]): Unit \ {Read(r), ef} = 
        import java.util.stream.IntStream.forEach(IntConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/IntConsumer.makeIntConsumer(f);
        let IntStream(s1) = s;
        forEach(s1, f1)

    pub def toArray(s: IntStream[r]): Array[Int32, r] \ Write(r) = 
        import java.util.stream.IntStream.toArray(): Array[Int32, r] \ r;
        let IntStream(s1) = s;
        toArray(s1)


    pub def average(s: IntStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.IntStream.average(): ##java.util.OptionalDouble \ r;
        let IntStream(s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(s: IntStream[r]): IntSummaryStatistics[r] \ Read(r) = 
        import java.util.stream.IntStream.summaryStatistics(): ##java.util.IntSummaryStatistics \ r;
        let IntStream(s1) = s;
        summaryStatistics(s1) |> IntSummaryStatistics

    pub def anyMatch(f: Int32 -> Bool \ ef, s: IntStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.IntStream.anyMatch(IntPredicate): Bool \ {r, ef};
        let IntStream(s1) = s;
        let f1 = Interop/Util/Function/IntPredicate.makeIntPredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Int32 -> Bool \ ef, s: IntStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.IntStream.allMatch(IntPredicate): Bool \ {r, ef};
        let IntStream(s1) = s;
        let f1 = Interop/Util/Function/IntPredicate.makeIntPredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Int32 -> Bool \ ef, s: IntStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.IntStream.noneMatch(IntPredicate): Bool \ {r, ef};
        let IntStream(s1) = s;
        let f1 = Interop/Util/Function/IntPredicate.makeIntPredicate(f);
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

    pub def sorted(s: IntStream[r]): IntStream[r] \ Write(r) = 
        import java.util.stream.IntStream.sorted(): ##java.util.stream.IntStream \ r;
        let IntStream(s1) = s;
        sorted(s1) |> IntStream


    pub def asLongStream(s: IntStream[r]): LongStream[r] \ Write(r) = 
        import java.util.stream.IntStream.asLongStream(): ##java.util.stream.LongStream \ r;
        let IntStream(s1) = s;
        asLongStream(s1) |> LongStream

    pub def asDoubleStream(s: IntStream[r]): DoubleStream[r] \ Write(r) = 
        import java.util.stream.IntStream.asDoubleStream(): ##java.util.stream.DoubleStream \ r;
        let IntStream(s1) = s;
        asDoubleStream(s1) |> DoubleStream

}
