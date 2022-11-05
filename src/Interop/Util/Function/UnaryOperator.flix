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
    pub enum UnaryOperator[_: Type, _: Bool](##java.util.function.UnaryOperator)



}


namespace Interop/Util/Function/UnaryOperator {
    
    use Interop/Util/Function.UnaryOperator
    use Interop/Util/Function.UnaryOperator.{UnaryOperator}
    use Interop/Util/Function.Function
    use Interop/Util/Function.Function.{Function}
    use Interop/Flix.Marshal
    
    pub def getHH(x: UnaryOperator[a, ef]): ##java.util.function.UnaryOperator = 
        let UnaryOperator(x1) = x;
        x1


    pub def makeUnaryOperator(f: a -> a \ ef): UnaryOperator[a, ef] with Marshal[a] = 
        /// f1 is "seen" as a ##java.util.function.Function
        let f1 = obj -> {
            let a = Interop/Flix/Marshal.fromJavaObject(obj); 
            let ans = f(a) as \ IO;
            Interop/Flix/Marshal.toJavaObject(ans) 
        };
        UnaryOperator(f1 as ##java.util.function.UnaryOperator)

        
    pub def apply(t: a, f: UnaryOperator[a, ef]): a \ ef with Marshal[a] = 
        import java.util.function.UnaryOperator.apply(##java.lang.Object): ##java.lang.Object \ {};
        let UnaryOperator(f1) = f;
        let t1 = Interop/Flix/Marshal.toJavaObject(t);
        let ans = apply(f1, t1) as \ ef;
        Interop/Flix/Marshal.fromJavaObject(ans)

    // pub def identity(): UnaryOperator[a] = 
    //     import static java.util.function.UnaryOperator.identity(): ##java.util.function.UnaryOperator \ {};
    //     identity() |> UnaryOperator



    // pub def toFunction(op: UnaryOperator[a]): Function[a, a] = 
    //     let UnaryOperator(op1) = op;
    //     Function(op1 as ##java.util.function.Function)

    pub def fromFunction(f: Function[a, a, ef]): UnaryOperator[a, ef] = 
        let Function(f1) = f;
        UnaryOperator(f1 as ##java.util.function.UnaryOperator)




}
