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
    /// Represents a Java Function.
    ///
    pub enum Function[_: Type, _: Type, _: Bool](##java.util.function.Function)

    // Don't think we can define a class that UnaryOperator can implement 
    // to show it is a sub-interface.
    // UnaryOperator has to define `toFunction` and `fromFunction` as ordinary functions

}


namespace Interop/Util/Function/Function {
    
    use Interop/Util/Function.Function
    use Interop/Util/Function.Function.{Function}
    use Interop/Flix.Marshal

    pub def getHH(x: Function[a, b, ef]): ##java.util.function.Function = 
        let Function(x1) = x;
        x1




    pub def makeFunction(f: a -> b \ ef): Function[a, b, ef] with Marshal[a], Marshal[b] = 
        let f1 = obj -> {
            let a = Interop/Flix/Marshal.fromJavaObject(obj); 
            let ans = f(a) as \ IO;
            Interop/Flix/Marshal.toJavaObject(ans) 
        };
        Function(f1)

    pub def apply(f: Function[a, b, ef], t: a): b \ ef with Marshal[a], Marshal[b] =
        let Function(f1) = f;
        let obj = Interop/Flix/Marshal.toJavaObject(t);
        let ans = f1(obj) as \ ef;
        Interop/Flix/Marshal.fromJavaObject(ans)
    


    // pub def andThen(f: Function[a, b], g: Function[b, c]): Function[a, c]= 
    //     import java.util.function.Function.andThen(##java.util.function.Function): ##java.util.function.Function \ {};
    //     let Function(f1) = f;
    //     let Function(g1) = g;
    //     andThen(f1, g1) |> Function

    // pub def compose(f: Function[b, c], g: Function[a, b]): Function[a, c] = 
    //     import java.util.function.Function.compose(##java.util.function.Function): ##java.util.function.Function \ {};
    //     let Function(f1) = f;
    //     let Function(g1) = g;
    //     compose(f1, g1) |> Function

}
