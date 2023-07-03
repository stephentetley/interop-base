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


mod Interop.NIO {

    pub enum ByteBuffer[_: Region](##java.nio.ByteBuffer)

}

mod Interop.NIO.ByteBuffer { 

    use Interop.NIO.ByteBuffer
    use Interop.NIO.ByteBuffer.{ByteBuffer}
    use Interop.NIO.ByteOrder
    use Interop.NIO.ByteOrder.{ByteOrder}
    use Interop.Lang.CharSequence

    pub def getHH(x: ByteBuffer[r]): ##java.nio.ByteBuffer = 
        let ByteBuffer(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.ByteBuffer): ByteBuffer[r] = 
        ByteBuffer(prim)



    pub def allocate(_: Region[r], capacity: Int32): Result[String, ByteBuffer[r]] \ r = 
        Result.tryCatch(_ -> {
            import static java.nio.ByteBuffer.allocate(Int32): ##java.nio.ByteBuffer \ r;
            allocate(capacity) |> ByteBuffer        
        })

    pub def put!(b: Int8, bb: ByteBuffer[r]): Result[String, ByteBuffer[r]] \ r =
        Result.tryCatch(_ -> {
            import java.nio.ByteBuffer.put(Int8): ##java.nio.ByteBuffer \ r;
            let ByteBuffer(bb1) = bb;
            put(bb1, b) |> ByteBuffer
        })

    pub def putArray!(arr: Array[Int8, r2], bb: ByteBuffer[r]): Result[String, ByteBuffer[r]] \ {r, r2} = 
        Result.tryCatch(_ -> {
            import java.nio.ByteBuffer.put(Array[Int8, r2]): ##java.nio.ByteBuffer \ {r, r2};
            let ByteBuffer(bb1) = bb;
            put(bb1, arr) |> ByteBuffer
        })


    pub def appendSubArray!(arr: Array[Int8, r2], 
                            offset: {offset = Int32}, 
                            len: {len = Int32}, 
                            bb: ByteBuffer[r]): Result[String, ByteBuffer[r]] \ {r, r2} = 
        Result.tryCatch(_ -> {
            import java.nio.ByteBuffer.put(Array[Int8, r2], Int32, Int32): ##java.nio.ByteBuffer \ {r, r2};
            let ByteBuffer(bb1) = bb;
            put(bb1, arr, offset.offset, len.len) |> ByteBuffer
        })

    /// returns `this` not a copy
    pub def clear!(bb: ByteBuffer[r]): ByteBuffer[r] \ r = 
        import java.nio.ByteBuffer.clear(): ##java.nio.ByteBuffer \ r;
        let ByteBuffer(bb1) = bb;
        clear(bb1) |> ByteBuffer

    /// returns `this` not a copy
    pub def flip!(bb: ByteBuffer[r]): ByteBuffer[r] \ r =
        import java.nio.ByteBuffer.flip(): ##java.nio.ByteBuffer \ r;
        let ByteBuffer(bb1) = bb;
        flip(bb1) |> ByteBuffer


    pub def order(bb: ByteBuffer[r]): ByteOrder \ r = 
        import java.nio.ByteBuffer.order(): ##java.nio.ByteOrder \ r;
        let ByteBuffer(bb1) = bb;
        order(bb1) |> ByteOrder

    pub def toString(bb: ByteBuffer[r]): String \ r = 
        import java.nio.ByteBuffer.toString(): String \ r;
        let ByteBuffer(bb1) = bb;
        toString(bb1)

}
