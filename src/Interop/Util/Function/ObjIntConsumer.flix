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
    pub enum ObjIntConsumer[_: Type, _: Eff](##java.util.function.ObjIntConsumer)



}


mod Interop.Util.Function.ObjIntConsumer {
    
    use Interop.Util.Function.ObjIntConsumer
    use Interop.Util.Function.ObjIntConsumer.{ObjIntConsumer}
    use Interop.Flix.GoesToJava

    pub def makeObjIntConsumer(getter: ##java.lang.Object -> a \ ef1, 
                                f: (a, Int32) -> Unit \ ef): ObjIntConsumer[a, ef + ef1] = 
        ObjIntConsumer(unchecked_cast((new ##java.util.function.ObjIntConsumer {
            def accept(_this: ##java.util.function.ObjIntConsumer, t: ##java.lang.Object, u: Int32): Unit = 
                f(getter(t), u)
        }) as _ \ {}))

        
    pub def accept(t: a, u: Int32, f: ObjIntConsumer[a, ef]): Unit \ ef with GoesToJava[a] = 
        import java.util.function.ObjIntConsumer.accept(##java.lang.Object, Int32): Unit \ ef;        
        let ObjIntConsumer(f1) = f;
        accept(f1, Interop.Flix.GoesToJava.toJavaObject(t), u)


}
