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
    
    use Interop.Util.Stream.Collector
    use Interop.Util.Stream.Collector.{Collector}
    use Interop.Util.Function.FunctionZ
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Util.Function.ToDoubleFunction.{ToDoubleFunction}
    use Interop.Util.SetZ

    /// Effects?
    // pub def averagingDouble(fn: a -> Float64 \ ef): Collector[a, t, ef, Float64] = 
    //     import static java.util.stream.Collectors.averagingDouble(##java.util.function.ToDoubleFunction): ##java.util.stream.Collector \ {};
    //     let ToDoubleFunction(fn1) = Interop.Util.Function.ToDoubleFunction.makeToDoubleFunction(fn);
    //     Collector(averagingDouble(fn1))

    pub def counting(): Collector[a, t, ef, Int64] = 
        import static java.util.stream.Collectors.counting(): ##java.util.stream.Collector \ {};
        Collector(counting())


    pub def joining(): Collector[String, t, ef, String] = 
        import static java.util.stream.Collectors.joining(): ##java.util.stream.Collector \ {};
        Collector(joining())

    // pub def joiningWithDelimiter(delim: String): Collector[String, t, Pure, String] = 
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
