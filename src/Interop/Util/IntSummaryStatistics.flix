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
    pub enum IntSummaryStatistics[_: Region](##java.util.IntSummaryStatistics)


}


namespace Interop/Util/IntSummaryStatistics {
    
    use Interop/Util.IntSummaryStatistics;
    use Interop/Util.IntSummaryStatistics.{IntSummaryStatistics};
    use Interop/Flix.Marshal;

    pub def getHH(o: IntSummaryStatistics[r]): ##java.util.IntSummaryStatistics = 
        let IntSummaryStatistics(o1) = o;
        o1
    
    pub def combine!(i: IntSummaryStatistics[r], j: IntSummaryStatistics[r]): Result[Unit, String] \ {Read(r), Write(r)} =
        try {
            import java.util.IntSummaryStatistics.combine(##java.util.IntSummaryStatistics): Unit \ r;
            let IntSummaryStatistics(i1) = i;
            let IntSummaryStatistics(j1) = j;
            combine(i1, j1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
