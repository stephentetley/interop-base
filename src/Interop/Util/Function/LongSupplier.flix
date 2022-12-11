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
    /// Represents a Java LongSupplier.
    ///
    /// LongSupplier is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias LongSupplier = ##java.util.function.LongSupplier


}


namespace Interop/Util/Function/LongSupplier {
    
    use Interop/Util/Function.LongSupplier

    pub def makeLongSupplier(f: Unit -> Int64 \ ef): LongSupplier \ ef = 
        unsafe_cast (new ##java.util.function.LongSupplier {
            def getAsLong(_this: ##java.util.function.LongSupplier): Int64 = f()
        }) as _ \ ef

    pub def getAsInt(f: LongSupplier): Int64 \ ef = 
        import java.util.function.LongSupplier.getAsLong(): Int64 \ ef;
        getAsLong(f)


}
