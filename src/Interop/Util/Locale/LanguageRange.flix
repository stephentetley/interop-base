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

namespace Interop/Util/Locale {


    /// Class / Immutable
    pub enum LanguageRange(##java.util.Locale$LanguageRange)

    instance Interop/Flix.Marshal[LanguageRange] {
        pub def toJavaObject(x: LanguageRange): ##java.lang.Object =
            let LanguageRange(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): LanguageRange = 
            LanguageRange(unchecked_cast(o as ##java.util.Locale$LanguageRange))
    }

}


namespace Interop/Util/Locale/LanguageRange {

    use Interop/Util/Locale.LanguageRange;
    use Interop/Util/Locale.LanguageRange.{LanguageRange};


    pub def getHH(lr: LanguageRange): ##java.util.Locale$LanguageRange = 
        let LanguageRange(lr1) = lr;
        lr1



    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def new(range: String): Result[String, LanguageRange] =
        Result.tryCatch(_ -> {
            import new java.util.Locale$LanguageRange(String): ##java.util.Locale$LanguageRange \ {} as new1;
            LanguageRange(new1(range))
        })

    pub def equals(x: LanguageRange, y: LanguageRange): Bool =
        import java.util.Locale$LanguageRange.equals(##java.lang.Object): Bool \ {};
        let LanguageRange(x1) = x;
        let LanguageRange(y1) = y;
        equals(x1, checked_cast(y1))

    pub def toString(x: LanguageRange): String =
        import java.util.Locale$LanguageRange.toString(): String \ {};
        let LanguageRange(x1) = x;
        toString(x1)

    pub def hashCode(x: LanguageRange): Int32 =
        import java.util.Locale$LanguageRange.hashCode(): Int32 \ {};
        let LanguageRange(x1) = x;
        hashCode(x1)

    pub def maxWeight(): Float64 =
        import static get java.util.Locale$LanguageRange.MAX_WEIGHT: Float64 \ {} as get_MAX_WEIGHT;
        get_MAX_WEIGHT()

    pub def minWeight(): Float64 =
        import static get java.util.Locale$LanguageRange.MIN_WEIGHT: Float64 \ {} as get_MIN_WEIGHT;
        get_MIN_WEIGHT()

    pub def getRange(x: LanguageRange): String =
        import java.util.Locale$LanguageRange.getRange(): String \ {};
        let LanguageRange(x1) = x;
        getRange(x1)

    pub def getWeight(x: LanguageRange): Float64 =
        import java.util.Locale$LanguageRange.getWeight(): Float64 \ {};
        let LanguageRange(x1) = x;
        getWeight(x1)


    pub def parse(ranges: String): Result[String, List[LanguageRange]] = 
        Result.tryCatch(_ -> {
            import static java.util.Locale$LanguageRange.parse(String): ##java.util.List \ {};
            parse(ranges) |> Interop/Util/ListZ.primListToFlixList
        })


    pub def parseWithCustomizations(ranges: String, 
                                    customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] =
        Result.tryCatch(_ -> {
            import static java.util.Locale$LanguageRange.parse(String, ##java.util.Map): ##java.util.List \ {};
            let marshalKey = Interop/Flix/Marshal.toJavaObject;
            let marshalValue = Interop/Util/ListZ.fromFoldableViaArrayListHH >> Interop/Flix/Marshal.unsafeCastToObject;
            let cs1 = Interop/Util/MapZ.fromFlixMapViaHashMapHHWith(marshalKey, marshalValue, customizations);
            parse(ranges, cs1) |> Interop/Util/ListZ.primListToFlixList
        })


    pub def mapEquivalents(priorityList: List[LanguageRange], 
                            customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] =
        Result.tryCatch(_ -> {
            import static java.util.Locale$LanguageRange.mapEquivalents(##java.util.List, ##java.util.Map): ##java.util.List \ {};
            let ps1 = Interop/Util/ListZ.fromFoldableViaArrayListHH(priorityList);
            let marshalKey = Interop/Flix/Marshal.toJavaObject;
            let marshalValue = Interop/Util/ListZ.fromFoldableViaArrayListHH >> Interop/Flix/Marshal.unsafeCastToObject;
            let cs1 = Interop/Util/MapZ.fromFlixMapViaHashMapHHWith(marshalKey, marshalValue, customizations);
            mapEquivalents(ps1, cs1) |> Interop/Util/ListZ.primListToFlixList
        })


}   
