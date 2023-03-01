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
    pub enum DoubleStream[r: Region] { 
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
    

    pub def getHH(x: DoubleStream[r]): ##java.util.stream.DoubleStream = 
        let DoubleStream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.DoubleStream): DoubleStream[r] = DoubleStream(rc, prim)


    pub def doubleStreamIterator(rc: Region[r1], s: DoubleStream[r]): Iterator[Float64, r1, r1] \ Read(r) =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ r;
        let DoubleStream(_, s1) = s;
        let iter1 = iterator(unsafe_cast s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(rc, iter1);
        Interop/Util/IteratorZ.iterator(rc, iter2)

    pub def empty(rc: Region[r]): DoubleStream[r] \ Write(r) = 
        import static java.util.stream.DoubleStream.empty(): ##java.util.stream.DoubleStream \ r;
        DoubleStream(rc, empty())

    pub def ofFloat64(rc: Region[r], i: Float64): DoubleStream[r] \ Write(r) = 
        import static java.util.stream.DoubleStream.of(Float64): ##java.util.stream.DoubleStream \ r;
        DoubleStream(rc, of(i))

    pub def ofArray(rc: Region[r1], arr: Array[Float64, r]): DoubleStream[r1] \ Read(r) = 
        import static java.util.stream.DoubleStream.of(Array[Float64, r]): ##java.util.stream.DoubleStream \ r;
        DoubleStream(rc, of(arr))

    pub def iterate(rc: Region[r], seed: Float64, f: Float64 -> Float64 \ ef): DoubleStream[r] \ {Write(r), ef} = 
        import static java.util.stream.DoubleStream.iterate(Float64, DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {r, ef};
        let f1 = Interop/Util/Function/DoubleUnaryOperator.makeDoubleUnaryOperator(f);
        DoubleStream(rc, iterate(seed, f1))

    pub def generate(rc: Region[r], f: Unit -> Float64 \ ef): DoubleStream[r] \ {Write(r), ef} = 
        import static java.util.stream.DoubleStream.generate(DoubleSupplier): ##java.util.stream.DoubleStream \ r;
        let s1 = Interop/Util/Function/DoubleSupplier.makeDoubleSupplier(f);
        DoubleStream(rc, generate(s1))


    pub def boxed(rc: Region[r1], s: DoubleStream[r]): Stream[##java.lang.Double, r1] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.boxed(): ##java.util.stream.Stream \ {r, ef};
        let DoubleStream(_, s1) = s;
        Stream(rc, boxed(s1))

    pub def count(s: DoubleStream[r]): Int64 \ Read(r) = 
        import java.util.stream.DoubleStream.count(): Int64 \ r;
        let DoubleStream(_, s1) = s;
        count(s1)

    pub def concat(s: DoubleStream[r], t: DoubleStream[r]): DoubleStream[r] \ Write(r) = 
        import static java.util.stream.DoubleStream.concat(##java.util.stream.DoubleStream, ##java.util.stream.DoubleStream): ##java.util.stream.DoubleStream \ r;
        let DoubleStream(rc, s1) = s;
        let DoubleStream(_, t1) = t;
        DoubleStream(rc, concat(s1, t1))


    pub def filter(p: Float64 -> Bool \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.filter(DoublePredicate): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(rc, s1) = s;
        let p1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(p);
        DoubleStream(rc, filter(s1, p1))

    pub def dropWhile(p: Float64 -> Bool \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.dropWhile(DoublePredicate): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(rc, s1) = s;
        let p1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(p);
        DoubleStream(rc, dropWhile(s1, p1))

    pub def map(f: Float64 -> Float64 \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.map(DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(rc, s1) = s;
        let f1 = Interop/Util/Function/DoubleUnaryOperator.makeDoubleUnaryOperator(f);
        DoubleStream(rc, map(s1, f1))

    pub def flatMap(f: Float64 -> DoubleStream[r] \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.flatMap(DoubleFunction[##java.util.stream.DoubleStream]): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(rc, s1) = s;
        let f1 = Interop/Util/Function/DoubleFunction.makeDoubleFunctionWith(f, t -> {let DoubleStream(_, t1) = t; unsafe_cast t1 as ##java.lang.Object});
        DoubleStream(rc, unsafe_cast (flatMap(s1, f1)) as _ \ {Write(r), ef})


    pub def forEach(f: Float64 -> Unit \ ef, s: DoubleStream[r]): Unit \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.forEach(DoubleConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/DoubleConsumer.makeDoubleConsumer(f);
        let DoubleStream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(s: DoubleStream[r]): Array[Float64, r] \ Write(r) = 
        import java.util.stream.DoubleStream.toArray(): Array[Float64, r] \ r;
        let DoubleStream(_, s1) = s;
        toArray(s1)


    pub def average(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.average(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(_: Region[r1], s: DoubleStream[r]): DoubleSummaryStatistics[r1] \ { Read(r), Write(r1) } = 
        import java.util.stream.DoubleStream.summaryStatistics(): ##java.util.DoubleSummaryStatistics \ { Read(r), Write(r1) };
        let DoubleStream(_, s1) = s;
        DoubleSummaryStatistics(summaryStatistics(s1))

    pub def anyMatch(f: Float64 -> Bool \ ef, s: DoubleStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.anyMatch(DoublePredicate): Bool \ {r, ef};
        let DoubleStream(_, s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Float64 -> Bool \ ef, s: DoubleStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.allMatch(DoublePredicate): Bool \ {r, ef};
        let DoubleStream(_, s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Float64 -> Bool \ ef, s: DoubleStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.noneMatch(DoublePredicate): Bool \ {r, ef};
        let DoubleStream(_, s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        noneMatch(s1, f1)


    pub def findFirst(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.findFirst(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        findFirst(s1) |> OptionalDouble

    pub def findAny(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.findAny(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        findAny(s1) |> OptionalDouble

    pub def max(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.max(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        max(s1) |> OptionalDouble

    pub def min(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.min(): ##java.util.OptionalDouble \ r;
        let DoubleStream(_, s1) = s;
        min(s1) |> OptionalDouble

    pub def sorted(s: DoubleStream[r]): DoubleStream[r] \ Write(r) = 
        import java.util.stream.DoubleStream.sorted(): ##java.util.stream.DoubleStream \ r;
        let DoubleStream(rc, s1) = s;
        DoubleStream(rc, sorted(s1))
        
}
