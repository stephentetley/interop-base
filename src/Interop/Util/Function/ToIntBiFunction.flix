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
    /// Represents a Java ToIntBiFunction.
    ///
    /// ToIntBiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias ToIntBiFunction[_: Type, _: Type] = ##java.util.function.ToIntBiFunction


}


namespace Interop/Util/Function/ToIntBiFunction {
    
    use Interop/Util/Function.ToIntBiFunction
    use Interop/Flix.Marshal

    pub def makeToIntBiFunction(f: (a, b) -> Int32 \ ef): ToIntBiFunction[a, b] \ ef with Marshal[a], Marshal[b] = 
        unsafe_cast (new ##java.util.function.ToIntBiFunction {
            def applyAsInt(_this: ##java.util.function.ToIntBiFunction, t: ##java.lang.Object, u: ##java.lang.Object): Int32 = 
                let a1 = Interop/Flix/Marshal.fromJavaObject(t);
                let b1 = Interop/Flix/Marshal.fromJavaObject(u);
                f(a1, b1)
        }) as _ \ ef


    pub def applyAsInt(f: ToIntBiFunction[a, b], t: a, u: b): Int32 \ ef with Marshal[a], Marshal[b] = 
        import java.util.function.ToIntBiFunction.applyAsInt(##java.lang.Object, ##java.lang.Object): Int32 \ ef;
        applyAsInt(f, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u))

}
