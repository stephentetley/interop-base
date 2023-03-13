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
    /// TODO should probably include an effect param
    ///
    pub enum Stream[_a: Type, r: Region] { 
        case Stream(Region[r], ##java.util.stream.Stream)
    }

}


namespace Interop/Util/Stream/Stream {
    
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}
    use Interop/Util/Stream.Collector
    use Interop/Util/Stream/Stream.Builder.{Builder}
    use Interop/Util/Function.Consumer
    use Interop/Util/Function.Function
    use Interop/Util/Function.Predicate
    use Interop/Util/Function.Supplier
    use Interop/Util/Function.UnaryOperator    
    use Interop/Flix.Marshal;

    pub def getHH(x: Stream[a, r]): ##java.util.stream.Stream = 
        let Stream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.Stream): Stream[a, r] = 
        Stream(rc, prim)


    pub def empty(rc: Region[r]): Stream[a, r] \ Write(r) = 
        import static java.util.stream.Stream.empty(): ##java.util.stream.Stream \ r;
        Stream(rc, empty())

    pub def builder(rc: Region[r]): Builder[a, r] \ Write(r) = 
        import static java.util.stream.Stream.builder(): ##java.util.stream.Stream$Builder \ r;
        Builder(rc, builder())

    pub def of(rc: Region[r], t: a): Stream[a, r] \ Write(r) with Marshal[a] = 
        import static java.util.stream.Stream.of(##java.lang.Object): ##java.util.stream.Stream \ r;
        let t1 = Interop/Flix/Marshal.toJavaObject(t);
        Stream(rc, of(t1))

    pub def ofArray(rc: Region[r], arr: Array[a, r2]): Stream[a, r] \ {Read(r2), Write(r)} with Marshal[a] = 
        import static java.util.stream.Stream.of(Array[##java.lang.Object, r]): ##java.util.stream.Stream \ { Write(r) };
        let arr1 = Array.map(rc, Interop/Flix/Marshal.toJavaObject, arr);
        Stream(rc, of(arr1))

    pub def ofNullable(rc: Region[r], t: a): Stream[a, r] \ Write(r) with Marshal[a] = 
        import static java.util.stream.Stream.ofNullable(##java.lang.Object): ##java.util.stream.Stream \ r;
        let t1 = Interop/Flix/Marshal.toJavaObject(t);
        Stream(rc, ofNullable(t1))


    pub def iterate(rc: Region[r], seed: a, op: a -> a \ ef): Stream[a, r] \ {Write(r), ef} with Marshal[a] = 
        import static java.util.stream.Stream.iterate(##java.lang.Object, ##java.util.function.UnaryOperator): ##java.util.stream.Stream \ {r, ef};
        let seed1 = Interop/Flix/Marshal.toJavaObject(seed);
        let op1 = Interop/Util/Function/UnaryOperator.makeUnaryOperator(op);
        Stream(rc, iterate(seed1, op1))


    pub def iterator(rc: Region[r1], s: Stream[a, r]): Iterator[a, r, r1] \ { Read(r), Write(r) } with Marshal[a] =
        iteratorWith(rc, Interop/Flix/Marshal.fromJavaObject, s)

    pub def iteratorWith(rc: Region[r1], ocast: ##java.lang.Object -> a, s: Stream[a, r]): Iterator[a, r, r1] \ { Read(r), Write(r) } with Marshal[a] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ { Read(r), Write(r) };
        import java.util.Iterator.hasNext(): Bool \ Read(r);
        import java.util.Iterator.next(): ##java.lang.Object \ Read(r);
        let Stream(_, s1) = s;
        let iter1 = iterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let step = () -> match hasNext(iter1) {
            case true  => next(iter1) |> ocast |> Some
            case false => None
        };
        Iterator.iterate(rc, step)


    pub def distinct(s: Stream[a, r]): Stream[a, r] \ Write(r) = 
        import java.util.stream.Stream.distinct(): ##java.util.stream.Stream & r;
        let Stream(rc, s1) = s;
        Stream(rc, distinct(s1))

    pub def count(s: Stream[a, r]): Int64 \ Write(r) = 
        import java.util.stream.Stream.count(): Int64 & r;
        let Stream(_, s1) = s;
        count(s1)

    pub def concat(s: Stream[a, r], t: Stream[a, r]): Stream[a, r] \ Write(r) = 
        import static java.util.stream.Stream.concat(##java.util.stream.Stream, ##java.util.stream.Stream): ##java.util.stream.Stream \ r;
        let Stream(rc, s1) = s;
        let Stream(_, t1) = t;
        Stream(rc, concat(s1, t1)) 

    pub def filter(p: a -> Bool \ ef, s: Stream[a, r]): Stream[a, r] \ {Write(r), ef} with Marshal[a] = 
        import java.util.stream.Stream.filter(Predicate[a]): ##java.util.stream.Stream \ {r, ef};
        let Stream(rc, s1) = s;
        let p1 = Interop/Util/Function/Predicate.makePredicate(p);
        Stream(rc, filter(s1, p1))

    pub def dropWhile(p: a -> Bool \ ef, s: Stream[a, r]): Stream[a, r] \ {Write(r), ef} with Marshal[a] =
        import java.util.stream.Stream.dropWhile(Predicate[a]): ##java.util.stream.Stream \ {r, ef};
        let Stream(rc, s1) = s;
        let p1 = Interop/Util/Function/Predicate.makePredicate(p);
        Stream(rc, dropWhile(s1, p1))

    pub def map(f: a -> b \ ef, s: Stream[a, r]): Stream[b, r] \ {Write(r), ef} with Marshal[a], Marshal[b] = 
        import java.util.stream.Stream.map(Function[a, b]): ##java.util.stream.Stream \ {r, ef};
        let Stream(rc, s1) = s;
        let f1 = Interop/Util/Function/Function.makeFunction(f);
        Stream(rc, map(s1, f1))

    /// Warning `f1` ...
    pub def flatMap(f: a -> Stream[b, r] \ ef, s: Stream[a, r]): Stream[b, r] \ {Write(r), ef} with Marshal[a], Marshal[b] = 
        import java.util.stream.Stream.flatMap(Function[a, ##java.util.stream.Stream]): ##java.util.stream.Stream \ {r, ef};
        let Stream(rc, s1) = s;
        let f1 = Interop/Util/Function/Function.makeFunctionWith(f, Interop/Flix/Marshal.fromJavaObject, strm -> unchecked_cast(strm as ##java.lang.Object));
        Stream(rc, unchecked_cast(flatMap(s1, f1) as _ \ {Write(r), ef}))



    pub def forEach(f: a -> Unit \ ef, s: Stream[a, r]): Unit \ {Read(r), ef} with Marshal[a] = 
        import java.util.stream.Stream.forEach(Consumer[a]): Unit \ {r, ef};
        let f1 = Interop/Util/Function/Consumer.makeConsumer(f);
        let Stream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(s: Stream[a, r]): Array[a, r] \ Write(r) = 
        import java.util.stream.Stream.toArray(): Array[a, r] \ r;
        let Stream(_, s1) = s;
        toArray(s1)

    pub def anyMatch(f: a -> Bool \ ef, s: Stream[a, r]): Bool \ {Read(r), ef} with Marshal[a] = 
        import java.util.stream.Stream.anyMatch(Predicate[a]): Bool \ {r, ef};
        let Stream(_, s1) = s;
        let f1 = Interop/Util/Function/Predicate.makePredicate(f);
        anyMatch(s1, f1)

    pub def allMatch(f: a -> Bool \ ef, s: Stream[a, r]): Bool \ {Read(r), ef} with Marshal[a] = 
        import java.util.stream.Stream.allMatch(Predicate[a]): Bool \ {r, ef};
        let Stream(_, s1) = s;
        let f1 = Interop/Util/Function/Predicate.makePredicate(f);
        allMatch(s1, f1)

    pub def noneMatch(f: a -> Bool \ ef, s: Stream[a, r]): Bool \ {Read(r), ef} with Marshal[a] = 
        import java.util.stream.Stream.noneMatch(Predicate[a]): Bool \ {r, ef};
        let Stream(_, s1) = s;
        let f1 = Interop/Util/Function/Predicate.makePredicate(f);
        noneMatch(s1, f1)


    pub def findFirst(s: Stream[a, r]): Option[a] \ Read(r) with Marshal[a] = 
        import java.util.stream.Stream.findFirst(): ##java.util.Optional \ r;
        let Stream(_, s1) = s;
        findFirst(s1) |> Interop/Util/Optional.hhToOption(Interop/Flix/Marshal.fromJavaObject)

    pub def findAny(s: Stream[a, r]): Option[a] \ Read(r) with Marshal[a] = 
        import java.util.stream.Stream.findAny(): ##java.util.Optional \ r;
        let Stream(_, s1) = s;
        findAny(s1) |> Interop/Util/Optional.hhToOption(Interop/Flix/Marshal.fromJavaObject)

    pub def collect(c: Collector[t, a, ans], s: Stream[a, r]): ans \ Read(r) with Marshal[ans] = 
        import java.util.stream.Stream.collect(##java.util.stream.Collector): ##java.lang.Object \ r;
        let Stream(_, s1) = s;
        collect(s1, c) |> Interop/Flix/Marshal.fromJavaObject

    pub def collectWith(c: Collector[t, a, ans], s: Stream[a, r], castObjToAns: ##java.lang.Object -> ans): ans \ Read(r) = 
        import java.util.stream.Stream.collect(##java.util.stream.Collector): ##java.lang.Object \ r;
        let Stream(_, s1) = s;
        collect(s1, c) |> castObjToAns


}
