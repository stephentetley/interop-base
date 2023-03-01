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
    pub enum IntStream[r: Region] { 
        case IntStream(Region[r], ##java.util.stream.IntStream)
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
        let IntStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.IntStream): IntStream[r] = 
        IntStream(rc, prim)

    pub def intStreamIterator(rc: Region[r1], s: IntStream[r]): Iterator[Int32, r1, r1] \ Read(r) =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ r;
        let IntStream(_, s1) = s;
        let iter1 = iterator(unsafe_cast s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(rc, iter1);
        Interop/Util/IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.empty(): ##java.util.stream.IntStream \ r;
        IntStream(rc, empty())

    pub def ofInt32(rc: Region[r], i: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.of(Int32): ##java.util.stream.IntStream \ r;
        IntStream(rc, of(i))

    pub def ofArray(rc: Region[r], arr: Array[Int32, r2]): IntStream[r] \ {Write(r), Read(r2)} = 
        import static java.util.stream.IntStream.of(Array[Int32, r2]): ##java.util.stream.IntStream \ {r, r2};
        IntStream(rc, of(arr))

    pub def iterate(rc: Region[r], seed: Int32, f: Int32 -> Int32 \ ef): IntStream[r] \ {Write(r), ef} = 
        import static java.util.stream.IntStream.iterate(Int32, IntUnaryOperator): ##java.util.stream.IntStream \ {r, ef};
        let f1 = Interop/Util/Function/IntUnaryOperator.makeIntUnaryOperator(f);
        IntStream(rc, iterate(seed, f1))

    pub def generate(rc: Region[r], f: Unit -> Int32 \ ef): IntStream[r] \ {Write(r), ef} = 
        import static java.util.stream.IntStream.generate(IntSupplier): ##java.util.stream.IntStream \ r;
        let s1 = Interop/Util/Function/IntSupplier.makeIntSupplier(f);
        IntStream(rc, generate(s1))


    pub def range(rc: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.range(Int32, Int32): ##java.util.stream.IntStream \ r;
        IntStream(rc, range(b, e))

    pub def rangeClosed(rc: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.rangeClosed(Int32, Int32): ##java.util.stream.IntStream \ r;
        IntStream(rc, rangeClosed(b, e))

    pub def boxed(rc: Region[r1], s: IntStream[r]): Stream[##java.lang.Integer, r1] \ Read(r) = 
        import java.util.stream.IntStream.boxed(): ##java.util.stream.Stream \ r;
        let IntStream(_, s1) = s;
        Stream(rc, boxed(s1))

    pub def count(s: IntStream[r]): Int64 \ Read(r) = 
        import java.util.stream.IntStream.count(): Int64 \ r;
        let IntStream(_, s1) = s;
        count(s1)

    pub def concat(s: IntStream[r], t: IntStream[r]): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.concat(##java.util.stream.IntStream, ##java.util.stream.IntStream): ##java.util.stream.IntStream \ r;
        let IntStream(rc, s1) = s;
        let IntStream(_, t1) = t;
        IntStream(rc, concat(s1, t1))


    pub def filter(p: Int32 -> Bool \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.filter(IntPredicate): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(rc, s1) = s;
        let p1 = Interop/Util/Function/IntPredicate.makeIntPredicate(p);
        IntStream(rc, filter(s1, p1))

    pub def dropWhile(p: Int32 -> Bool \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.dropWhile(IntPredicate): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(rc, s1) = s;
        let p1 = Interop/Util/Function/IntPredicate.makeIntPredicate(p);
        IntStream(rc, dropWhile(s1, p1))

    pub def map(f: Int32 -> Int32 \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.map(IntUnaryOperator): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(rc, s1) = s;
        let f1 = Interop/Util/Function/IntUnaryOperator.makeIntUnaryOperator(f);
        IntStream(rc, map(s1, f1))

    /// This is a bit wild - should we encapsulate `ef` in the IntStream type? ...
    pub def flatMap(f: Int32 -> IntStream[r] \ ef, s: IntStream[r]): IntStream[r] \ {Write(r), ef} = 
        import java.util.stream.IntStream.flatMap(IntFunction[##java.util.stream.IntStream]): ##java.util.stream.IntStream \ {r, ef};
        let IntStream(rc, s1) = s;
        let f1 = Interop/Util/Function/IntFunction.makeIntFunctionWith(f, t -> {let IntStream(_, t1) = t; unsafe_cast t1 as ##java.lang.Object});
        IntStream(rc, unsafe_cast (flatMap(s1, f1)) as _ \ { Write(r), ef })


    pub def forEach(f: Int32 -> Unit \ ef, s: IntStream[r]): Unit \ {Read(r), ef} = 
        import java.util.stream.IntStream.forEach(IntConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/IntConsumer.makeIntConsumer(f);
        let IntStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(s: IntStream[r]): Array[Int32, r] \ Write(r) = 
        import java.util.stream.IntStream.toArray(): Array[Int32, r] \ r;
        let IntStream(_, s1) = s;
        toArray(s1)


    pub def average(s: IntStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.IntStream.average(): ##java.util.OptionalDouble \ r;
        let IntStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: IntStream[r]): IntSummaryStatistics[r1] \ { Read(r), Write(r1) } = 
        import java.util.stream.IntStream.summaryStatistics(): ##java.util.IntSummaryStatistics \ { Read(r), Write(r1) };
        let IntStream(_, s1) = s;
        IntSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch(f: Int32 -> Bool \ ef, s: IntStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.IntStream.anyMatch(IntPredicate): Bool \ {r, ef};
        let IntStream(_, s1) = s;
        let f1 = Interop/Util/Function/IntPredicate.makeIntPredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Int32 -> Bool \ ef, s: IntStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.IntStream.allMatch(IntPredicate): Bool \ {r, ef};
        let IntStream(_, s1) = s;
        let f1 = Interop/Util/Function/IntPredicate.makeIntPredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Int32 -> Bool \ ef, s: IntStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.IntStream.noneMatch(IntPredicate): Bool \ {r, ef};
        let IntStream(_, s1) = s;
        let f1 = Interop/Util/Function/IntPredicate.makeIntPredicate(f);
        noneMatch(s1, f1)

    pub def findFirst(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.findFirst(): ##java.util.OptionalInt \ r;
        let IntStream(_, s1) = s;
        findFirst(s1) |> OptionalInt

    pub def findAny(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.findAny(): ##java.util.OptionalInt \ r;
        let IntStream(_, s1) = s;
        findAny(s1) |> OptionalInt

    pub def max(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.max(): ##java.util.OptionalInt \ r;
        let IntStream(_, s1) = s;
        max(s1) |> OptionalInt

    pub def min(s: IntStream[r]): OptionalInt \ Read(r) = 
        import java.util.stream.IntStream.min(): ##java.util.OptionalInt \ r;
        let IntStream(_, s1) = s;
        min(s1) |> OptionalInt

    pub def sorted(s: IntStream[r]): IntStream[r] \ Write(r) = 
        import java.util.stream.IntStream.sorted(): ##java.util.stream.IntStream \ r;
        let IntStream(rc, s1) = s;
        IntStream(rc, sorted(s1))


    pub def asLongStream(rc: Region[r1], s: IntStream[r]): LongStream[r1] \ Read(r) = 
        import java.util.stream.IntStream.asLongStream(): ##java.util.stream.LongStream \ r;
        let IntStream(_, s1) = s;
        LongStream(rc, asLongStream(s1))

    pub def asDoubleStream(rc: Region[r1], s: IntStream[r]): DoubleStream[r1] \ Read(r)= 
        import java.util.stream.IntStream.asDoubleStream(): ##java.util.stream.DoubleStream \ r;
        let IntStream(_, s1) = s;
        DoubleStream(rc, asDoubleStream(s1))

}
