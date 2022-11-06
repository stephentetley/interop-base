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
    /// Represents a Java ToLongBiFunction.
    ///
    /// ToLongBiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias ToLongBiFunction[_: Type, _: Type] = ##java.util.function.ToLongBiFunction


}


namespace Interop/Util/Function/ToLongBiFunction {
    
    use Interop/Util/Function.ToLongBiFunction
    use Interop/Flix.Marshal

    pub def makeToLongBiFunction(f: (a, b) -> Int64 \ ef): ToLongBiFunction[a, b] \ ef with Marshal[a], Marshal[b] = 
        new ##java.util.function.ToLongBiFunction {
            def applyAsLong(_this: ##java.util.function.ToLongBiFunction, t: ##java.lang.Object, u: ##java.lang.Object): Int64 = 
                let a1 = Interop/Flix/Marshal.fromJavaObject(t);
                let b1 = Interop/Flix/Marshal.fromJavaObject(u);
                f(a1, b1)
        } as \ ef


    pub def applyAsInt(f: ToLongBiFunction[a, b], t: a, u: b): Int64 \ ef with Marshal[a], Marshal[b] = 
        import java.util.function.ToLongBiFunction.applyAsLong(##java.lang.Object, ##java.lang.Object): Int64 \ ef;
        applyAsLong(f, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u))

}
