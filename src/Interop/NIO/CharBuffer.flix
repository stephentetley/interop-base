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


namespace Interop/NIO {

    pub enum CharBuffer[_: Region](##java.nio.CharBuffer)

}

namespace Interop/NIO/CharBuffer { 

    use Interop/NIO.CharBuffer;
    use Interop/NIO.CharBuffer.{CharBuffer};

    pub def getHH(x: CharBuffer[r]): ##java.nio.CharBuffer = 
        let CharBuffer(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.CharBuffer): CharBuffer[r] = 
        CharBuffer(prim)

    pub def toString(cb: CharBuffer[r]): String \ Read(r) = 
        import java.nio.CharBuffer.toString(): String \ r;
        let CharBuffer(cb1) = cb;
        toString(cb1)

}
