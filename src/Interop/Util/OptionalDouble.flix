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
    /// Represents a Java OptionalDouble.
    /// Immutable 
    pub enum OptionalDouble(##java.util.OptionalDouble)


}


namespace Interop/Util/OptionalDouble {
    
    use Interop/Util.OptionalDouble;
    use Interop/Util.OptionalDouble.{OptionalDouble};
    use Interop/Flix.Marshal;

    pub def getHH(o: OptionalDouble): ##java.util.OptionalDouble = 
        let OptionalDouble(o1) = o;
        o1
    
    pub def empty(): OptionalDouble =
        import static java.util.OptionalDouble.empty(): ##java.util.OptionalDouble \ {};
        empty() |> OptionalDouble

}
