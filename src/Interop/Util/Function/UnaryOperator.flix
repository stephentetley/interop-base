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
    /// Represents a Java UnaryOperator.
    ///
    /// UnaryOperator is not a builtin functional Interface so it is created as a new object.
    ///
    /// NOTE - type alias not enum
    ///    
    pub type alias UnaryOperator[_: Type] = ##java.util.function.UnaryOperator



}


namespace Interop/Util/Function/UnaryOperator {
    
    use Interop/Util/Function.UnaryOperator
    use Interop/Util/Function.Function
    use Interop/Util/Function.Function.{Function}
    use Interop/Flix.Marshal
    

    pub def makeUnaryOperator(f: a -> a \ ef): UnaryOperator[a] \ ef with Marshal[a] = 
        let f1 = o1 -> {
            let a = Interop/Flix/Marshal.fromJavaObject(o1); 
            let ans = f(a);
            Interop/Flix/Marshal.toJavaObject(ans)
        };
        new ##java.util.function.UnaryOperator {
            def apply(_this: ##java.util.function.UnaryOperator, t: ##java.lang.Object): ##java.lang.Object = 
                f1(t)
        } as \ ef

        
    pub def apply(t: a, f: UnaryOperator[a]): a \ ef with Marshal[a] = 
        import java.util.function.UnaryOperator.apply(##java.lang.Object): ##java.lang.Object \ ef;
        apply(f, Interop/Flix/Marshal.toJavaObject(t)) |> Interop/Flix/Marshal.fromJavaObject

    pub def identity(): UnaryOperator[a] = 
        import static java.util.function.UnaryOperator.identity(): ##java.util.function.UnaryOperator \ {};
        identity()



}
