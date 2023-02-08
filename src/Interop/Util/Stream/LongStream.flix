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
    /// Represents a Java LongStream.
    ///
    pub enum LongStream[r: Region]{ 
        case LongStream(Region[r], ##java.util.stream.LongStream)
    }

}


namespace Interop/Util/Stream/LongStream {
    
    use Interop/Util/Stream.LongStream
    use Interop/Util/Stream.LongStream.{LongStream}
    use Interop/Util/Stream.DoubleStream
    use Interop/Util/Stream.DoubleStream.{DoubleStream}
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}
    use Interop/Util.LongSummaryStatistics
    use Interop/Util.LongSummaryStatistics.{LongSummaryStatistics}
    use Interop/Util.OptionalDouble
    use Interop/Util.OptionalDouble.{OptionalDouble}
    use Interop/Util.OptionalLong
    use Interop/Util.OptionalLong.{OptionalLong}
    use Interop/Util/Function.LongConsumer
    use Interop/Util/Function.LongFunction
    use Interop/Util/Function.LongPredicate
    use Interop/Util/Function.LongSupplier
    use Interop/Util/Function.LongUnaryOperator
    use Interop/Flix.Marshal


    pub def getHH(x: LongStream[r]): ##java.util.stream.LongStream = 
        let LongStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.LongStream): LongStream[r] = 
        LongStream(rc, prim)


    pub def newLongStream(rc: Region[r], prim: ##java.util.stream.LongStream): LongStream[r] = 
        LongStream(rc, prim)

    pub def longStreamIterator(rc: Region[r1], s: LongStream[r]): Iterator[Int64, r1, r1] \ { Read(r), Write(r1) } =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ { Read(r), Write(r1) };
        let LongStream(_, s1) = s;
        let iter1 = iterator(unsafe_cast s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(rc, iter1);
        Interop/Util/IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): LongStream[r] \ Write(r) = 
        import static java.util.stream.LongStream.empty(): ##java.util.stream.LongStream \ r;
        LongStream(rc, empty())

    pub def ofInt64(rc: Region[r], i: Int64): LongStream[r] \ Write(r) = 
        import static java.util.stream.LongStream.of(Int64): ##java.util.stream.LongStream \ r;
        LongStream(rc, of(i))

    pub def ofArray(rc: Region[r], arr: Array[Int64, r2]): LongStream[r] \ {Write(r), Read(r2)} = 
        import static java.util.stream.LongStream.of(Array[Int64, r2]): ##java.util.stream.LongStream \ {r, r2};
        LongStream(rc, of(arr))

    pub def iterate(rc: Region[r], seed: Int64, f: Int64 -> Int64 \ ef): LongStream[r] \ {Write(r), ef} = 
        import static java.util.stream.LongStream.iterate(Int64, LongUnaryOperator): ##java.util.stream.LongStream \ {r, ef};
        let f1 = Interop/Util/Function/LongUnaryOperator.makeLongUnaryOperator(f);
        LongStream(rc, iterate(seed, f1))

    pub def generate(rc: Region[r], f: Unit -> Int64 \ ef): LongStream[r] \ {Write(r), ef} = 
        import static java.util.stream.LongStream.generate(LongSupplier): ##java.util.stream.LongStream \ r;
        let s1 = Interop/Util/Function/LongSupplier.makeLongSupplier(f);
        LongStream(rc, generate(s1))


    pub def range(rc: Region[r], b: Int64, e: Int64): LongStream[r] \ Write(r) = 
        import static java.util.stream.LongStream.range(Int64, Int64): ##java.util.stream.LongStream \ r;
        LongStream(rc, range(b, e))

    pub def rangeClosed(rc: Region[r], b: Int64, e: Int64): LongStream[r] \ Write(r) = 
        import static java.util.stream.LongStream.rangeClosed(Int64, Int64): ##java.util.stream.LongStream \ r;
        LongStream(rc, rangeClosed(b, e))

    pub def boxed(s: LongStream[r]): Stream[##java.lang.Long, r] \ {Write(r), ef} = 
        import java.util.stream.LongStream.boxed(): ##java.util.stream.Stream \ {r, ef};
        let LongStream(rc, s1) = s;
        Stream(rc, boxed(s1))

    pub def count(s: LongStream[r]): Int64 \ Read(r) = 
        import java.util.stream.LongStream.count(): Int64 \ r;
        let LongStream(_, s1) = s;
        count(s1)

    pub def concat(s: LongStream[r], t: LongStream[r]): LongStream[r] \ Write(r) = 
        import static java.util.stream.LongStream.concat(##java.util.stream.LongStream, ##java.util.stream.LongStream): ##java.util.stream.LongStream \ r;
        let LongStream(rc, s1) = s;
        let LongStream(_, t1) = t;
        LongStream(rc, concat(s1, t1))


    pub def filter(p: Int64 -> Bool \ ef, s: LongStream[r]): LongStream[r] \ {Write(r), ef} = 
        import java.util.stream.LongStream.filter(LongPredicate): ##java.util.stream.LongStream \ {r, ef};
        let LongStream(rc, s1) = s;
        let p1 = Interop/Util/Function/LongPredicate.makeLongPredicate(p);
        LongStream(rc, filter(s1, p1))

    pub def dropWhile(p: Int64 -> Bool \ ef, s: LongStream[r]): LongStream[r] \ {Write(r), ef} = 
        import java.util.stream.LongStream.dropWhile(LongPredicate): ##java.util.stream.LongStream \ {r, ef};
        let LongStream(rc, s1) = s;
        let p1 = Interop/Util/Function/LongPredicate.makeLongPredicate(p);
        LongStream(rc, dropWhile(s1, p1))

    pub def map(f: Int64 -> Int64 \ ef, s: LongStream[r]): LongStream[r] \ {Write(r), ef} = 
        import java.util.stream.LongStream.map(LongUnaryOperator): ##java.util.stream.LongStream \ {r, ef};
        let LongStream(rc, s1) = s;
        let f1 = Interop/Util/Function/LongUnaryOperator.makeLongUnaryOperator(f);
        LongStream(rc, map(s1, f1))

    pub def flatMap(f: Int64 -> LongStream[r] \ ef, s: LongStream[r]): LongStream[r] \ {Write(r), ef} = 
        import java.util.stream.LongStream.flatMap(LongFunction[##java.util.stream.LongStream]): ##java.util.stream.LongStream \ {r, ef};
        let LongStream(rc, s1) = s;
        let f1 = Interop/Util/Function/LongFunction.makeLongFunctionWith(f, t -> {let LongStream(t1) = t; unsafe_cast t1 as ##java.lang.Object});
        LongStream(rc, unsafe_cast (flatMap(s1, f1)) as _ \ {Write(r), ef})


    pub def forEach(f: Int64 -> Unit \ ef, s: LongStream[r]): Unit \ {Read(r), ef} = 
        import java.util.stream.LongStream.forEach(LongConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/LongConsumer.makeLongConsumer(f);
        let LongStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(s: LongStream[r]): Array[Int64, r] \ Write(r) = 
        import java.util.stream.LongStream.toArray(): Array[Int64, r] \ r;
        let LongStream(_, s1) = s;
        toArray(s1)


    pub def average(s: LongStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.LongStream.average(): ##java.util.OptionalDouble \ r;
        let LongStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: LongStream[r]): LongSummaryStatistics[r1] \ { Read(r), Write(r1) } = 
        import java.util.stream.LongStream.summaryStatistics(): ##java.util.LongSummaryStatistics \ { Read(r), Write(r1) };
        let LongStream(_, s1) = s;
        summaryStatistics(s1) |> LongSummaryStatistics

    pub def anyMatch(f: Int64 -> Bool \ ef, s: LongStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.LongStream.anyMatch(LongPredicate): Bool \ {r, ef};
        let LongStream(_, s1) = s;
        let f1 = Interop/Util/Function/LongPredicate.makeLongPredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Int64 -> Bool \ ef, s: LongStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.LongStream.allMatch(LongPredicate): Bool \ {r, ef};
        let LongStream(_, s1) = s;
        let f1 = Interop/Util/Function/LongPredicate.makeLongPredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Int64 -> Bool \ ef, s: LongStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.LongStream.noneMatch(LongPredicate): Bool \ {r, ef};
        let LongStream(_, s1) = s;
        let f1 = Interop/Util/Function/LongPredicate.makeLongPredicate(f);
        noneMatch(s1, f1)


    pub def findFirst(s: LongStream[r]): OptionalLong \ Read(r) = 
        import java.util.stream.LongStream.findFirst(): ##java.util.OptionalLong \ r;
        let LongStream(_, s1) = s;
        findFirst(s1) |> OptionalLong

    pub def findAny(s: LongStream[r]): OptionalLong \ Read(r) = 
        import java.util.stream.LongStream.findAny(): ##java.util.OptionalLong \ r;
        let LongStream(_, s1) = s;
        findAny(s1) |> OptionalLong

    pub def max(s: LongStream[r]): OptionalLong \ Read(r) = 
        import java.util.stream.LongStream.max(): ##java.util.OptionalLong \ r;
        let LongStream(_, s1) = s;
        max(s1) |> OptionalLong

    pub def min(s: LongStream[r]): OptionalLong \ Read(r) = 
        import java.util.stream.LongStream.min(): ##java.util.OptionalLong \ r;
        let LongStream(_, s1) = s;
        min(s1) |> OptionalLong

    pub def sorted(s: LongStream[r]): LongStream[r] \ Write(r) = 
        import java.util.stream.LongStream.sorted(): ##java.util.stream.LongStream \ r;
        let LongStream(rc, s1) = s;
        LongStream(rc, sorted(s1))

    pub def asDoubleStream(rc: Region[r1], s: LongStream[r]): DoubleStream[r1] \ Write(r) = 
        import java.util.stream.LongStream.asDoubleStream(): ##java.util.stream.DoubleStream \ r;
        let LongStream(_, s1) = s;
        DoubleStream(rc, asDoubleStream(s1))
}
