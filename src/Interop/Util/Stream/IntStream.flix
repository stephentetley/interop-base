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
    /// Represents a Java IntStream.
    ///
    pub enum IntStream[_: Bool, r: Region] { 
        case IntStream(Region[r], ##java.util.stream.IntStream)
    }


}


mod Interop.Util.Stream.IntStream {
    
    use Interop.Util.Stream.IntStream
    use Interop.Util.Stream.IntStream.{IntStream}
    use Interop.Util.Stream.DoubleStream
    use Interop.Util.Stream.DoubleStream.{DoubleStream}
    use Interop.Util.Stream.LongStream
    use Interop.Util.Stream.LongStream.{LongStream}
    use Interop.Util.Stream.Stream
    use Interop.Util.Stream.Stream.{Stream}
    use Interop.Util.IntSummaryStatistics
    use Interop.Util.IntSummaryStatistics.{IntSummaryStatistics}
    use Interop.Util.OptionalDouble
    use Interop.Util.OptionalDouble.{OptionalDouble}
    use Interop.Util.OptionalInt
    use Interop.Util.OptionalInt.{OptionalInt}
    use Interop.Util.Function.IntConsumerZ.{IntConsumerZ}
    use Interop.Util.Function.IntFunctionZ.{IntFunctionZ}
    use Interop.Util.Function.IntPredicateZ.{IntPredicateZ}
    use Interop.Util.Function.IntSupplier.{IntSupplier}
    use Interop.Util.Function.IntUnaryOperatorZ.{IntUnaryOperatorZ}
    use Interop.Flix.Marshal

