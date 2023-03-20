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
    pub enum LongStream[_: Bool, r: Region]{ 
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


    pub def getHH(x: LongStream[ef, r]): ##java.util.stream.LongStream = 
        let LongStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.LongStream): LongStream[ef, r] = 
        LongStream(rc, prim)


    pub def newLongStream(rc: Region[r], prim: ##java.util.stream.LongStream): LongStream[ef, r] = 
        LongStream(rc, prim)

    pub def longStreamIterator(rc: Region[r1], s: LongStream[ef, r]): Iterator[Int64, ef and r and r1, r1] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {} as mkIterator;
        let LongStream(_, s1) = s;
        let iter1 = mkIterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let iter2 = checked_ecast(Interop/Util/IteratorZ.wrapHH(rc, iter1));
        Interop/Util/IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): LongStream[ef, r] = 
        import static java.util.stream.LongStream.empty(): ##java.util.stream.LongStream \ {};
        LongStream(rc, checked_ecast(empty()))

    pub def ofInt64(rc: Region[r], i: Int64): LongStream[ef, r] = 
        import static java.util.stream.LongStream.of(Int64): ##java.util.stream.LongStream \ {};
        LongStream(rc, checked_ecast(of(i)))

    pub def ofArray(rc: Region[r1], arr: Array[Int64, r]): LongStream[ef and r, r1] = 
        import static java.util.stream.LongStream.of(Array[Int64, r]): ##java.util.stream.LongStream \ {};
        LongStream(rc, checked_ecast(of(arr)))

    pub def iterate(rc: Region[r], seed: Int64, f: Int64 -> Int64 \ ef): LongStream[ef, r] = 
        import static java.util.stream.LongStream.iterate(Int64, LongUnaryOperator): ##java.util.stream.LongStream \ {};
        let f1 = unchecked_cast(Interop/Util/Function/LongUnaryOperator.makeLongUnaryOperator(f) as _ \ {});
        LongStream(rc, checked_ecast(iterate(seed, f1)))

    pub def generate(rc: Region[r], f: Unit -> Int64 \ ef): LongStream[ef, r] = 
        import static java.util.stream.LongStream.generate(LongSupplier): ##java.util.stream.LongStream \ {};
        let s1 = unchecked_cast(Interop/Util/Function/LongSupplier.makeLongSupplier(f) as _ \ {});
        LongStream(rc, checked_ecast(generate(s1)))


    pub def range(rc: Region[r], b: Int64, e: Int64): LongStream[ef, r] = 
        import static java.util.stream.LongStream.range(Int64, Int64): ##java.util.stream.LongStream \ {};
        LongStream(rc, checked_ecast(range(b, e)))

    pub def rangeClosed(rc: Region[r], b: Int64, e: Int64): LongStream[ef, r] = 
        import static java.util.stream.LongStream.rangeClosed(Int64, Int64): ##java.util.stream.LongStream \ {};
        LongStream(rc, checked_ecast(rangeClosed(b, e)))

    pub def boxed(s: LongStream[ef, r]): Stream[##java.lang.Long, r] \ {ef, Write(r)} = 
        import java.util.stream.LongStream.boxed(): ##java.util.stream.Stream \ {ef, r};
        let LongStream(rc, s1) = s;
        Stream(rc, boxed(s1))

    pub def count(s: LongStream[ef, r]): Int64 \ { ef, Read(r) } = 
        import java.util.stream.LongStream.count(): Int64 \ {ef, r};
        let LongStream(_, s1) = s;
        count(s1)

    pub def concat(s: LongStream[ef1, r], t: LongStream[ef2, r]): LongStream[ef1 and ef2, r] =
        import static java.util.stream.LongStream.concat(##java.util.stream.LongStream, ##java.util.stream.LongStream): ##java.util.stream.LongStream \ {};
        let LongStream(rc, s1) = s;
        let LongStream(_, t1) = t;
        LongStream(rc, checked_ecast(concat(s1, t1)))


    pub def filter(p: Int64 -> Bool \ ef1, s: LongStream[ef, r]): LongStream[ef and ef1, r] = 
        import java.util.stream.LongStream.filter(LongPredicate): ##java.util.stream.LongStream \ {};
        let LongStream(rc, s1) = s;
        let p1 = unchecked_cast(Interop/Util/Function/LongPredicate.makeLongPredicate(p) as _ \ {});
        LongStream(rc, checked_ecast(filter(s1, p1)))

    pub def dropWhile(p: Int64 -> Bool \ ef1, s: LongStream[ef, r]): LongStream[ef and ef1, r] = 
        import java.util.stream.LongStream.dropWhile(LongPredicate): ##java.util.stream.LongStream \ {};
        let LongStream(rc, s1) = s;
        let p1 = unchecked_cast(Interop/Util/Function/LongPredicate.makeLongPredicate(p) as _ \ {});
        LongStream(rc, checked_ecast(dropWhile(s1, p1)))

    pub def map(f: Int64 -> Int64 \ ef1, s: LongStream[ef, r]): LongStream[ef and ef1, r] = 
        import java.util.stream.LongStream.map(LongUnaryOperator): ##java.util.stream.LongStream \ {};
        let LongStream(rc, s1) = s;
        let f1 = unchecked_cast(Interop/Util/Function/LongUnaryOperator.makeLongUnaryOperator(f) as _ \ {});
        LongStream(rc, checked_ecast(map(s1, f1)))

    pub def flatMap(f: Int64 -> LongStream[ef1, r] \ ef2, s: LongStream[ef, r]): LongStream[ef and ef1 and ef2, r] = 
        import java.util.stream.LongStream.flatMap(LongFunction[##java.util.stream.LongStream]): ##java.util.stream.LongStream \ {};
        let LongStream(rc, s1) = s;
        let f1 = unchecked_cast(Interop/Util/Function/LongFunction.makeLongFunctionWith(f, t -> {let LongStream(_, t1) = t; unchecked_cast(t1 as ##java.lang.Object)}) as _ \ {});
        LongStream(rc, checked_ecast(flatMap(s1, f1)))


    pub def forEach(f: Int64 -> Unit \ ef, s: LongStream[ef, r]): Unit \ { ef, Read(r) } = 
        import java.util.stream.LongStream.forEach(LongConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/LongConsumer.makeLongConsumer(f);
        let LongStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(_: Region[r1], s: LongStream[ef, r]): Array[Int64, r1] \ { ef, Read(r), Write(r1) } = 
        import java.util.stream.LongStream.toArray(): Array[Int64, r1] \ {};
        let LongStream(_, s1) = s;
        checked_ecast(toArray(s1))


    pub def average(s: LongStream[ef, r]): OptionalDouble \ {ef, Read(r)}= 
        import java.util.stream.LongStream.average(): ##java.util.OptionalDouble \ {ef, r};
        let LongStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: LongStream[ef, r]): LongSummaryStatistics[r1] \ {ef, Read(r), Write(r1)} = 
        import java.util.stream.LongStream.summaryStatistics(): ##java.util.LongSummaryStatistics \ { ef, Read(r), Write(r1) };
        let LongStream(_, s1) = s;
        LongSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch(f: Int64 -> Bool \ ef, s: LongStream[ef, r]): Bool \ {ef, Read(r)} = 
        import java.util.stream.LongStream.anyMatch(LongPredicate): Bool \ {ef, r};
        let LongStream(_, s1) = s;
        let f1 = Interop/Util/Function/LongPredicate.makeLongPredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Int64 -> Bool \ ef, s: LongStream[ef, r]): Bool \ {ef, Read(r)} = 
        import java.util.stream.LongStream.allMatch(LongPredicate): Bool \ {ef, r};
        let LongStream(_, s1) = s;
        let f1 = Interop/Util/Function/LongPredicate.makeLongPredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Int64 -> Bool \ ef, s: LongStream[ef, r]): Bool \ {ef, Read(r)} = 
        import java.util.stream.LongStream.noneMatch(LongPredicate): Bool \ {ef, r};
        let LongStream(_, s1) = s;
        let f1 = Interop/Util/Function/LongPredicate.makeLongPredicate(f);
        noneMatch(s1, f1)


    pub def findFirst(s: LongStream[ef, r]): OptionalLong \ {ef, Read(r)} = 
        import java.util.stream.LongStream.findFirst(): ##java.util.OptionalLong \ {ef, r};
        let LongStream(_, s1) = s;
        findFirst(s1) |> OptionalLong

    pub def findAny(s: LongStream[ef, r]): OptionalLong \ {ef, Read(r)} = 
        import java.util.stream.LongStream.findAny(): ##java.util.OptionalLong \ {ef, r};
        let LongStream(_, s1) = s;
        findAny(s1) |> OptionalLong

    pub def max(s: LongStream[ef, r]): OptionalLong \ {ef, Read(r)} = 
        import java.util.stream.LongStream.max(): ##java.util.OptionalLong \ {ef, r};
        let LongStream(_, s1) = s;
        max(s1) |> OptionalLong

    pub def min(s: LongStream[ef, r]): OptionalLong \ {ef, Read(r)} = 
        import java.util.stream.LongStream.min(): ##java.util.OptionalLong \ {ef, r};
        let LongStream(_, s1) = s;
        min(s1) |> OptionalLong

    pub def sorted(s: LongStream[ef, r]): LongStream[ef, r] \ Write(r) = 
        import java.util.stream.LongStream.sorted(): ##java.util.stream.LongStream \ r;
        let LongStream(rc, s1) = s;
        LongStream(rc, sorted(s1))

    pub def asDoubleStream(rc: Region[r1], s: LongStream[ef, r]): DoubleStream[r1] \ Write(r) = 
        import java.util.stream.LongStream.asDoubleStream(): ##java.util.stream.DoubleStream \ r;
        let LongStream(_, s1) = s;
        DoubleStream(rc, asDoubleStream(s1))

}
