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

namespace Interop/Util {

    ///
    /// Represents a Java DoubleSummaryStatistics.
    /// Mutable - see combine
    pub enum DoubleSummaryStatistics[_: Region](##java.util.DoubleSummaryStatistics)


}


namespace Interop/Util/DoubleSummaryStatistics {
    
    use Interop/Util.DoubleSummaryStatistics
    use Interop/Util.DoubleSummaryStatistics.{DoubleSummaryStatistics}
    use Interop/Flix.Marshal

    pub def getHH(o: DoubleSummaryStatistics[r]): ##java.util.DoubleSummaryStatistics = 
        let DoubleSummaryStatistics(o1) = o;
        o1
    

    pub def toString(ss: DoubleSummaryStatistics[r]): String \ { Read(r) } =
        import java.util.DoubleSummaryStatistics.toString(): String \ r;
        let DoubleSummaryStatistics(ss1) = ss;
        ss1 |> toString

    pub def combine!(i: DoubleSummaryStatistics[r], j: DoubleSummaryStatistics[r]): Result[Unit, String] \ {Read(r), Write(r)} =
        try {
            import java.util.DoubleSummaryStatistics.combine(##java.util.DoubleSummaryStatistics): Unit \ r;
            let DoubleSummaryStatistics(i1) = i;
            let DoubleSummaryStatistics(j1) = j;
            combine(i1, j1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getCount(ss: DoubleSummaryStatistics[r]): Int64 \ { Read(r) } =
        import java.util.DoubleSummaryStatistics.getCount(): Int64 \ r;
        let DoubleSummaryStatistics(ss1) = ss;
        ss1 |> getCount
    
    pub def getSum(ss: DoubleSummaryStatistics[r]): Float64 \ { Read(r) } =
        import java.util.DoubleSummaryStatistics.getSum(): Float64 \ r;
        let DoubleSummaryStatistics(ss1) = ss;
        ss1 |> getSum    

    pub def getMin(ss: DoubleSummaryStatistics[r]): Float64 \ { Read(r) } =
        import java.util.DoubleSummaryStatistics.getMin(): Float64 \ r;
        let DoubleSummaryStatistics(ss1) = ss;
        ss1 |> getMin

    pub def getMax(ss: DoubleSummaryStatistics[r]): Float64 \ { Read(r) } =
        import java.util.DoubleSummaryStatistics.getMax(): Float64 \ r;
        let DoubleSummaryStatistics(ss1) = ss;
        ss1 |> getMax

    pub def getAverage(ss: DoubleSummaryStatistics[r]): Float64 \ { Read(r) } =
        import java.util.DoubleSummaryStatistics.getAverage(): Float64 \ r;
        let DoubleSummaryStatistics(ss1) = ss;
        ss1 |> getAverage

}
