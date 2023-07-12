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

    use Interop.NIO.Channels.PipeSinkChannel
    use Interop.NIO.Channels.PipeSinkChannel.{PipeSinkChannel}
    use Interop.NIO.Channels.ChannelZ
    use Interop.NIO.Channels.ChannelZ.{ChannelZ}
    use Interop.NIO.Channels.SubChannel

    // Abstract Class
    pub enum PipeSinkChannel[_: Region](##java.nio.channels.Pipe$SinkChannel)

    instance SubChannel[PipeSinkChannel] {
        pub def toChannel(c: PipeSinkChannel[r]): ChannelZ[r] = 
            let PipeSinkChannel(c1) = c;
            ChannelZ(unchecked_cast(c1 as ##java.nio.channels.Channel))

        pub def fromChannel(c: ChannelZ[r]): PipeSinkChannel[r] = 
            let ChannelZ(c1) = c;
            PipeSinkChannel(unchecked_cast(c1 as ##java.nio.channels.Pipe$SinkChannel))
    }

}

mod Interop.NIO.Channels.PipeSinkChannel { 

    use Interop.NIO.Channels.PipeSinkChannel
    use Interop.NIO.Channels.PipeSinkChannel.{PipeSinkChannel}

    pub def getHH(x: PipeSinkChannel[r]): ##java.nio.channels.Pipe$SinkChannel = 
        let PipeSinkChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.Pipe$SinkChannel): PipeSinkChannel[r] =
        PipeSinkChannel(prim)


    pub def validOps(c: PipeSinkChannel[r]): Int32 \ r =
        import java.nio.channels.Pipe$SinkChannel.validOps(): Int32 \ r;
        let PipeSinkChannel(c1) = c;
        validOps(c1)

}
