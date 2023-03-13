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


namespace Interop/NIO/Channels/Pipe {

    use Interop/NIO/Channels.ChannelZ
    use Interop/NIO/Channels.ChannelZ.{ChannelZ}
    use Interop/NIO/Channels.SubChannel

    // Abstract Class
    pub enum SinkChannel[_: Region](##java.nio.channels.Pipe$SinkChannel)

    instance SubChannel[SinkChannel] {
        pub def toChannel(c: SinkChannel[r]): ChannelZ[r] = 
            let SinkChannel(c1) = c;
            ChannelZ(unchecked_cast(c1 as ##java.nio.channels.Channel))

        pub def fromChannel(c: ChannelZ[r]): SinkChannel[r] = 
            let ChannelZ(c1) = c;
            SinkChannel(unchecked_cast(c1 as ##java.nio.channels.Pipe$SinkChannel))
    }

}

namespace Interop/NIO/Channels/Pipe/SinkChannel { 

    use Interop/NIO/Channels/Pipe.SinkChannel;
    use Interop/NIO/Channels/Pipe.SinkChannel.{SinkChannel};

    pub def getHH(x: SinkChannel[r]): ##java.nio.channels.Pipe$SinkChannel = 
        let SinkChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.Pipe$SinkChannel): SinkChannel[r] =
        SinkChannel(prim)


    pub def validOps(c: SinkChannel[r]): Int32 \ Read(r) =
        import java.nio.channels.Pipe$SinkChannel.validOps(): Int32 \ r;
        let SinkChannel(c1) = c;
        validOps(c1)

}
