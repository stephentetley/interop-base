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
    /// Represents a Java BooleanSupplier.
    ///
    /// BooleanSupplier is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum BooleanSupplier[_: Eff](##java.util.function.BooleanSupplier)


}


mod Interop.Util.Function.BooleanSupplier {
    
    use Interop.Util.Function.BooleanSupplier
    use Interop.Util.Function.BooleanSupplier.{BooleanSupplier}

    pub def makeBooleanSupplier(f: Unit -> Bool \ ef): BooleanSupplier[ef] = 
        BooleanSupplier(unchecked_cast(new ##java.util.function.BooleanSupplier {
            def getAsBoolean(_this: ##java.util.function.BooleanSupplier): Bool = f()
        } as _ \ {}))

    pub def getAsBoolean(f: BooleanSupplier[ef]): Bool \ ef = 
        import java.util.function.BooleanSupplier.getAsBoolean(): Bool \ ef;
        let BooleanSupplier(f1) = f;
        getAsBoolean(f1)


}
