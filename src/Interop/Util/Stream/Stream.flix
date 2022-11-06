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
    /// Represents a Java Stream.
    ///
    pub enum Stream[_a: Type, _r: Region](##java.util.stream.Stream)


    instance Scoped[Stream[a]] {
        pub def regionOf(_: Stream[a, r]): Region[r] = () as Region[r]
    }

}


namespace Interop/Util/Stream/Stream {
    
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}
    use Interop/Util/Stream/Stream.Builder.{Builder}
    use Interop/Util/Function.Consumer
    use Interop/Util/Function.Function
    use Interop/Util/Function.Predicate
    use Interop/Util/Function.Supplier
    use Interop/Util/Function.UnaryOperator    
    use Interop/Flix.Marshal;

    pub def getHH(x: Stream[a, r]): ##java.util.stream.Stream = 
        let Stream(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.util.stream.Stream): Stream[a, r] = 
        Stream(prim)


    pub def empty(_: Region[r]): Stream[a, r] \ Write(r) = 
        import static java.util.stream.Stream.empty(): ##java.util.stream.Stream \ r;
        empty() |> Stream

    pub def builder(_: Region[r]): Builder[a, r] \ Write(r) = 
        import static java.util.stream.Stream.builder(): ##java.util.stream.Stream$Builder \ r;
        builder() |> Builder

    pub def of(_: Region[r], t: a): Stream[a, r] \ Write(r) with Marshal[a] = 
        import static java.util.stream.Stream.of(##java.lang.Object): ##java.util.stream.Stream \ r;
        let t1 = Interop/Flix/Marshal.toJavaObject(t);
        of(t1) |> Stream

    pub def ofNullable(_: Region[r], t: a): Stream[a, r] \ Write(r) with Marshal[a] = 
        import static java.util.stream.Stream.ofNullable(##java.lang.Object): ##java.util.stream.Stream \ r;
        let t1 = Interop/Flix/Marshal.toJavaObject(t);
        ofNullable(t1) |> Stream


    pub def iterate(_: Region[r], seed: a, op: a -> a \ ef): Stream[a, r] \ {Write(r), ef} with Marshal[a] = 
        import static java.util.stream.Stream.iterate(##java.lang.Object, ##java.util.function.UnaryOperator): ##java.util.stream.Stream \ {r, ef};
        let seed1 = Interop/Flix/Marshal.toJavaObject(seed);
        let op1 = Interop/Util/Function/UnaryOperator.makeUnaryOperator(op);
        iterate(seed1, op1) |> Stream


    pub def iterator(s: Stream[a, r]): Iterator[a, r] \ Write(r) with Marshal[a] =
        iteratorWith(Interop/Flix/Marshal.fromJavaObject, s)

    pub def iteratorWith(ocast: ##java.lang.Object -> a, s: Stream[a, r]): Iterator[a, r] \ Write(r) with Marshal[a] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator & r;
        import java.util.Iterator.hasNext(): Bool & r;
        import java.util.Iterator.next(): ##java.lang.Object & r;
        let Stream(s1) = s;
        let iter1 = iterator(s1 as ##java.util.stream.BaseStream);
        let isDone = () -> { 
            let ans = hasNext(iter1);
            not ans
        };
        let getNext = () -> {
            let a1 = next(iter1);
            ocast(a1)
        };
        Iterator(isDone, getNext)

    
    pub def distinct(s: Stream[a, r]): Stream[a, r] \ Write(r) = 
        import java.util.stream.Stream.distinct(): ##java.util.stream.Stream & r;
        let Stream(s1) = s;
        Stream(distinct(s1))

    pub def count(s: Stream[a, r]): Int64 \ Write(r) = 
        import java.util.stream.Stream.count(): Int64 & r;
        let Stream(s1) = s;
        count(s1)

    pub def concat(s: Stream[a, r], t: Stream[a, r]): Stream[a, r] \ Write(r) = 
        import static java.util.stream.Stream.concat(##java.util.stream.Stream, ##java.util.stream.Stream): ##java.util.stream.Stream \ r;
        let Stream(s1) = s;
        let Stream(t1) = t;
        concat(s1, t1) |> Stream

    pub def filter(p: a -> Bool \ ef, s: Stream[a, r]): Stream[a, r] \ {Write(r), ef} with Marshal[a] = 
        import java.util.stream.Stream.filter(Predicate[a]): ##java.util.stream.Stream \ {r, ef};
        let Stream(s1) = s;
        let p1 = Interop/Util/Function/Predicate.makePredicate(p);
        filter(s1, p1) |> Stream

    pub def dropWhile(p: a -> Bool \ ef, s: Stream[a, r]): Stream[a, r] \ {Write(r), ef} with Marshal[a] =
        import java.util.stream.Stream.dropWhile(Predicate[a]): ##java.util.stream.Stream \ {r, ef};
        let Stream(s1) = s;
        let p1 = Interop/Util/Function/Predicate.makePredicate(p);
        dropWhile(s1, p1) |> Stream

    pub def map(f: a -> b \ ef, s: Stream[a, r]): Stream[a, r] \ {Write(r), ef} with Marshal[a], Marshal[b] = 
        import java.util.stream.Stream.map(Function[a, b]): ##java.util.stream.Stream \ {r, ef};
        let Stream(s1) = s;
        let f1 = Interop/Util/Function/Function.makeFunction(f);
        map(s1, f1) |> Stream

    pub def flatMap(f: a -> Stream[b, r] \ ef, s: Stream[a, r]): Stream[b, r] \ {Write(r), ef} with Marshal[a], Marshal[b] = 
        import java.util.stream.Stream.flatMap(Function[a, ##java.util.stream.Stream]): ##java.util.stream.Stream \ {r, ef};
        let Stream(s1) = s;
        let f1 = Interop/Util/Function/Function.makeFunctionWith(f, Interop/Flix/Marshal.fromJavaObject, strm -> strm as ##java.lang.Object);
        (flatMap(s1, f1) as \ {Write(r), ef}) |> Stream



}
