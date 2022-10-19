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
    pub enum IntFunction[_: Bool, _: Type](##java.util.function.IntFunction)


    

}

// Note - this module may be dropped as IntFunction now builtin
namespace Interop/Util/Function/IntFunction {
    
    use Interop/Util/Function.IntFunction;
    use Interop/Util/Function.IntFunction.{IntFunction};
    use Interop/Flix.Marshal;

    pub def getHH(x: IntFunction[ef, a]): ##java.util.function.IntFunction = 
        let IntFunction(x1) = x;
        x1


    pub def makeIntFunction(f: Int32 -> a \ ef): IntFunction[ef, a] with Marshal[a] = 
        let op1 = i -> (f(i) |> Interop/Flix/Marshal.toJavaObject) as \ IO;
        IntFunction(op1)

    pub def apply(i: Int32, f: IntFunction[ef, a]): a \ ef with Marshal[a] = 
        let IntFunction(f1) = f;
        (f1(i) as \ ef) |> Interop/Flix/Marshal.fromJavaObject


}
