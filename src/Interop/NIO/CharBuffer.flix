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
    use Interop/NIO.ByteOrder;
    use Interop/NIO.ByteOrder.{ByteOrder};
    use Interop/Lang.CharSequence;

    pub def getHH(x: CharBuffer[r]): ##java.nio.CharBuffer = 
        let CharBuffer(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.CharBuffer): CharBuffer[r] = 
        CharBuffer(prim)



    pub def allocate(_: Region[r], capacity: Int32): Result[CharBuffer[r], String] \ Write(r) = 
        try {
            import static java.nio.CharBuffer.allocate(Int32): ##java.nio.CharBuffer \ r;
            allocate(capacity) |> CharBuffer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def append!(c: Char, cb: CharBuffer[r]): Result[CharBuffer[r], String] \ Write(r) = 
        try {
            import java.nio.CharBuffer.append(Char): ##java.nio.CharBuffer \ r;
            let CharBuffer(cb1) = cb;
            append(cb1, c) |> CharBuffer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def appendCharSequence!(cs: CharSequence[r2], cb: CharBuffer[r]): Result[CharBuffer[r], String] \ {Write(r), Read(r2)} = 
        try {
            import java.nio.CharBuffer.append(##java.lang.CharSequence): ##java.nio.CharBuffer \ {r, r2};
            let CharBuffer(cb1) = cb;
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            append(cb1, cs1) |> CharBuffer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def appendSubCharSequence!(cs: CharSequence[r2], 
                                    offset: {offset = Int32}, 
                                    len: {len = Int32}, 
                                    cb: CharBuffer[r]): Result[CharBuffer[r], String] \ {Write(r), Read(r2)} = 
        try {
            import java.nio.CharBuffer.append(##java.lang.CharSequence, Int32, Int32): ##java.nio.CharBuffer \ {r, r2};
            let CharBuffer(cb1) = cb;
            let cs1 = Interop/Lang/CharSequence.getHH(cs);
            append(cb1, cs1, offset.offset, len.len) |> CharBuffer |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    /// returns `this` not a copy
    pub def clear!(cb: CharBuffer[r]): CharBuffer[r] \ Write(r) = 
        import java.nio.CharBuffer.clear(): ##java.nio.CharBuffer \ r;
        let CharBuffer(cb1) = cb;
        clear(cb1) |> CharBuffer

    /// returns `this` not a copy
    pub def flip!(cb: CharBuffer[r]): CharBuffer[r] \ Write(r) = 
        import java.nio.CharBuffer.flip(): ##java.nio.CharBuffer \ r;
        let CharBuffer(cb1) = cb;
        flip(cb1) |> CharBuffer


    pub def order(cb: CharBuffer[r]): ByteOrder \ Read(r) = 
        import java.nio.CharBuffer.order(): ##java.nio.ByteOrder \ r;
        let CharBuffer(cb1) = cb;
        order(cb1) |> ByteOrder

    pub def toString(cb: CharBuffer[r]): String \ Read(r) = 
        import java.nio.CharBuffer.toString(): String \ r;
        let CharBuffer(cb1) = cb;
        toString(cb1)

}
