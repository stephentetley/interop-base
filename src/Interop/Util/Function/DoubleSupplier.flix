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

namespace Interop/Util/Function {

    ///
    /// Represents a Java DoubleSupplier.
    ///
    /// DoubleSupplier is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias DoubleSupplier = ##java.util.function.DoubleSupplier


}


namespace Interop/Util/Function/DoubleSupplier {
    
    use Interop/Util/Function.DoubleSupplier

    pub def makeDoubleSupplier(f: Unit -> Float64 \ ef): DoubleSupplier \ ef = 
        unchecked_cast((new ##java.util.function.DoubleSupplier {
            def getAsDouble(_this: ##java.util.function.DoubleSupplier): Float64 = f()
        }) as _ \ ef)

    pub def getAsDouble(f: DoubleSupplier): Float64 \ ef = 
        import java.util.function.DoubleSupplier.getAsDouble(): Float64 \ ef;
        getAsDouble(f)


}
