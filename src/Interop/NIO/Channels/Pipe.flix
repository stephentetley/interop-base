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
    pub enum Pipe[_: Region](##java.nio.channels.Pipe)
    
    instance Scoped[Pipe] {
        pub def regionOf(_: Pipe[r]): Region[r] = () as Region[r]
    }

}

namespace Interop/NIO/Channels/Pipe { 

    use Interop/NIO/Channels.Pipe
    use Interop/NIO/Channels.Pipe.{Pipe}
    use Interop/NIO/Channels/Pipe.SinkChannel
    use Interop/NIO/Channels/Pipe.SinkChannel.{SinkChannel}
    use Interop/NIO/Channels/Pipe.SourceChannel
    use Interop/NIO/Channels/Pipe.SourceChannel.{SourceChannel}

    pub def getHH(x: Pipe[r]): ##java.nio.channels.Pipe = 
        let Pipe(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.nio.channels.Pipe): Pipe[r] =
        Pipe(prim)

    pub def open(): Result[Pipe[r], String] \ Write(r) =
        try {
            import static java.nio.channels.Pipe.open(): ##java.nio.channels.Pipe \ r;
            open() |> Pipe |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def sink(p: Pipe[r]): SinkChannel[r] \ Read(r) = 
        import java.nio.channels.Pipe.sink(): ##java.nio.channels.Pipe$SinkChannel \ r;
        let Pipe(p1) = p;
        sink(p1) |> SinkChannel 

    pub def source(p: Pipe[r]): SourceChannel[r] \ Read(r) = 
        import java.nio.channels.Pipe.source(): ##java.nio.channels.Pipe$SourceChannel \ r;
        let Pipe(p1) = p;
        source(p1) |> SourceChannel 

}
