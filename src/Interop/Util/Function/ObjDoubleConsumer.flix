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
    /// Represents a Java ObjDoubleConsumer.
    ///
    /// ObjDoubleConsumer is not a builtin functional Interface so it is created as a new object.
    ///
    /// NOTE - type alias not enum
    ///    
    pub type alias ObjDoubleConsumer[_: Type] = ##java.util.function.ObjDoubleConsumer



}


namespace Interop/Util/Function/ObjDoubleConsumer {
    
    use Interop/Util/Function.ObjDoubleConsumer
    use Interop/Flix.Marshal

    pub def makeObjDoubleConsumer(f: (a, Float64) -> Unit \ ef): ObjDoubleConsumer[a] \ ef with Marshal[a] = 
        new ##java.util.function.ObjDoubleConsumer {
            def accept(_this: ##java.util.function.ObjDoubleConsumer, t: ##java.lang.Object, u: Float64): Unit = 
                f(Interop/Flix/Marshal.fromJavaObject(t), u)
        } as \ ef

        
    pub def accept(t: a, u: Float64, f: ObjDoubleConsumer[a]): Unit \ ef with Marshal[a] = 
        import java.util.function.ObjDoubleConsumer.accept(##java.lang.Object, Float64): Unit \ ef;        
        accept(f, Interop/Flix/Marshal.toJavaObject(t), u)


}
