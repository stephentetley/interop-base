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

mod Interop.Util {
    
    use Interop.Util.LongSummaryStatistics.{LongSummaryStatistics}

    ///
    /// Represents a Java LongSummaryStatistics.
    /// Mutable - see combine
    pub enum LongSummaryStatistics[_: Region](##java.util.LongSummaryStatistics)


    instance Interop.Flix.MutMarshal[LongSummaryStatistics] {
        pub def mutToJavaObject(x: LongSummaryStatistics[r]): ##java.lang.Object = 
            let LongSummaryStatistics(x1) = x;
            checked_cast(x1)

        pub def mutFromJavaObject(_: Region[r], o: ##java.lang.Object): LongSummaryStatistics[r] = 
            LongSummaryStatistics(unchecked_cast(o as ##java.util.LongSummaryStatistics))
    }

}


mod Interop.Util.LongSummaryStatistics {
    
    use Interop.Util.LongSummaryStatistics
    use Interop.Util.LongSummaryStatistics.{LongSummaryStatistics}
    use Interop.Flix.Marshal

    pub def getHH(ss: LongSummaryStatistics[r]): ##java.util.LongSummaryStatistics = 
        let LongSummaryStatistics(ss1) = ss;
        ss1

    pub def wrapHH(_: Region[r], prim: ##java.util.LongSummaryStatistics): LongSummaryStatistics[r] = 
        LongSummaryStatistics(prim)

    pub def toString(ss: LongSummaryStatistics[r]): String \ { r } =
        import java.util.LongSummaryStatistics.toString(): String \ r;
        let LongSummaryStatistics(ss1) = ss;
        ss1 |> toString

    pub def combine!(i: LongSummaryStatistics[r], j: LongSummaryStatistics[r]): Result[String, Unit] \ r = 
        Result.tryCatch(_ -> {
            import java.util.LongSummaryStatistics.combine(##java.util.LongSummaryStatistics): Unit \ r;
            let LongSummaryStatistics(i1) = i;
            let LongSummaryStatistics(j1) = j;
            combine(i1, j1)
        })

    pub def getCount(ss: LongSummaryStatistics[r]): Int64 \ { r } =
        import java.util.LongSummaryStatistics.getCount(): Int64 \ r;
        let LongSummaryStatistics(ss1) = ss;
        ss1 |> getCount
    
    pub def getSum(ss: LongSummaryStatistics[r]): Int64 \ { r } =
        import java.util.LongSummaryStatistics.getSum(): Int64 \ r;
        let LongSummaryStatistics(ss1) = ss;
        ss1 |> getSum    

    pub def getMin(ss: LongSummaryStatistics[r]): Int64 \ { r } =
        import java.util.LongSummaryStatistics.getMin(): Int64 \ r;
        let LongSummaryStatistics(ss1) = ss;
        ss1 |> getMin

    pub def getMax(ss: LongSummaryStatistics[r]): Int64 \ r = 
        import java.util.LongSummaryStatistics.getMax(): Int64 \ r;
        let LongSummaryStatistics(ss1) = ss;
        ss1 |> getMax

    pub def getAverage(ss: LongSummaryStatistics[r]): Float64 \ { r } =
        import java.util.LongSummaryStatistics.getAverage(): Float64 \ r;
        let LongSummaryStatistics(ss1) = ss;
        ss1 |> getAverage

}
