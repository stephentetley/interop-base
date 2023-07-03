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


mod Interop.NIO.Channels {

    use Interop.NIO.Channels.FileChannel.{FileChannel}
    use Interop.NIO.Channels.ReadableByteChannel.{ReadableByteChannel}
    use Interop.NIO.Channels.WritableByteChannel.{WritableByteChannel}

    // Abstract Class
    pub enum FileChannel[_: Region](##java.nio.channels.FileChannel)

    instance ImpReadableByteChannel[FileChannel] {
        pub def toReadableByteChannel(c: FileChannel[r]): ReadableByteChannel[r] = 
            let FileChannel(c1) = c;
            ReadableByteChannel(unchecked_cast(c1 as ##java.nio.channels.ReadableByteChannel))
        
        pub def fromReadableByteChannel(c: ReadableByteChannel[r]): FileChannel[r] = 
            let ReadableByteChannel(c1) = c;
            FileChannel(unchecked_cast(c1 as ##java.nio.channels.FileChannel))
    }

    instance ImpWritableByteChannel[FileChannel] {
        pub def toWritableByteChannel(c: FileChannel[r]): WritableByteChannel[r] = 
            let FileChannel(c1) = c;
            WritableByteChannel(unchecked_cast(c1 as ##java.nio.channels.WritableByteChannel))
        
        pub def fromWritableByteChannel(c: WritableByteChannel[r]): FileChannel[r] = 
            let WritableByteChannel(c1) = c;
            FileChannel(unchecked_cast(c1 as ##java.nio.channels.FileChannel))
    }

}

mod Interop.NIO.Channels.FileChannel { 

    use Interop.NIO.Channels.FileChannel
    use Interop.NIO.Channels.FileChannel.{FileChannel}

    pub def getHH(x: FileChannel[r]): ##java.nio.channels.FileChannel = 
        let FileChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.FileChannel): FileChannel[r] =
        FileChannel(prim)

    pub def forcez!(metaData: Bool, c: FileChannel[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.nio.channels.FileChannel.force(Bool): Unit \ r as forcez;
            let FileChannel(c1) = c;
            forcez(c1, metaData)
        })


    pub def isOpen(c: FileChannel[r]): Bool \ r =
        import java.nio.channels.FileChannel.isOpen(): Bool \ r;
        let FileChannel(c1) = c;
        isOpen(c1)
        
    pub def position(c: FileChannel[r]): Result[String, Int64] \ r =
        Result.tryCatch(_ -> {
            import java.nio.channels.FileChannel.position(): Int64 \ r;
            let FileChannel(c1) = c;
            position(c1)
        })

    pub def close!(c: FileChannel[r]): Result[String, Unit] \ r =
        Result.tryCatch(_ -> {
            import java.nio.channels.FileChannel.close(): Unit \ r;
            let FileChannel(c1) = c;
            close(c1)
        })

}
