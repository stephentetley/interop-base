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

    // Interface
    pub enum ChannelZ[_: Region](##java.nio.channels.Channel)

    pub class SubChannel[t: Region -> Type] {
        pub def toChannel(c: t[r]): ChannelZ[r]
        pub def fromChannel(c: ChannelZ[r]): t[r]
    }


}

namespace Interop/NIO/Channels/ChannelZ { 

    use Interop/NIO/Channels.ChannelZ;
    use Interop/NIO/Channels.ChannelZ.{ChannelZ};

    pub def getHH(x: ChannelZ[r]): ##java.nio.channels.Channel = 
        let ChannelZ(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.Channel): ChannelZ[r] =
        ChannelZ(prim)

    pub def isOpen(c: ChannelZ[r]): Bool \ Read(r) =
        import java.nio.channels.Channel.isOpen(): Bool \ r;
        let ChannelZ(c1) = c;
        isOpen(c1)
        
        
    pub def close!(c: ChannelZ[r]): Result[String, Unit] \ Write(r) =
        Result.tryCatch(_ -> {
            import java.nio.channels.Channel.close(): Unit \ r;
            let ChannelZ(c1) = c;
            close(c1)
        })

}
