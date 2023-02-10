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
    /// Represents a Java IntSummaryStatistics.
    /// Mutable - see combine
    pub enum IntSummaryStatistics[r: Region] { 
        case IntSummaryStatistics(Region[r], ##java.util.IntSummaryStatistics)
    }

}


namespace Interop/Util/IntSummaryStatistics {
    
    use Interop/Util.IntSummaryStatistics
    use Interop/Util.IntSummaryStatistics.{IntSummaryStatistics}
    use Interop/Flix.Marshal

    pub def getHH(ss: IntSummaryStatistics[r]): ##java.util.IntSummaryStatistics = 
        let IntSummaryStatistics(_, ss1) = ss;
        ss1
    
    pub def wrapHH(rc: Region[r], prim: ##java.util.IntSummaryStatistics): IntSummaryStatistics[r] = 
        IntSummaryStatistics(rc, prim)

    pub def toString(ss: IntSummaryStatistics[r]): String \ { Read(r) } =
        import java.util.IntSummaryStatistics.toString(): String \ r;
        let IntSummaryStatistics(_, ss1) = ss;
        ss1 |> toString

    pub def combine!(i: IntSummaryStatistics[r], j: IntSummaryStatistics[r]): Result[String, Unit] \ {Read(r), Write(r)} =
        try {
            import java.util.IntSummaryStatistics.combine(##java.util.IntSummaryStatistics): Unit \ r;
            let IntSummaryStatistics(_, i1) = i;
            let IntSummaryStatistics(_, j1) = j;
            combine(i1, j1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getCount(ss: IntSummaryStatistics[r]): Int64 \ { Read(r) } =
        import java.util.IntSummaryStatistics.getCount(): Int64 \ r;
        let IntSummaryStatistics(_, ss1) = ss;
        ss1 |> getCount
    
    pub def getSum(ss: IntSummaryStatistics[r]): Int64 \ { Read(r) } =
        import java.util.IntSummaryStatistics.getSum(): Int64 \ r;
        let IntSummaryStatistics(_, ss1) = ss;
        ss1 |> getSum    

    pub def getMin(ss: IntSummaryStatistics[r]): Int32 \ { Read(r) } =
        import java.util.IntSummaryStatistics.getMin(): Int32 \ r;
        let IntSummaryStatistics(_, ss1) = ss;
        ss1 |> getMin

    pub def getMax(ss: IntSummaryStatistics[r]): Int32 \ { Read(r) } =
        import java.util.IntSummaryStatistics.getMax(): Int32 \ r;
        let IntSummaryStatistics(_, ss1) = ss;
        ss1 |> getMax

    pub def getAverage(ss: IntSummaryStatistics[r]): Float64 \ { Read(r) } =
        import java.util.IntSummaryStatistics.getAverage(): Float64 \ r;
        let IntSummaryStatistics(_, ss1) = ss;
        ss1 |> getAverage

}
