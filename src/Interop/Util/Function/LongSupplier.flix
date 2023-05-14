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

mod Interop.Util.Function {

    ///
    /// Represents a Java LongSupplier.
    ///
    /// LongSupplier is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum LongSupplier[_: Eff](##java.util.function.LongSupplier)


}


mod Interop.Util.Function.LongSupplier {
    
    use Interop.Util.Function.LongSupplier
    use Interop.Util.Function.LongSupplier.{LongSupplier}

    pub def makeLongSupplier(f: Unit -> Int64 \ ef): LongSupplier[ef] = 
        LongSupplier(unchecked_cast((new ##java.util.function.LongSupplier {
            def getAsLong(_this: ##java.util.function.LongSupplier): Int64 = f()
        }) as _ \ {}))

    pub def getAsInt(f: LongSupplier[ef]): Int64 \ ef = 
        import java.util.function.LongSupplier.getAsLong(): Int64 \ ef;
        let LongSupplier(f1) = f;
        getAsLong(f1)


}
