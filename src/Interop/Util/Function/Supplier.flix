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
    /// Represents a Java Supplier.
    ///
    /// Supplier is not a builtin functional Interface so it is created as a new object.
    ///
    pub enum Supplier[_: Type, _: Eff](##java.util.function.Supplier)


}


mod Interop.Util.Function.Supplier {
    
    use Interop.Util.Function.Supplier
    use Interop.Util.Function.Supplier.{Supplier}
    use Interop.Flix.Marshal
    use Interop.Flix.ColMarshal

    pub def makeSupplier(f: Unit -> a \ ef): Supplier[a, ef] with Marshal[a] = 
        Supplier(unchecked_cast(new ##java.util.function.Supplier {
            def get(_this: ##java.util.function.Supplier): ##java.lang.Object = 
                f() |> Interop.Flix.Marshal.toJavaObject
        } as _ \ {}))


    pub def makeInitialSupplier[a: Type, r: Region, t: Type -> Region -> Type, ef: Eff]
                                (_: Region[r], f: Unit -> t[a, r] \ ef): Supplier[t[a, r], ef] with ColMarshal[t] = 
        Supplier(unchecked_cast(new ##java.util.function.Supplier {
            def get(_this: ##java.util.function.Supplier): ##java.lang.Object = 
                f() |> Interop.Flix.ColMarshal.colToJavaObject
        } as _ \ {}))


    pub def makeSupplier2(f: Unit -> a \ ef, castToObj: a -> ##java.lang.Object): Supplier[a, ef] = 
        Supplier(unchecked_cast(new ##java.util.function.Supplier {
            def get(_this: ##java.util.function.Supplier): ##java.lang.Object = 
                f() |> castToObj
        } as _ \ {}))

    pub def get(f: Supplier[a, ef]): a \ ef with Marshal[a] = 
        import java.util.function.Supplier.get(): ##java.lang.Object \ ef;
        let Supplier(f1) = f;
        get(f1) |> Interop.Flix.Marshal.fromJavaObject


}
