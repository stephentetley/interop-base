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
    pub enum SourceChannel[_: Region](##java.nio.channels.Pipe$SourceChannel)

    instance Scoped[SourceChannel] {
        pub def regionOf(_: SourceChannel[r]): Region[r] = unsafe_cast () as Region[r]
    }

    instance SubChannel[SourceChannel] {
        pub def toChannel(c: SourceChannel[r]): ChannelZ[r] = 
            let SourceChannel(c1) = c;
            ChannelZ(unsafe_cast c1 as ##java.nio.channels.Channel)

        pub def fromChannel(c: ChannelZ[r]): SourceChannel[r] = 
            let ChannelZ(c1) = c;
            SourceChannel(unsafe_cast c1 as ##java.nio.channels.Pipe$SourceChannel) 
    }
}

namespace Interop/NIO/Channels/Pipe/SourceChannel { 

    use Interop/NIO/Channels/Pipe.SourceChannel;
    use Interop/NIO/Channels/Pipe.SourceChannel.{SourceChannel};

    pub def getHH(x: SourceChannel[r]): ##java.nio.channels.Pipe$SourceChannel = 
        let SourceChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.Pipe$SourceChannel): SourceChannel[r] =
        SourceChannel(prim)



    pub def validOps(c: SourceChannel[r]): Int32 \ Read(r) =
        import java.nio.channels.Pipe$SourceChannel.validOps(): Int32 \ r;
        let SourceChannel(c1) = c;
        validOps(c1)
        


}
