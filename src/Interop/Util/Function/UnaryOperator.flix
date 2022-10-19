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
    pub enum UnaryOperator(##java.util.function.UnaryOperator)


}


namespace Interop/Util/Function/UnaryOperator {
    
    use Interop/Util/Function.UnaryOperator
    use Interop/Util/Function.UnaryOperator.{UnaryOperator}
    use Interop/Flix.Marshal
    
    pub def getHH(x: UnaryOperator): ##java.util.function.UnaryOperator = 
        let UnaryOperator(x1) = x;
        x1


    pub def makeUnaryOperator(f: a -> a \ ef): UnaryOperator \ ef with Marshal[a] = 
        let f1 = obj -> {let a = Interop/Flix/Marshal.fromJavaObject(obj); f(a) |> Interop/Flix/Marshal.toJavaObject};
        let op1 = 
            new ##java.util.function.UnaryOperator {
                def apply(_this: ##java.util.function.UnaryOperator, o: ##java.lang.Object): ##java.lang.Object = f1(o)
            } as \ ef;
        UnaryOperator(op1)

        
    pub def apply(t: a, f: UnaryOperator): a with Marshal[a] = 
        import java.util.function.UnaryOperator.apply(##java.lang.Object): ##java.lang.Object \ {};
        let UnaryOperator(f1) = f;
        let t1 = Interop/Flix/Marshal.toJavaObject(t);
        apply(f1, t1) |> Interop/Flix/Marshal.fromJavaObject

    pub def identity(): UnaryOperator = 
        import static java.util.function.UnaryOperator.identity(): ##java.util.function.UnaryOperator \ {};
        identity() |> UnaryOperator

    // pub def andThen(f: UnaryOperator, g: UnaryOperator): UnaryOperator = 
    //     import java.util.function.IntUnaryOperator.andThen(##java.util.function.UnaryOperator): ##java.util.function.UnaryOperator \ {};
    //     let UnaryOperator(f1) = f;
    //     let UnaryOperator(g1) = g;
    //     andThen(f1, g1) |> IntUnaryOperator

    // pub def compose(f: UnaryOperator, g: UnaryOperator): UnaryOperator = 
    //     import java.util.function.UnaryOperator.compose(##java.util.function.UnaryOperator): ##java.util.function.UnaryOperator \ {};
    //     let UnaryOperator(f1) = f;
    //     let UnaryOperator(g1) = g;
    //     compose(f1, g1) |> UnaryOperator

}
