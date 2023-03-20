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
    /// Represents a Java DoubleStream.
    ///
    pub enum DoubleStream[_: Bool, r: Region] { 
        case DoubleStream(Region[r], ##java.util.stream.DoubleStream)
    }


}


namespace Interop/Util/Stream/DoubleStream {
    
    use Interop/Util/Stream.DoubleStream
    use Interop/Util/Stream.DoubleStream.{DoubleStream}
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}
    use Interop/Util.DoubleSummaryStatistics
    use Interop/Util.DoubleSummaryStatistics.{DoubleSummaryStatistics}
    use Interop/Util.OptionalDouble
    use Interop/Util.OptionalDouble.{OptionalDouble}
    use Interop/Util/Function.DoubleConsumer
    use Interop/Util/Function.DoubleFunction
    use Interop/Util/Function.DoublePredicate
    use Interop/Util/Function.DoubleSupplier
    use Interop/Util/Function.DoubleUnaryOperator
    

    pub def getHH(x: DoubleStream[ef, r]): ##java.util.stream.DoubleStream = 
        let DoubleStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.DoubleStream): DoubleStream[ef, r] = DoubleStream(rc, prim)


    pub def doubleStreamIterator(rc: Region[r1], s: DoubleStream[ef, r]): Iterator[Int64, ef and r and r1, r1] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {} as mkIterator;
        let DoubleStream(_, s1) = s;
        let iter1 = mkIterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let iter2 = checked_ecast(Interop/Util/IteratorZ.wrapHH(rc, iter1));
        Interop/Util/IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.empty(): ##java.util.stream.DoubleStream \ {};
        DoubleStream(rc, checked_ecast(empty()))

    pub def ofFloat64(rc: Region[r], i: Float64): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.of(Float64): ##java.util.stream.DoubleStream \ {};
        DoubleStream(rc, checked_ecast(of(i)))

    pub def ofArray(rc: Region[r1], arr: Array[Float64, r]): DoubleStream[ef, r1] = 
        import static java.util.stream.DoubleStream.of(Array[Float64, r]): ##java.util.stream.DoubleStream \ {};
        DoubleStream(rc, checked_ecast(of(arr)))

    pub def iterate(rc: Region[r], seed: Float64, f: Float64 -> Float64 \ ef): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.iterate(Float64, DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {};
        let f1 = unchecked_cast(Interop/Util/Function/DoubleUnaryOperator.makeDoubleUnaryOperator(f) as _ \ {});
        DoubleStream(rc, checked_ecast(iterate(seed, f1)))

    pub def generate(rc: Region[r], f: Unit -> Float64 \ ef): DoubleStream[ef, r] = 
        import static java.util.stream.DoubleStream.generate(DoubleSupplier): ##java.util.stream.DoubleStream \ {};
        let s1 = unchecked_cast(Interop/Util/Function/DoubleSupplier.makeDoubleSupplier(f) as _ \ {});
        DoubleStream(rc, checked_ecast(generate(s1)))


    pub def boxed(rc: Region[r1], s: DoubleStream[ef, r]): Stream[##java.lang.Double, r1] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.boxed(): ##java.util.stream.Stream \ {r, ef};
        let DoubleStream(_, s1) = s;
        Stream(rc, boxed(s1))

    pub def count(s: DoubleStream[ef, r]): Int64 \ {ef, Read(r)} = 
        import java.util.stream.DoubleStream.count(): Int64 \ {ef, r};
        let DoubleStream(_, s1) = s;
        count(s1)

    pub def concat(s: DoubleStream[ef1, r], t: DoubleStream[ef2, r]): DoubleStream[ef1 and ef2, r] = 
        import static java.util.stream.DoubleStream.concat(##java.util.stream.DoubleStream, ##java.util.stream.DoubleStream): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let DoubleStream(_, t1) = t;
        DoubleStream(rc, checked_ecast(concat(s1, t1)))


    pub def filter(p: Float64 -> Bool \ ef1, s: DoubleStream[ef, r]): DoubleStream[ef and ef1, r] = 
        import java.util.stream.DoubleStream.filter(DoublePredicate): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let p1 = unchecked_cast(Interop/Util/Function/DoublePredicate.makeDoublePredicate(p) as _ \ {});
        DoubleStream(rc, checked_ecast(filter(s1, p1)))

    pub def dropWhile(p: Float64 -> Bool \ ef1, s: DoubleStream[ef, r]): DoubleStream[ef and ef1, r] = 
        import java.util.stream.DoubleStream.dropWhile(DoublePredicate): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let p1 = unchecked_cast(Interop/Util/Function/DoublePredicate.makeDoublePredicate(p) as _ \ {});
        DoubleStream(rc, checked_ecast(dropWhile(s1, p1)))

    pub def map(f: Float64 -> Float64 \ ef1, s: DoubleStream[ef, r]): DoubleStream[ef and ef1, r] = 
        import java.util.stream.DoubleStream.map(DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let f1 = unchecked_cast(Interop/Util/Function/DoubleUnaryOperator.makeDoubleUnaryOperator(f) as _ \ {});
        DoubleStream(rc, checked_ecast(map(s1, f1)))

    pub def flatMap(f: Float64 -> DoubleStream[ef, r] \ ef, s: DoubleStream[ef, r]): DoubleStream[ef, r] = 
        import java.util.stream.DoubleStream.flatMap(DoubleFunction[##java.util.stream.DoubleStream]): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        let f1 = unchecked_cast(Interop/Util/Function/DoubleFunction.makeDoubleFunctionWith(f, t -> {let DoubleStream(_, t1) = t; unchecked_cast(t1 as ##java.lang.Object)}) as _ \ {});
        DoubleStream(rc, checked_ecast(flatMap(s1, f1)))


    pub def forEach(f: Float64 -> Unit \ ef1, s: DoubleStream[ef, r]): Unit \ {ef, ef1, Read(r)} = 
        import java.util.stream.DoubleStream.forEach(DoubleConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/DoubleConsumer.makeDoubleConsumer(f);
        let DoubleStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(s: DoubleStream[ef, r]): Array[Float64, r] \ Write(r) = 
        import java.util.stream.DoubleStream.toArray(): Array[Float64, r] \ r;
        let DoubleStream(_, s1) = s;
        toArray(s1)


    pub def average(s: DoubleStream[ef, r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.average(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: DoubleStream[ef, r]): DoubleSummaryStatistics[r1] \ { ef, Read(r), Write(r1) } = 
        import java.util.stream.DoubleStream.summaryStatistics(): ##java.util.DoubleSummaryStatistics \ { ef, Read(r), Write(r1) };
        let DoubleStream(_, s1) = s;
        DoubleSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch(f: Float64 -> Bool \ ef1, s: DoubleStream[ef, r]): Bool \ {ef, ef1, Read(r)} = 
        import java.util.stream.DoubleStream.anyMatch(DoublePredicate): Bool \ {ef, ef1, r};
        let DoubleStream(_, s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Float64 -> Bool \ ef1, s: DoubleStream[ef, r]): Bool \ {ef, ef1, Read(r)} = 
        import java.util.stream.DoubleStream.allMatch(DoublePredicate): Bool \ {ef, ef1, r};
        let DoubleStream(_, s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Float64 -> Bool \ ef1, s: DoubleStream[ef, r]): Bool \ {ef, ef1, Read(r)} = 
        import java.util.stream.DoubleStream.noneMatch(DoublePredicate): Bool \ {ef, ef1, r};
        let DoubleStream(_, s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        noneMatch(s1, f1)


    pub def findFirst(s: DoubleStream[ef, r]): OptionalDouble \ {ef, Read(r)} = 
        import java.util.stream.DoubleStream.findFirst(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        findFirst(s1) |> OptionalDouble

    pub def findAny(s: DoubleStream[ef, r]): OptionalDouble \ {ef, Read(r)} = 
        import java.util.stream.DoubleStream.findAny(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        findAny(s1) |> OptionalDouble

    pub def max(s: DoubleStream[ef, r]): OptionalDouble \ {ef, Read(r)} = 
        import java.util.stream.DoubleStream.max(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        max(s1) |> OptionalDouble

    pub def min(s: DoubleStream[ef, r]): OptionalDouble \ {ef, Read(r)} = 
        import java.util.stream.DoubleStream.min(): ##java.util.OptionalDouble \ {ef, r};
        let DoubleStream(_, s1) = s;
        min(s1) |> OptionalDouble

    pub def sorted(s: DoubleStream[ef, r]): DoubleStream[ef, r] = 
        import java.util.stream.DoubleStream.sorted(): ##java.util.stream.DoubleStream \ {};
        let DoubleStream(rc, s1) = s;
        DoubleStream(rc, checked_ecast(sorted(s1)))
        
}