    pub def getHH(x: IntStream[ef, r]): ##java.util.stream.IntStream = 
        let IntStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.IntStream): IntStream[ef, r] = 
        IntStream(rc, prim)

    pub def intStreamIterator(rc: Region[r1], s: IntStream[ef, r]): Iterator[Int32, ef and r and r1, r1] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {} as mkIterator;
        let IntStream(_, s1) = s;
        let iter1 = mkIterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let iter2 = checked_ecast(Interop.Util.IteratorZ.wrapHH(rc, iter1));
        Interop.Util.IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): IntStream[ef, r] = 
        import static java.util.stream.IntStream.empty(): ##java.util.stream.IntStream \ {};
        IntStream(rc, checked_ecast(empty()))

    pub def ofInt32(rc: Region[r], i: Int32): IntStream[ef, r] = 
        import static java.util.stream.IntStream.of(Int32): ##java.util.stream.IntStream \ {};
        IntStream(rc, checked_ecast(of(i)))

    pub def ofArray(rc: Region[r1], arr: Array[Int32, r]): IntStream[ef and r, r1] = 
        import static java.util.stream.IntStream.of(Array[Int32, r]): ##java.util.stream.IntStream \ {};
        IntStream(rc, checked_ecast(of(arr)))

    pub def iterate(rc: Region[r], seed: Int32, f: Int32 -> Int32 \ ef): IntStream[ef, r] = 
        import static java.util.stream.IntStream.iterate(Int32, ##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ {};
        let IntUnaryOperatorZ(f1) = Interop.Util.Function.IntUnaryOperatorZ.makeIntUnaryOperatorZ(f);
        IntStream(rc, checked_ecast(iterate(seed, f1)))

    pub def generate(rc: Region[r], f: Unit -> Int32 \ ef): IntStream[ef, r] = 
        import static java.util.stream.IntStream.generate(##java.util.function.IntSupplier): ##java.util.stream.IntStream \ {};
        let IntSupplier(s1) = Interop.Util.Function.IntSupplier.makeIntSupplier(f);
        IntStream(rc, checked_ecast(generate(s1)))

    pub def range(rc: Region[r], b: Int32, e: Int32): IntStream[ef, r] = 
        import static java.util.stream.IntStream.range(Int32, Int32): ##java.util.stream.IntStream \ {};
        IntStream(rc, checked_ecast(range(b, e)))

    pub def rangeClosed(rc: Region[r], b: Int32, e: Int32): IntStream[ef, r] = 
        import static java.util.stream.IntStream.rangeClosed(Int32, Int32): ##java.util.stream.IntStream \ {};
        IntStream(rc, checked_ecast(rangeClosed(b, e)))

    pub def boxed(rc: Region[r1], s: IntStream[ef, r]): Stream[##java.lang.Integer, ef, r1] = 
        import java.util.stream.IntStream.boxed(): ##java.util.stream.Stream \ {};
        let IntStream(_, s1) = s;
        Stream(rc, checked_ecast(boxed(s1)))

    pub def count(s: IntStream[ef, r]): Int64 \ { ef, Read(r) } = 
        import java.util.stream.IntStream.count(): Int64 \ {ef, r};
        let IntStream(_, s1) = s;
        count(s1)

    pub def concat(s: IntStream[ef1, r], t: IntStream[ef2, r]): IntStream[ef1 and ef2, r] = 
        import static java.util.stream.IntStream.concat(##java.util.stream.IntStream, ##java.util.stream.IntStream): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntStream(_, t1) = t;
        IntStream(rc, checked_ecast(concat(s1, t1)))


    pub def filter[ef: Bool, ef1: Bool, r: Region]
                    (p: Int32 -> Bool \ ef1, s: IntStream[ef, r]): IntStream[ef and ef1, r] = 
        import java.util.stream.IntStream.filter(##java.util.function.IntPredicate): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntPredicateZ(p1) = Interop.Util.Function.IntPredicateZ.makeIntPredicateZ(p);
        IntStream(rc, filter(s1, p1))

    pub def dropWhile[ef: Bool, ef1: Bool, r: Region]
                        (p: Int32 -> Bool \ ef1, s: IntStream[ef, r]): IntStream[ef and ef1, r] = 
        import java.util.stream.IntStream.dropWhile(##java.util.function.IntPredicate): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntPredicateZ(p1) = Interop.Util.Function.IntPredicateZ.makeIntPredicateZ(p);
        IntStream(rc, dropWhile(s1, p1))


    pub def limit(size: Int64, s: IntStream[ef, r]): IntStream[ef, r] = 
        import java.util.stream.IntStream.limit(Int64): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        IntStream(rc, checked_ecast(limit(s1, size)))


    pub def map(f: Int32 -> Int32 \ ef1, s: IntStream[ef, r]): IntStream[ef and ef1, r] = 
        import java.util.stream.IntStream.map(##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntUnaryOperatorZ(f1) = Interop.Util.Function.IntUnaryOperatorZ.makeIntUnaryOperatorZ(f);
        IntStream(rc, checked_ecast(map(s1, f1)))


    /// 
    pub def flatMap(f: Int32 -> IntStream[ef1, r] \ ef2, s: IntStream[ef, r]): IntStream[ef and ef1 and ef2, r] = 
        import java.util.stream.IntStream.flatMap(##java.util.function.IntFunction): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntFunctionZ(f1) = Interop.Util.Function.IntFunctionZ.makeIntFunctionZWith(f, t -> {let IntStream(_, t1) = t; unchecked_cast(t1 as ##java.lang.Object)});
        IntStream(rc, checked_ecast(flatMap(s1, f1)))


    pub def forEach[ef: Bool, ef1: Bool, r: Region]
                    (f: Int32 -> Unit \ ef1, s: IntStream[ef, r]): Unit \ {ef, ef1, Read(r)} = 
        import java.util.stream.IntStream.forEach(##java.util.function.IntConsumer): Unit \ {ef, ef1, r};
        let IntConsumerZ(f1) = Interop.Util.Function.IntConsumerZ.makeIntConsumerZ(f);
        let IntStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(_: Region[r1], s: IntStream[ef, r]): Array[Int32, r1] \ {ef, Read(r), Write(r1)} = 
        import java.util.stream.IntStream.toArray(): Array[Int32, r1] \ {};
        let IntStream(_, s1) = s;
        checked_ecast(toArray(s1))


    pub def average(s: IntStream[ef, r]): OptionalDouble \ {Read(r), ef} = 
        import java.util.stream.IntStream.average(): ##java.util.OptionalDouble \ {ef, r};
        let IntStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: IntStream[ef, r]): IntSummaryStatistics[r1] \ { ef, Read(r), Write(r1) } = 
        import java.util.stream.IntStream.summaryStatistics(): ##java.util.IntSummaryStatistics \ { ef, Read(r), Write(r1) };
        let IntStream(_, s1) = s;
        IntSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch[ef: Bool, ef1: Bool, r: Region]
                    (p: Int32 -> Bool \ ef1, s: IntStream[ef, r]): Bool \ {ef, ef1, Read(r)} = 
        import java.util.stream.IntStream.anyMatch(##java.util.function.IntPredicate): Bool \ {ef, ef1, r};
        let IntStream(_, s1) = s;
        let IntPredicateZ(p1) = Interop.Util.Function.IntPredicateZ.makeIntPredicateZ(p);
        anyMatch(s1, p1)

    pub def allMatch[ef: Bool, ef1: Bool, r: Region]
                    (p: Int32 -> Bool \ ef1, s: IntStream[ef, r]): Bool \ {ef, ef1, Read(r)} = 
        import java.util.stream.IntStream.allMatch(##java.util.function.IntPredicate): Bool \ {ef, ef1, r};
        let IntStream(_, s1) = s;
        let IntPredicateZ(p1) = Interop.Util.Function.IntPredicateZ.makeIntPredicateZ(p);
        allMatch(s1, p1)


    pub def noneMatch[ef: Bool, ef1: Bool, r: Region]
                        (p: Int32 -> Bool \ ef1, s: IntStream[ef, r]): Bool \ {ef, ef1, Read(r)} = 
        import java.util.stream.IntStream.noneMatch(##java.util.function.IntPredicate): Bool \ {ef, ef1, r};
        let IntStream(_, s1) = s;
        let IntPredicateZ(p1) = Interop.Util.Function.IntPredicateZ.makeIntPredicateZ(p);
        noneMatch(s1, p1)

    pub def findFirst(s: IntStream[ef, r]): Option[Int32] \ {ef, Read(r)} = 
        import java.util.stream.IntStream.findFirst(): ##java.util.OptionalInt \ { ef, r };
        let IntStream(_, s1) = s;
        findFirst(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def findAny(s: IntStream[ef, r]): Option[Int32] \ {ef, Read(r)} = 
        import java.util.stream.IntStream.findAny(): ##java.util.OptionalInt \ {ef, r};
        let IntStream(_, s1) = s;
        findAny(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def max(s: IntStream[ef, r]): Option[Int32] \ {ef, Read(r)} = 
        import java.util.stream.IntStream.max(): ##java.util.OptionalInt \ {ef, r};
        let IntStream(_, s1) = s;
        max(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def min(s: IntStream[ef, r]): Option[Int32] \ {ef, Read(r)} = 
        import java.util.stream.IntStream.min(): ##java.util.OptionalInt \ {ef, r};
        let IntStream(_, s1) = s;
        min(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def sorted(s: IntStream[ef, r]): IntStream[ef, r] = 
        import java.util.stream.IntStream.sorted(): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        IntStream(rc, checked_ecast(sorted(s1)))


    pub def asLongStream(rc: Region[r1], s: IntStream[ef, r]): LongStream[ef, r1] = 
        import java.util.stream.IntStream.asLongStream(): ##java.util.stream.LongStream \ {};
        let IntStream(_, s1) = s;
        LongStream(rc, asLongStream(s1))

    pub def asDoubleStream(rc: Region[r1], s: IntStream[ef, r]): DoubleStream[ef, r1] = 
        import java.util.stream.IntStream.asDoubleStream(): ##java.util.stream.DoubleStream \ {};
        let IntStream(_, s1) = s;
        DoubleStream(rc, asDoubleStream(s1))

}
