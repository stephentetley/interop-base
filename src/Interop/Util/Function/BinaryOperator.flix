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
    /// Represents a Java BinaryOperator.
    ///
    /// BinaryOperator is not a builtin functional Interface so it is created as a new object.
    ///
    /// NOTE - type alias not enum
    ///    
    pub type alias BinaryOperator[_: Type] = ##java.util.function.BinaryOperator



}


namespace Interop/Util/Function/BinaryOperator {
    
    use Interop/Util/Function.BinaryOperator
    use Interop/Flix.Marshal
    

    pub def makeBinaryOperator(f: (a, a) -> a \ ef): BinaryOperator[a] \ ef with Marshal[a] = 
        let f1 = (o1, o2) -> {
            let a = Interop/Flix/Marshal.fromJavaObject(o1); 
            let b = Interop/Flix/Marshal.fromJavaObject(o2); 
            let ans = f(a, b);
            Interop/Flix/Marshal.toJavaObject(ans)
        };
        new ##java.util.function.BinaryOperator {
            def apply(_this: ##java.util.function.BinaryOperator, t: ##java.lang.Object, u: ##java.lang.Object): ##java.lang.Object = 
                f1(t, u)
        } as \ ef

        
    pub def apply(t: a, u: a, f: BinaryOperator[a]): a \ ef with Marshal[a] = 
        import java.util.function.BinaryOperator.apply(##java.lang.Object, ##java.lang.Object): ##java.lang.Object \ ef;        
        apply(f, Interop/Flix/Marshal.toJavaObject(t), Interop/Flix/Marshal.toJavaObject(u)) |> Interop/Flix/Marshal.fromJavaObject


}
