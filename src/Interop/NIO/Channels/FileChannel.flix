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


namespace Interop/NIO/Channels {

    // Abstract Class
    pub enum FileChannel[_: Region](##java.nio.channels.FileChannel)

    instance Scoped[FileChannel] {
        pub def regionOf(_: FileChannel[r]): Region[r] = unsafe_cast () as Region[r]
    }


}

namespace Interop/NIO/Channels/FileChannel { 

    use Interop/NIO/Channels.FileChannel;
    use Interop/NIO/Channels.FileChannel.{FileChannel};

    pub def getHH(x: FileChannel[r]): ##java.nio.channels.FileChannel = 
        let FileChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.FileChannel): FileChannel[r] =
        FileChannel(prim)

    pub def forcez!(metaData: Bool, c: FileChannel[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.nio.channels.FileChannel.force(Bool): Unit \ r as forcez;
            let FileChannel(c1) = c;
            forcez(c1, metaData) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def isOpen(c: FileChannel[r]): Bool \ Read(r) =
        import java.nio.channels.FileChannel.isOpen(): Bool \ r;
        let FileChannel(c1) = c;
        isOpen(c1)
        
    pub def position(c: FileChannel[r]): Result[Int64, String] \ Read(r) =
        try {
            import java.nio.channels.FileChannel.position(): Int64 \ r;
            let FileChannel(c1) = c;
            position(c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def close!(c: FileChannel[r]): Result[Unit, String] \ Write(r) =
        try {
            import java.nio.channels.FileChannel.close(): Unit \ r;
            let FileChannel(c1) = c;
            close(c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
