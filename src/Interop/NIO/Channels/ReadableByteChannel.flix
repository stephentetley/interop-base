/*
 * Copyright 2023 Stephen Tetley
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


mod Interop.NIO.Channels {

    // Interface, mutable
    pub enum ReadableByteChannel[_: Region](##java.nio.channels.ReadableByteChannel)

    pub class ImpReadableByteChannel[t: Region -> Type] {
        pub def toReadableByteChannel(c: t[r]): ReadableByteChannel[r]
        pub def fromReadableByteChannel(c: ReadableByteChannel[r]): t[r]
    }


}

mod Interop.NIO.Channels.ReadableByteChannel { 

    use Interop.NIO.Channels.ReadableByteChannel
    use Interop.NIO.Channels.ReadableByteChannel.{ReadableByteChannel}
    use Interop.NIO.ByteBuffer
    use Interop.NIO.ByteBuffer.{ByteBuffer}

    pub def getHH(x: ReadableByteChannel[r]): ##java.nio.channels.ReadableByteChannel = 
        let ReadableByteChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.ReadableByteChannel): ReadableByteChannel[r] =
        ReadableByteChannel(prim)

        
    /// Read into (mutates) `dst`...
    pub def read!(dst: ByteBuffer[r1], c: ReadableByteChannel[r]): Result[String, Int32] \ r + r1 =
        Result.tryCatch(_ -> {
            import java.nio.channels.ReadableByteChannel.read(##java.nio.ByteBuffer): Int32 \ r + r1;
            let ReadableByteChannel(c1) = c;
            let ByteBuffer(dst1) = dst;
            read(c1, dst1)
        })

}
