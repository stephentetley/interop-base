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

    pub enum LanguageRange(##java.util.Locale$LanguageRange)

    instance Interop/Flix.Marshal[LanguageRange] {
        pub def toJavaObject(x: LanguageRange): ##java.lang.Object =
            let LanguageRange(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): LanguageRange = 
            LanguageRange(unsafe_cast o as ##java.util.Locale$LanguageRange)
    }

}


namespace Interop/Util/Locale/LanguageRange {

    use Interop/Util/Locale.LanguageRange;
    use Interop/Util/Locale.LanguageRange.{LanguageRange};


    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def newLanguageRange(range: String): Result[String, LanguageRange] =
        try {
            import new java.util.Locale$LanguageRange(String): ##java.util.Locale$LanguageRange \ {} as new1;
            LanguageRange(new1(range)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def equals(x: LanguageRange, y: LanguageRange): Bool =
        import java.util.Locale$LanguageRange.equals(##java.lang.Object): Bool \ {};
        let LanguageRange(x1) = x;
        let LanguageRange(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

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
        region r1 {
            try {
                import static java.util.Locale$LanguageRange.parse(String): ##java.util.List \ {};
                let prim = parse(ranges);
                Interop/Util/ListZ.wrapHH(r1, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def parseWithCustomizations(ranges: String, customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] =
        region r1 {
            try {
                import static java.util.Locale$LanguageRange.parse(String, ##java.util.Map): ##java.util.List \ {};
                let cs1 = Interop/Util/HashMap.fromFlixMap(r1, customizations) |> Interop/Util/MapZ.toMapHH;
                let prim = parse(ranges, cs1);
                Interop/Util/ListZ.wrapHH(r1, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def mapEquivalents(priorityList: List[LanguageRange], customizations: Map[String, List[String]]): Result[String, List[LanguageRange]] =
        region r1 {
            try {
                import static java.util.Locale$LanguageRange.mapEquivalents(##java.util.List, ##java.util.Map): ##java.util.List \ {};
                let ps1 = Interop/Util/ArrayList.fromFoldable(r1, priorityList) |> Interop/Util/ListZ.toListHH;
                let cs1 = Interop/Util/HashMap.fromFlixMap(r1, customizations) |> Interop/Util/MapZ.toMapHH;
                let prim = mapEquivalents(ps1, cs1);
                Interop/Util/ListZ.wrapHH(r1, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }


}   
