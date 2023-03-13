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
    /// Represents a Java ToDoubleBiFunction.
    ///
    /// ToDoubleBiFunction is not a builtin functional Interface so it is created as a new object.
    ///
    pub type alias ToDoubleBiFunction[_: Type, _: Type] = ##java.util.function.ToDoubleBiFunction


}


namespace Interop/Util/Function/ToDoubleBiFunction {
    
    use Interop/Util/Function.ToDoubleBiFunction
    use Interop/Flix.Marshal

    pub def makeToDoubleBiFunction(f: (a, b) -> Float64 \ ef): ToDoubleBiFunction[a, b] \ ef with Marshal[a], Marshal[b] = 
        unchecked_cast((new ##java.util.function.ToDoubleBiFunction {
            def applyAsDouble(_this: ##java.util.function.ToDoubleBiFunction, t: ##java.lang.Object, u: ##java.lang.Object): Float64 = 
                let a1 = Interop/Flix/Marshal.fromJavaObject(t);
                let b1 = Interop/Flix/Marshal.fromJavaObject(u);
                f(a1, b1)
        }) as _ \ ef)


    pub def applyAsDouble(f: ToDoubleBiFunction[a, b], t: a, u: b): Float64 \ ef with Marshal[a], Marshal[b] = 
        import java.util.function.ToDoubleBiFunction.applyAsDouble(##java.lang.Object, ##java.lang.Object): Float64 \ ef;
        applyAsDouble(f, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u))

}
