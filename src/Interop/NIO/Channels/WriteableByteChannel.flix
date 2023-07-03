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
    pub enum WritableByteChannel[_: Region](##java.nio.channels.WritableByteChannel)

    pub class ImpWritableByteChannel[t: Region -> Type] {
        pub def toWritableByteChannel(c: t[r]): WritableByteChannel[r]
        pub def fromWritableByteChannel(c: WritableByteChannel[r]): t[r]
    }


}

mod Interop.NIO.Channels.WritableByteChannel { 

    use Interop.NIO.Channels.WritableByteChannel
    use Interop.NIO.Channels.WritableByteChannel.{WritableByteChannel}
    use Interop.NIO.ByteBuffer
    use Interop.NIO.ByteBuffer.{ByteBuffer}

    pub def getHH(x: WritableByteChannel[r]): ##java.nio.channels.WritableByteChannel = 
        let WritableByteChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.WritableByteChannel): WritableByteChannel[r] =
        WritableByteChannel(prim)

        
        
    pub def write!(src: ByteBuffer[r1], c: WritableByteChannel[r]): Result[String, Int32] \ r + r1 =
        Result.tryCatch(_ -> {
            import java.nio.channels.WritableByteChannel.write(##java.nio.ByteBuffer): Int32 \ r + r1;
            let WritableByteChannel(c1) = c;
            let ByteBuffer(src1) = src;
            write(c1, src1)
        })

}
