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

    use Interop.Util.Stream.IntStream.{IntStream} 

    ///
    /// Represents a Java IntStream.
    ///
    pub enum IntStream[_: Eff, r: Region] { 
        case IntStream(Region[r], ##java.util.stream.IntStream)
    }


    instance Interop.Flix.GoesToJava[IntStream[ef, r]]{
        pub def toJavaObject(o: IntStream[ef, r]): ##java.lang.Object =
            let IntStream(_, o1) = o;
            checked_cast(o1) 
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
    use Interop.Util.Function.IntConsumerZ
    use Interop.Util.Function.IntConsumerZ.{IntConsumerZ}
    use Interop.Util.Function.IntFunctionZ
    use Interop.Util.Function.IntFunctionZ.{IntFunctionZ}
    use Interop.Util.Function.IntPredicateZ
    use Interop.Util.Function.IntPredicateZ.{IntPredicateZ}
    use Interop.Util.Function.IntSupplier
    use Interop.Util.Function.IntSupplier.{IntSupplier}
    use Interop.Util.Function.IntToDoubleFunction
    use Interop.Util.Function.IntToDoubleFunction.{IntToDoubleFunction}
    use Interop.Util.Function.IntToLongFunction
    use Interop.Util.Function.IntToLongFunction.{IntToLongFunction}
    use Interop.Util.Function.IntUnaryOperatorZ
    use Interop.Util.Function.IntUnaryOperatorZ.{IntUnaryOperatorZ}

    pub def getHH(x: IntStream[ef, r]): ##java.util.stream.IntStream = 
        let IntStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.IntStream): IntStream[ef, r] = 
        IntStream(rc, prim)

    pub def intStreamIterator(rc: Region[r1], s: IntStream[ef, r]): Iterator[Int32, ef + r + r1, r1] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {} as mkIterator;
        let IntStream(_, s1) = s;
        let iter1 = mkIterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let iter2 = Interop.Util.IteratorZ.wrapHH(rc, iter1);
        Interop.Util.IteratorZ.toFlixIterator(rc, Interop.Flix.ComesFromJava.int32FromJavaObject, iter2)

    pub def empty(rc: Region[r]): IntStream[ef, r] = 
        import static java.util.stream.IntStream.empty(): ##java.util.stream.IntStream \ {};
        IntStream(rc, empty())

    pub def ofInt32(rc: Region[r], i: Int32): IntStream[ef, r] = 
        import static java.util.stream.IntStream.of(Int32): ##java.util.stream.IntStream \ {};
        IntStream(rc, of(i))

    pub def ofArray(rc: Region[r1], arr: Array[Int32, r]): IntStream[ef + r, r1] = 
        import static java.util.stream.IntStream.of(Array[Int32, r]): ##java.util.stream.IntStream \ {};
        IntStream(rc, of(arr))

    pub def ofVector(rc: Region[r], v: Vector[Int32]): IntStream[ef + r, r] \ r =  
        import static java.util.stream.IntStream.of(Array[Int32, r]): ##java.util.stream.IntStream \ {};
        let arr = Vector.toArray(rc, v);
        IntStream(rc, of(arr))

    pub def iterate(rc: Region[r], seed: Int32, f: IntUnaryOperatorZ[ef]): IntStream[ef, r] = 
        import static java.util.stream.IntStream.iterate(Int32, ##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ {};
        let IntUnaryOperatorZ(f1) = f;
        IntStream(rc, iterate(seed, f1))

    pub def iterateWithPredicate(rc: Region[r], 
                                seed: Int32, 
                                hasNext: IntPredicateZ[ef1], 
                                next: IntUnaryOperatorZ[ef]): IntStream[ef + ef1, r] = 
        import static java.util.stream.IntStream.iterate(Int32, ##java.util.function.IntPredicate, ##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ {};
        let IntPredicateZ(hasNext1) = hasNext;
        let IntUnaryOperatorZ(next1) = next;
        IntStream(rc, iterate(seed, hasNext1, next1))


    pub def generate(rc: Region[r], f: IntSupplier[ef]): IntStream[ef, r] = 
        import static java.util.stream.IntStream.generate(##java.util.function.IntSupplier): ##java.util.stream.IntStream \ {};
        let IntSupplier(f1) = f;
        IntStream(rc, generate(f1))

    pub def range(rc: Region[r], b: Int32, e: Int32): IntStream[ef, r] = 
        import static java.util.stream.IntStream.range(Int32, Int32): ##java.util.stream.IntStream \ {};
        IntStream(rc, range(b, e))

    pub def rangeClosed(rc: Region[r], b: Int32, e: Int32): IntStream[ef, r] = 
        import static java.util.stream.IntStream.rangeClosed(Int32, Int32): ##java.util.stream.IntStream \ {};
        IntStream(rc, rangeClosed(b, e))

    pub def boxed(rc: Region[r1], s: IntStream[ef, r]): Stream[##java.lang.Integer, ef, r1] = 
        import java.util.stream.IntStream.boxed(): ##java.util.stream.Stream \ {};
        let IntStream(_, s1) = s;
        Stream(rc, boxed(s1))

    pub def count(s: IntStream[ef, r]): Int64 \ { ef, r } = 
        import java.util.stream.IntStream.count(): Int64 \ {ef, r};
        let IntStream(_, s1) = s;
        count(s1)

    pub def distinct(s: IntStream[ef, r]): IntStream[ef, r] \ {ef, r} = 
        import java.util.stream.IntStream.distinct(): ##java.util.stream.IntStream \ {ef, r};
        let IntStream(rc, s1) = s;
        IntStream(rc, distinct(s1))


    pub def concat(s: IntStream[ef1, r], t: IntStream[ef2, r]): IntStream[ef1 + ef2, r] = 
        import static java.util.stream.IntStream.concat(##java.util.stream.IntStream, ##java.util.stream.IntStream): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntStream(_, t1) = t;
        IntStream(rc, concat(s1, t1))


    pub def filter(p: IntPredicateZ[ef1], s: IntStream[ef, r]): IntStream[ef + ef1, r] = 
        import java.util.stream.IntStream.filter(##java.util.function.IntPredicate): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntPredicateZ(p1) = p;
        IntStream(rc, filter(s1, p1))

    pub def dropWhile(p: IntPredicateZ[ef1], s: IntStream[ef, r]): IntStream[ef + ef1, r] = 
        import java.util.stream.IntStream.dropWhile(##java.util.function.IntPredicate): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntPredicateZ(p1) = p;
        IntStream(rc, dropWhile(s1, p1))


    pub def limit(size: Int64, s: IntStream[ef, r]): IntStream[ef, r] = 
        import java.util.stream.IntStream.limit(Int64): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        IntStream(rc, limit(s1, size))


    pub def map(f: IntUnaryOperatorZ[ef1], s: IntStream[ef, r]): IntStream[ef + ef1, r] = 
        import java.util.stream.IntStream.map(##java.util.function.IntUnaryOperator): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntUnaryOperatorZ(f1) = f;
        IntStream(rc, map(s1, f1))

    pub def mapToDouble(rc: Region[r1], f: IntToDoubleFunction[ef1], s: IntStream[ef, r]): DoubleStream[ef + ef1 + r, r1] = 
        import java.util.stream.IntStream.mapToDouble(##java.util.function.IntToDoubleFunction): ##java.util.stream.DoubleStream \ {};
        let IntStream(_, s1) = s;
        let IntToDoubleFunction(f1) = f;
        DoubleStream(rc, mapToDouble(s1, f1))

    pub def mapToLong(rc: Region[r1], f: IntToLongFunction[ef1], s: IntStream[ef, r]): LongStream[ef + ef1 + r, r1] = 
        import java.util.stream.IntStream.mapToLong(##java.util.function.IntToLongFunction): ##java.util.stream.LongStream \ {};
        let IntStream(_, s1) = s;
        let IntToLongFunction(f1) = f;
        LongStream(rc, mapToLong(s1, f1))

    /// 
    pub def flatMap(f: IntFunctionZ[IntStream[ef1, r], ef2], s: IntStream[ef, r]): IntStream[ef + ef1 + ef2, r] = 
        import java.util.stream.IntStream.flatMap(##java.util.function.IntFunction): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        let IntFunctionZ(f1) = f;
        IntStream(rc, flatMap(s1, f1))


    pub def forEachOrdered(f: IntConsumerZ[ef1], s: IntStream[ef, r]): Unit \ {ef, ef1, r} = 
        import java.util.stream.IntStream.forEachOrdered(##java.util.function.IntConsumer): Unit \ {ef, ef1, r};
        let IntConsumerZ(f1) = f;
        let IntStream(_, s1) = s;
        forEachOrdered(s1, f1)

    pub def forEach(f: IntConsumerZ[ef1], s: IntStream[ef, r]): Unit \ {ef, ef1, r} = 
        import java.util.stream.IntStream.forEach(##java.util.function.IntConsumer): Unit \ {ef, ef1, r};
        let IntConsumerZ(f1) = f;
        let IntStream(_, s1) = s;
        forEach(s1, f1)


    pub def toArray(_: Region[r1], s: IntStream[ef, r]): Array[Int32, r1] \ {ef, r, r1} = 
        import java.util.stream.IntStream.toArray(): Array[Int32, r1] \ {};
        let IntStream(_, s1) = s;
        checked_ecast(toArray(s1))


    pub def average(s: IntStream[ef, r]): OptionalDouble \ {r, ef} = 
        import java.util.stream.IntStream.average(): ##java.util.OptionalDouble \ {ef, r};
        let IntStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: IntStream[ef, r]): IntSummaryStatistics[r1] \ { ef, r, r1 } = 
        import java.util.stream.IntStream.summaryStatistics(): ##java.util.IntSummaryStatistics \ { ef, r, r1 };
        let IntStream(_, s1) = s;
        IntSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch(p: IntPredicateZ[ef1], s: IntStream[ef, r]): Bool \ {ef, ef1, r} = 
        import java.util.stream.IntStream.anyMatch(##java.util.function.IntPredicate): Bool \ {ef, ef1, r};
        let IntStream(_, s1) = s;
        let IntPredicateZ(p1) = p;
        anyMatch(s1, p1)

    pub def allMatch(p: IntPredicateZ[ef1], s: IntStream[ef, r]): Bool \ {ef, ef1, r} = 
        import java.util.stream.IntStream.allMatch(##java.util.function.IntPredicate): Bool \ {ef, ef1, r};
        let IntStream(_, s1) = s;
        let IntPredicateZ(p1) = p;
        allMatch(s1, p1)


    pub def noneMatch(p: IntPredicateZ[ef1], s: IntStream[ef, r]): Bool \ {ef, ef1, r} = 
        import java.util.stream.IntStream.noneMatch(##java.util.function.IntPredicate): Bool \ {ef, ef1, r};
        let IntStream(_, s1) = s;
        let IntPredicateZ(p1) = p;
        noneMatch(s1, p1)

    pub def findFirst(s: IntStream[ef, r]): Option[Int32] \ {ef, r} = 
        import java.util.stream.IntStream.findFirst(): ##java.util.OptionalInt \ { ef, r };
        let IntStream(_, s1) = s;
        findFirst(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def findAny(s: IntStream[ef, r]): Option[Int32] \ {ef, r} = 
        import java.util.stream.IntStream.findAny(): ##java.util.OptionalInt \ {ef, r};
        let IntStream(_, s1) = s;
        findAny(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def max(s: IntStream[ef, r]): Option[Int32] \ {ef, r} = 
        import java.util.stream.IntStream.max(): ##java.util.OptionalInt \ {ef, r};
        let IntStream(_, s1) = s;
        max(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def min(s: IntStream[ef, r]): Option[Int32] \ {ef, r} = 
        import java.util.stream.IntStream.min(): ##java.util.OptionalInt \ {ef, r};
        let IntStream(_, s1) = s;
        min(s1) |> Interop.Util.OptionalInt.hhToOption

    pub def sorted(s: IntStream[ef, r]): IntStream[ef, r] = 
        import java.util.stream.IntStream.sorted(): ##java.util.stream.IntStream \ {};
        let IntStream(rc, s1) = s;
        IntStream(rc, sorted(s1))


    pub def asLongStream(rc: Region[r1], s: IntStream[ef, r]): LongStream[ef, r1] = 
        import java.util.stream.IntStream.asLongStream(): ##java.util.stream.LongStream \ {};
        let IntStream(_, s1) = s;
        LongStream(rc, asLongStream(s1))

    pub def asDoubleStream(rc: Region[r1], s: IntStream[ef, r]): DoubleStream[ef, r1] = 
        import java.util.stream.IntStream.asDoubleStream(): ##java.util.stream.DoubleStream \ {};
        let IntStream(_, s1) = s;
        DoubleStream(rc, asDoubleStream(s1))

}
