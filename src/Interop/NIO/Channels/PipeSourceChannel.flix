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

    use Interop.NIO.Channels.PipeSourceChannel
    use Interop.NIO.Channels.PipeSourceChannel.{PipeSourceChannel}
    use Interop.NIO.Channels.ChannelZ
    use Interop.NIO.Channels.ChannelZ.{ChannelZ}
    use Interop.NIO.Channels.SubChannel

    // Abstract Class
    pub enum PipeSourceChannel[_: Region](##java.nio.channels.Pipe$SourceChannel)

    instance SubChannel[PipeSourceChannel] {
        pub def toChannel(c: PipeSourceChannel[r]): ChannelZ[r] = 
            let PipeSourceChannel(c1) = c;
            ChannelZ(unchecked_cast(c1 as ##java.nio.channels.Channel))

        pub def fromChannel(c: ChannelZ[r]): PipeSourceChannel[r] = 
            let ChannelZ(c1) = c;
            PipeSourceChannel(unchecked_cast(c1 as ##java.nio.channels.Pipe$SourceChannel))
    }
}

mod Interop.NIO.Channels.PipeSourceChannel { 

    use Interop.NIO.Channels.PipeSourceChannel
    use Interop.NIO.Channels.PipeSourceChannel.{PipeSourceChannel}

    pub def getHH(x: PipeSourceChannel[r]): ##java.nio.channels.Pipe$SourceChannel = 
        let PipeSourceChannel(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.Pipe$SourceChannel): PipeSourceChannel[r] =
        PipeSourceChannel(prim)



    pub def validOps(c: PipeSourceChannel[r]): Int32 \ r =
        import java.nio.channels.Pipe$SourceChannel.validOps(): Int32 \ r;
        let PipeSourceChannel(c1) = c;
        validOps(c1)
        


}
