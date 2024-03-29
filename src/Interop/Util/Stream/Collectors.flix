/*
 * Copyright 2023 Stephen Tetley
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


mod Interop.Util.Stream.Collectors {

    use Interop.Util.Comparator
    use Interop.Util.Comparator.{Comparator}
    use Interop.Util.ListZ
    use Interop.Util.MapZ
    use Interop.Util.Optional
    use Interop.Util.Stream
    use Interop.Util.Stream.{Stream}
    use Interop.Util.Stream.Collector
    use Interop.Util.Stream.Collector.{Collector}
    use Interop.Util.Function.FunctionZ
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Util.Function.ToDoubleFunction
    use Interop.Util.Function.ToDoubleFunction.{ToDoubleFunction}
    use Interop.Util.Function.ToIntFunction
    use Interop.Util.Function.ToIntFunction.{ToIntFunction}
    use Interop.Util.Function.ToLongFunction
    use Interop.Util.Function.ToLongFunction.{ToLongFunction}
    use Interop.Util.SetZ

    pub def averagingDouble(f: ToDoubleFunction[a, ef]): Collector[a, t, Float64, ef] = 
        import static java.util.stream.Collectors.averagingDouble(##java.util.function.ToDoubleFunction): ##java.util.stream.Collector \ {};
        let ToDoubleFunction(f1) = f;
        Collector(averagingDouble(f1))

    pub def averagingInt(f: ToIntFunction[a, ef]): Collector[a, t, Float64, ef] = 
        import static java.util.stream.Collectors.averagingInt(##java.util.function.ToIntFunction): ##java.util.stream.Collector \ {};
        let ToIntFunction(f1) = f;
        Collector(averagingInt(f1))

    pub def averagingLong(f: ToLongFunction[a, ef]): Collector[a, t, Float64, ef] = 
        import static java.util.stream.Collectors.averagingLong(##java.util.function.ToLongFunction): ##java.util.stream.Collector \ {};
        let ToLongFunction(f1) = f;
        Collector(averagingLong(f1))

    pub def collectingAndThen(downstream: Collector[a, t, ans, ef], finisher: FunctionZ[ans, ans1, ef1]): Collector[a, t, ans1, ef + ef1] = 
        import static java.util.stream.Collectors.collectingAndThen(##java.util.stream.Collector, ##java.util.function.Function): ##java.util.stream.Collector \ {};
        let Collector(c1) = downstream;
        let FunctionZ(f1) = finisher;
        Collector(collectingAndThen(c1, f1))


    pub def counting(): Collector[a, t, Int64, ef] = 
        import static java.util.stream.Collectors.counting(): ##java.util.stream.Collector \ {};
        Collector(counting())

    pub def filtering(f: PredicateZ[a, ef1], downstream: Collector[a, t, ans, ef]): Collector[a, t, ans1, ef + ef1] = 
        import static java.util.stream.Collectors.filtering(##java.util.function.Predicate, ##java.util.stream.Collector): ##java.util.stream.Collector \ {};
        let Collector(c1) = downstream;
        let PredicateZ(f1) = f;
        Collector(filtering(f1, c1))

    /// types need verifying...
    pub def flatMapping(f: FunctionZ[t, Stream[a, ef1, r], ef2], c: Collector[a, t, ans, ef]): Collector[t, t1, ans, ef + ef1 + ef2] = 
        import static java.util.stream.Collectors.flatMapping(##java.util.function.Function, ##java.util.stream.Collector): ##java.util.stream.Collector \ {};
        let Collector(c1) = c;
        let FunctionZ(f1) = f;
        Collector(flatMapping(f1, c1))

    pub def groupingBy(_: Region[r], f: FunctionZ[a, k, ef]): Collector[a, t, MapZ[k, ListZ[a, r], r], ef] = 
        import static java.util.stream.Collectors.groupingBy(##java.util.function.Function): ##java.util.stream.Collector \ {};        
        let FunctionZ(f1) = f;
        Collector(groupingBy(f1))

    pub def joining(): Collector[String, t, String, ef] = 
        import static java.util.stream.Collectors.joining(): ##java.util.stream.Collector \ {};
        Collector(joining())

    // pub def joiningWithDelimiter(delim: String): Collector[String, t, String, ef] = 
    //     import static java.util.stream.Collectors.joining(##java.lang.CharSequence): ##java.util.stream.Collector \ {};
    //     let cs = checked_cast(delim);
    //     Collector(joining(cs))

    // pub def joiningWithEnclosing(delim: {delim = String}, 
    //                                 prefix: {prefix = String}, 
    //                                 suffix: {suffix = String}): Collector[String, t, Pure, String] = 
    //     import static java.util.stream.Collectors.joining(##java.lang.CharSequence, ##java.lang.CharSequence, ##java.lang.CharSequence): ##java.util.stream.Collector \ {};
    //     let d1 = checked_cast(delim.delim);
    //     let p1 = checked_cast(prefix.prefix);
    //     let s1 = checked_cast(suffix.suffix);
    //     Collector(joining(d1, p1, s1))



    pub def maxBy(f: Comparator[a, ef]): Collector[a, t, Optional[a], ef] = 
        import static java.util.stream.Collectors.maxBy(##java.util.Comparator): ##java.util.stream.Collector \ {};
        let Comparator(f1) = f;
        Collector(maxBy(f1))

    pub def minBy(f: Comparator[a, ef]): Collector[a, t, Optional[a], ef] = 
        import static java.util.stream.Collectors.minBy(##java.util.Comparator): ##java.util.stream.Collector \ {};
        let Comparator(f1) = f;
        Collector(minBy(f1))

    /// TODO...
    // // Need to extend the finisher to get from ##java.util.Set to Flix's `Set[a]`
    // pub def toSet(): Collector[a, t, Pure, Set[a]] with Marshal[a], Order[a] = 
    //     import static java.util.stream.Collectors.toSet(): ##java.util.stream.Collector \ {};
    //     let collector = Collector(toSet());
    //     Interop.Util.Stream.Collector.mapFinisher(setFinisher(), collector)


    // def setFinisher(rc: Region[r]): FunctionZ[##java.util.Set, SetZ[a, r], r] = 
    //     let f1 = obj -> {
    //         let s1 = unchecked_cast(obj as ##java.util.Set);
    //         let ans: Set[a] = Interop.Util.SetZ.primSetToFlixSet(s1);
    //         unchecked_cast(ans as ##java.lang.Object) 
    //     };
    //     FunctionZ(unchecked_cast(f1 as ##java.util.function.Function))


}
