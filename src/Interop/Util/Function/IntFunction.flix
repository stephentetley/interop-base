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
    /// Represents a Java IntFunction.
    ///
    pub enum IntFunction[_: Type](##java.util.function.IntFunction)


}


namespace Interop/Util/Function/IntFunction {
    
    use Interop/Util/Function.IntFunction;
    use Interop/Util/Function.IntFunction.{IntFunction};
    use Interop/Flix.Marshal;

    pub def getHH(x: IntFunction[a]): ##java.util.function.IntFunction = 
        let IntFunction(x1) = x;
        x1


    pub def makeIntFunction(f: Int32 -> a \ ef): IntFunction[a] \ ef with Marshal[a] = 
        let op1 = 
            new ##java.util.function.IntFunction {
                def apply(_this: ##java.util.function.IntFunction, i: Int32): ##java.lang.Object = 
                    f(i) |> Interop/Flix/Marshal.toJavaObject
            } as \ ef;
        IntFunction(op1)

    pub def apply(i: Int32, f: IntFunction[a]): a with Marshal[a] = 
        import java.util.function.IntFunction.apply(Int32): ##java.lang.Object \ {};
        let IntFunction(f1) = f;
        apply(f1, i) |> Interop/Flix/Marshal.fromJavaObject


}
