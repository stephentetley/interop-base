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
    /// Represents a Java Stream.
    /// 
    pub enum Stream[_a: Type, _ef: Eff, r: Region] { 
        case Stream(Region[r], ##java.util.stream.Stream)
    }

}


mod Interop.Util.Stream.Stream {
    
    use Interop.Util.Stream.Stream
    use Interop.Util.Stream.Stream.{Stream}
    use Interop.Util.Stream.Collector
    use Interop.Util.Stream.Collector.{Collector}
    use Interop.Util.Stream.Stream.Builder.{Builder}
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Util.Function.UnaryOperator.{UnaryOperator}
    use Interop.Flix.Marshal;

    pub def getHH(x: Stream[a, ef, r]): ##java.util.stream.Stream = 
        let Stream(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.Stream): Stream[a, ef, r] = 
        Stream(rc, prim)


    pub def empty(rc: Region[r]): Stream[a, ef, r] = 
        import static java.util.stream.Stream.empty(): ##java.util.stream.Stream \ {};
        Stream(rc, checked_ecast(empty()))

    pub def builder(rc: Region[r]): Builder[a, r] \ r = 
        import static java.util.stream.Stream.builder(): ##java.util.stream.Stream$Builder \ r;
        Builder(rc, builder())

    pub def of(rc: Region[r], t: a): Stream[a, ef, r] with Marshal[a] = 
        import static java.util.stream.Stream.of(##java.lang.Object): ##java.util.stream.Stream \ {};
        let t1 = Interop.Flix.Marshal.toJavaObject(t);
        Stream(rc, checked_ecast(of(t1)))

    pub def ofArray(rc: Region[r1], arr: Array[a, r]): Stream[a, ef + r + r1, r1] with Marshal[a] = 
        import static java.util.stream.Stream.of(Array[##java.lang.Object, r1]): ##java.util.stream.Stream \ {};
        let arr1 = unchecked_cast(Array.map(rc, Interop.Flix.Marshal.toJavaObject, arr) as Array[##java.lang.Object, r1] \ {});
        Stream(rc, checked_ecast(of(arr1)))

    pub def ofNullable(rc: Region[r], t: a): Stream[a, ef, r] with Marshal[a] = 
        import static java.util.stream.Stream.ofNullable(##java.lang.Object): ##java.util.stream.Stream \ {};
        let t1 = Interop.Flix.Marshal.toJavaObject(t);
        Stream(rc, checked_ecast(ofNullable(t1)))


    pub def iterate(rc: Region[r], seed: a, op: a -> a \ ef): Stream[a, ef, r] with Marshal[a] = 
        import static java.util.stream.Stream.iterate(##java.lang.Object, ##java.util.function.UnaryOperator): ##java.util.stream.Stream \ {};
        let seed1 = Interop.Flix.Marshal.toJavaObject(seed);
        let UnaryOperator(op1) = Interop.Util.Function.UnaryOperator.makeUnaryOperator(op);
        Stream(rc, checked_ecast(iterate(seed1, op1)))


    pub def iterator(rc: Region[r1], s: Stream[a,  ef, r]): Iterator[a, ef + r + r1, r1] with Marshal[a] =
        iteratorWith(rc, Interop.Flix.Marshal.fromJavaObject, s)

    pub def iteratorWith(rc: Region[r1], ocast: ##java.lang.Object -> a, s: Stream[a, ef, r]): Iterator[a, ef + r + r1, r1] with Marshal[a] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ {} as mkIterator;
        import java.util.Iterator.hasNext(): Bool \ r;
        import java.util.Iterator.next(): ##java.lang.Object \ r;
        let Stream(_, s1) = s;
        let iter1 = mkIterator(unchecked_cast(s1 as ##java.util.stream.BaseStream));
        let step = () -> checked_ecast(match hasNext(iter1) {
            case true  => next(iter1) |> ocast |> Some
            case false => None
        });
        Iterator.iterate(rc, step)


    pub def distinct(s: Stream[a, ef, r]): Stream[a, ef, r] = 
        import java.util.stream.Stream.distinct(): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        Stream(rc, distinct(s1))

    pub def count(s: Stream[a, ef, r]): Int64 \ {ef, r} = 
        import java.util.stream.Stream.count(): Int64 \ {ef, r};
        let Stream(_, s1) = s;
        count(s1)

    pub def concat(s: Stream[a, ef1, r], t: Stream[a, ef2, r]): Stream[a, ef1 + ef2, r] = 
        import static java.util.stream.Stream.concat(##java.util.stream.Stream, ##java.util.stream.Stream): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        let Stream(_, t1) = t;
        Stream(rc, checked_ecast(concat(s1, t1)))

    pub def filter(p: a -> Bool \ ef1, s: Stream[a, ef, r]): Stream[a, ef + ef1, r] with Marshal[a] = 
        import java.util.stream.Stream.filter(##java.util.function.Predicate): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        let PredicateZ(p1) = Interop.Util.Function.PredicateZ.makePredicateZ(p);
        Stream(rc, checked_ecast(filter(s1, p1)))

    pub def dropWhile(p: a -> Bool \ ef1, s: Stream[a, ef, r]): Stream[a, ef + ef1, r] with Marshal[a] =
        import java.util.stream.Stream.dropWhile(##java.util.function.Predicate): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        let PredicateZ(p1) = Interop.Util.Function.PredicateZ.makePredicateZ(p);
        Stream(rc, checked_ecast(dropWhile(s1, p1)))

    pub def limit(size: Int64, s: Stream[a, ef, r]): Stream[a, ef, r] = 
        import java.util.stream.Stream.limit(Int64): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        Stream(rc, checked_ecast(limit(s1, size)))

    pub def map(f: a -> b \ ef, s: Stream[a, ef, r]): Stream[b, ef + ef1, r] with Marshal[a], Marshal[b] = 
        import java.util.stream.Stream.map(##java.util.function.Function): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        let FunctionZ(f1) =Interop.Util.Function.FunctionZ.makeFunctionZ(f);
        Stream(rc, checked_ecast(map(s1, f1)))

    /// Warning `f1` ...
    pub def flatMap(f: a -> Stream[b, ef1, r] \ ef2, s: Stream[a, ef, r]): Stream[b, ef + ef1 + ef2, r] with Marshal[a], Marshal[b] = 
        import java.util.stream.Stream.flatMap(##java.util.function.Function): ##java.util.stream.Stream \ {};
        let Stream(rc, s1) = s;
        let FunctionZ(f1) = Interop.Util.Function.FunctionZ.makeFunctionZWith(f, Interop.Flix.Marshal.fromJavaObject, strm -> unchecked_cast(strm as ##java.lang.Object));
        Stream(rc, checked_ecast(flatMap(s1, f1)))

    pub def forEach[a: Type, ef: Eff, ef1: Region, r: Region]
                    (f: a -> Unit \ ef1, s: Stream[a, ef, r]): Unit \ {ef, ef1, r} with Marshal[a] = 
        import java.util.stream.Stream.forEach(##java.util.function.Consumer): Unit \ {ef, ef1, r};
        let ConsumerZ(f1) = Interop.Util.Function.ConsumerZ.makeConsumerZ(f);
        let Stream(_, s1) = s;
        forEach(s1, f1)

    pub def toArray(_: Region[r1], s: Stream[a, ef, r]): Array[a, r1] \ { ef, r, r1} =  
        import java.util.stream.Stream.toArray(): Array[a, r1] \ {};
        let Stream(_, s1) = s;
        checked_ecast(toArray(s1))

    pub def anyMatch[a: Type, ef: Eff, ef1: Eff, r: Region]
                    (f: a -> Bool \ ef1, s: Stream[a, ef, r]): Bool \ {ef, ef1, r} with Marshal[a] = 
        import java.util.stream.Stream.anyMatch(##java.util.function.Predicate): Bool \ {r, ef, ef1};
        let Stream(_, s1) = s;
        let PredicateZ(f1) = Interop.Util.Function.PredicateZ.makePredicateZ(f);
        anyMatch(s1, f1)

    pub def allMatch[a: Type, ef: Eff, ef1: Eff, r: Region]
                    (f: a -> Bool \ ef1, s: Stream[a, ef, r]): Bool \ {ef, ef1, r} with Marshal[a] = 
        import java.util.stream.Stream.allMatch(##java.util.function.Predicate): Bool \ {r, ef, ef1};
        let Stream(_, s1) = s;
        let PredicateZ(f1) = Interop.Util.Function.PredicateZ.makePredicateZ(f);
        allMatch(s1, f1)

    pub def noneMatch[a: Type, ef: Eff, ef1: Eff, r: Region]
                        (f: a -> Bool \ ef1, s: Stream[a, ef, r]): Bool \ {ef, ef1, r} with Marshal[a] = 
        import java.util.stream.Stream.noneMatch(##java.util.function.Predicate): Bool \ {r, ef, ef1};
        let Stream(_, s1) = s;
        let PredicateZ(f1) = Interop.Util.Function.PredicateZ.makePredicateZ(f);
        noneMatch(s1, f1)


    pub def findFirst(s: Stream[a, ef, r]): Option[a] \ {ef, r} with Marshal[a] = 
        import java.util.stream.Stream.findFirst(): ##java.util.Optional \ {ef, r};
        let Stream(_, s1) = s;
        findFirst(s1) |> Interop.Util.Optional.hhToOption(Interop.Flix.Marshal.fromJavaObject)

    pub def findAny(s: Stream[a, ef, r]): Option[a] \ {ef, r} with Marshal[a] = 
        import java.util.stream.Stream.findAny(): ##java.util.Optional \ {ef, r};
        let Stream(_, s1) = s;
        findAny(s1) |> Interop.Util.Optional.hhToOption(Interop.Flix.Marshal.fromJavaObject)


    pub def collect(c: Collector[t, a, ans], s: Stream[a, ef, r]): ans \ {ef, r} with Marshal[ans] = 
        import java.util.stream.Stream.collect(##java.util.stream.Collector): ##java.lang.Object \ {ef, r};
        let Stream(_, s1) = s;
        let Collector(c1) = c;
        collect(s1, c1) |> Interop.Flix.Marshal.fromJavaObject

    pub def collectWith(c: Collector[t, a, ans], s: Stream[a, ef, r], ocast: ##java.lang.Object -> ans): ans \ {ef, r} = 
        import java.util.stream.Stream.collect(##java.util.stream.Collector): ##java.lang.Object \ {ef, r};
        let Stream(_, s1) = s;
        let Collector(c1) = c;
        collect(s1, c1) |> ocast

}
