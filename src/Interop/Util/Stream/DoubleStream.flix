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
    pub enum DoubleStream[_r: Region](##java.util.stream.DoubleStream)

    instance Scoped[DoubleStream] {
        pub def regionOf(_: DoubleStream[r]): Region[r] = () as Region[r]
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
        let DoubleStream(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.util.stream.DoubleStream): DoubleStream[r] = DoubleStream(prim)


    pub def doubleStreamIterator(s: DoubleStream[r]): Iterator[Float64, r] \ Write(r) =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator & r;
        let r = Scoped.regionOf(s);
        let DoubleStream(s1) = s;
        let iter1 = iterator(s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(r, iter1);
        Interop/Util/IteratorZ.iterator(iter2)

    pub def empty(_: Region[r]): DoubleStream[r] \ Write(r) = 
        import static java.util.stream.DoubleStream.empty(): ##java.util.stream.DoubleStream \ r;
        empty() |> DoubleStream

    pub def ofFloat64(_: Region[r], i: Float64): DoubleStream[r] \ Write(r) = 
        import static java.util.stream.DoubleStream.of(Float64): ##java.util.stream.DoubleStream \ r;
        of(i) |> DoubleStream

    pub def ofArray(_: Region[r], arr: Array[Float64, r2]): DoubleStream[r] \ {Write(r), Read(r2)} = 
        import static java.util.stream.DoubleStream.of(Array[Float64, r2]): ##java.util.stream.DoubleStream \ {r, r2};
        of(arr) |> DoubleStream

    pub def iterate(_: Region[r], seed: Float64, f: Float64 -> Float64 \ ef): DoubleStream[r] \ {Write(r), ef} = 
        import static java.util.stream.DoubleStream.iterate(Float64, DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {r, ef};
        let f1 = Interop/Util/Function/DoubleUnaryOperator.makeDoubleUnaryOperator(f);
        iterate(seed, f1) |> DoubleStream

    pub def generate(_: Region[r], f: Unit -> Float64 \ ef): DoubleStream[r] \ {Write(r), ef} = 
        import static java.util.stream.DoubleStream.generate(DoubleSupplier): ##java.util.stream.DoubleStream \ r;
        let s1 = Interop/Util/Function/DoubleSupplier.makeDoubleSupplier(f);
        generate(s1) |> DoubleStream


    pub def boxed(s: DoubleStream[r]): Stream[##java.lang.Double, r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.boxed(): ##java.util.stream.Stream \ {r, ef};
        let DoubleStream(s1) = s;
        boxed(s1) |> Stream

    pub def count(s: DoubleStream[r]): Int64 \ Read(r) = 
        import java.util.stream.DoubleStream.count(): Int64 \ r;
        let DoubleStream(s1) = s;
        count(s1)

    pub def concat(s: DoubleStream[r], t: DoubleStream[r]): DoubleStream[r] \ Write(r) = 
        import static java.util.stream.DoubleStream.concat(##java.util.stream.DoubleStream, ##java.util.stream.DoubleStream): ##java.util.stream.DoubleStream \ r;
        let DoubleStream(s1) = s;
        let DoubleStream(t1) = t;
        concat(s1, t1) |> DoubleStream


    pub def filter(p: Float64 -> Bool \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.filter(DoublePredicate): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(s1) = s;
        let p1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(p);
        filter(s1, p1) |> DoubleStream

    pub def dropWhile(p: Float64 -> Bool \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.dropWhile(DoublePredicate): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(s1) = s;
        let p1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(p);
        dropWhile(s1, p1) |> DoubleStream

    pub def map(f: Float64 -> Float64 \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.map(DoubleUnaryOperator): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(s1) = s;
        let f1 = Interop/Util/Function/DoubleUnaryOperator.makeDoubleUnaryOperator(f);
        map(s1, f1) |> DoubleStream

    pub def flatMap(f: Float64 -> DoubleStream[r] \ ef, s: DoubleStream[r]): DoubleStream[r] \ {Write(r), ef} = 
        import java.util.stream.DoubleStream.flatMap(DoubleFunction[##java.util.stream.DoubleStream]): ##java.util.stream.DoubleStream \ {r, ef};
        let DoubleStream(s1) = s;
        let f1 = Interop/Util/Function/DoubleFunction.makeDoubleFunctionWith(f, t -> {let DoubleStream(t1) = t; t1 as ##java.lang.Object});
        (flatMap(s1, f1) as \ {Write(r), ef}) |> DoubleStream


    pub def forEach(f: Float64 -> Unit \ ef, s: DoubleStream[r]): Unit \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.forEach(DoubleConsumer): Unit \ {r, ef};
        let f1 = Interop/Util/Function/DoubleConsumer.makeDoubleConsumer(f);
        let DoubleStream(s1) = s;
        forEach(s1, f1)

    pub def toArray(s: DoubleStream[r]): Array[Float64, r] \ Write(r) = 
        import java.util.stream.DoubleStream.toArray(): Array[Float64, r] \ r;
        let DoubleStream(s1) = s;
        toArray(s1)


    pub def average(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.average(): ##java.util.OptionalDouble \ r;
        let DoubleStream(s1) = s;
        average(s1) |> OptionalDouble

    pub def summaryStatistics(s: DoubleStream[r]): DoubleSummaryStatistics[r] \ Read(r) = 
        import java.util.stream.DoubleStream.summaryStatistics(): ##java.util.DoubleSummaryStatistics \ r;
        let DoubleStream(s1) = s;
        summaryStatistics(s1) |> DoubleSummaryStatistics

    pub def anyMatch(f: Float64 -> Bool \ ef, s: DoubleStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.anyMatch(DoublePredicate): Bool \ {r, ef};
        let DoubleStream(s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: Float64 -> Bool \ ef, s: DoubleStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.allMatch(DoublePredicate): Bool \ {r, ef};
        let DoubleStream(s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        allMatch(s1, f1)


    pub def noneMatch(f: Float64 -> Bool \ ef, s: DoubleStream[r]): Bool \ {Read(r), ef} = 
        import java.util.stream.DoubleStream.noneMatch(DoublePredicate): Bool \ {r, ef};
        let DoubleStream(s1) = s;
        let f1 = Interop/Util/Function/DoublePredicate.makeDoublePredicate(f);
        noneMatch(s1, f1)


    pub def findFirst(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.findFirst(): ##java.util.OptionalDouble \ r;
        let DoubleStream(s1) = s;
        findFirst(s1) |> OptionalDouble

    pub def findAny(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.findAny(): ##java.util.OptionalDouble \ r;
        let DoubleStream(s1) = s;
        findAny(s1) |> OptionalDouble

    pub def max(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.max(): ##java.util.OptionalDouble \ r;
        let DoubleStream(s1) = s;
        max(s1) |> OptionalDouble

    pub def min(s: DoubleStream[r]): OptionalDouble \ Read(r) = 
        import java.util.stream.DoubleStream.min(): ##java.util.OptionalDouble \ r;
        let DoubleStream(s1) = s;
        min(s1) |> OptionalDouble

    pub def sorted(s: DoubleStream[r]): DoubleStream[r] \ Write(r) = 
        import java.util.stream.DoubleStream.sorted(): ##java.util.stream.DoubleStream \ r;
        let DoubleStream(s1) = s;
        sorted(s1) |> DoubleStream
        
}
