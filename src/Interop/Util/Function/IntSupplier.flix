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
    /// Represents a Java IntSupplier.
    ///
    /// IntSupplier is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias IntSupplier = ##java.util.function.IntSupplier


}


namespace Interop/Util/Function/IntSupplier {
    
    use Interop/Util/Function.IntSupplier

    pub def makeIntSupplier(f: Unit -> Int32 \ ef): IntSupplier \ ef = 
        new ##java.util.function.IntSupplier {
            def getAsInt(_this: ##java.util.function.IntSupplier): Int32 = f()
        } as \ ef

    pub def getAsInt(f: IntSupplier): Int32 \ ef = 
        import java.util.function.IntSupplier.getAsInt(): Int32 \ ef;
        getAsInt(f)


}
