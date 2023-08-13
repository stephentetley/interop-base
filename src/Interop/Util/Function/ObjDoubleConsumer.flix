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
    pub enum ObjDoubleConsumer[_: Type, _: Eff](##java.util.function.ObjDoubleConsumer)



}


mod Interop.Util.Function.ObjDoubleConsumer {
    
    use Interop.Util.Function.ObjDoubleConsumer
    use Interop.Util.Function.ObjDoubleConsumer.{ObjDoubleConsumer}
    use Interop.Flix.GoesToJava

    pub def makeObjDoubleConsumer(getter: ##java.lang.Object -> a \ ef1, 
                                    f: (a, Float64) -> Unit \ ef): ObjDoubleConsumer[a, ef + ef1] = 
        ObjDoubleConsumer(unchecked_cast((new ##java.util.function.ObjDoubleConsumer {
            def accept(_this: ##java.util.function.ObjDoubleConsumer, t: ##java.lang.Object, u: Float64): Unit = 
                f(getter(t), u)
        }) as _ \ {}))

        
    pub def accept(t: a, u: Float64, f: ObjDoubleConsumer[a, ef]): Unit \ ef with GoesToJava[a] = 
        import java.util.function.ObjDoubleConsumer.accept(##java.lang.Object, Float64): Unit \ ef;
        let ObjDoubleConsumer(f1) = f;
        accept(f1, Interop.Flix.GoesToJava.toJavaObject(t), u)


}
