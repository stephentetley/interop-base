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
    /// Represents a Java ObjDoubleConsumer.
    ///
    /// ObjDoubleConsumer is not a builtin functional Interface so it is created as a new object.
    ///
    /// NOTE - type alias not enum
    ///    
    pub type alias ObjLongConsumer[_: Type] = ##java.util.function.ObjLongConsumer

}


mod Interop.Util.Function.ObjLongConsumer {
    
    use Interop.Util.Function.ObjLongConsumer
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava

    pub def makeObjLongConsumer(f: (a, Int64) -> Unit \ ef): ObjLongConsumer[a] \ ef with ComesFromJava[a] = 
        unchecked_cast((new ##java.util.function.ObjLongConsumer {
            def accept(_this: ##java.util.function.ObjLongConsumer, t: ##java.lang.Object, u: Int64): Unit = 
                f(Interop.Flix.ComesFromJava.fromJavaObject(t), u)
        }) as _ \ ef)

        
    pub def accept(t: a, u: Int64, f: ObjLongConsumer[a]): Unit \ ef with GoesToJava[a] = 
        import java.util.function.ObjLongConsumer.accept(##java.lang.Object, Int64): Unit \ ef;        
        accept(f, Interop.Flix.GoesToJava.toJavaObject(t), u)


}
