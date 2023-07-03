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




mod Interop.NIO.Channels.Channels { 

    use Interop.NIO.Channels.ReadableByteChannel
    use Interop.NIO.Channels.ReadableByteChannel.{ReadableByteChannel}
    use Interop.NIO.Channels.WritableByteChannel
    use Interop.NIO.Channels.WritableByteChannel.{WritableByteChannel}
    use Interop.IO.InputStream
    use Interop.IO.InputStream.{InputStream}
    use Interop.IO.OutputStream
    use Interop.IO.OutputStream.{OutputStream}

    pub def newReadableByteChannel(ins: InputStream[r]): ReadableByteChannel[r] \ r = 
        import static java.nio.channels.Channels.newChannel(##java.io.InputStream): ##java.nio.channels.ReadableByteChannel \ r;
        let InputStream(ins1) = ins;
        ReadableByteChannel(newChannel(ins1))

    pub def newWritableByteChannel(outs: OutputStream[r]): WritableByteChannel[r] \ r = 
        import static java.nio.channels.Channels.newChannel(##java.io.OutputStream): ##java.nio.channels.WritableByteChannel \ r;
        let OutputStream(outs1) = outs;
        WritableByteChannel(newChannel(outs1))

    pub def newInputStream(ch: ReadableByteChannel[r]): InputStream[r] \ r = 
        import static java.nio.channels.Channels.newInputStream(##java.nio.channels.ReadableByteChannel): ##java.io.InputStream \ r;
        let ReadableByteChannel(ch1) = ch;
        InputStream(newInputStream(ch1))

    pub def newOutputStream(ch: WritableByteChannel[r]): OutputStream[r] \ r = 
        import static java.nio.channels.Channels.newOutputStream(##java.nio.channels.WritableByteChannel): ##java.io.OutputStream \ r;
        let WritableByteChannel(ch1) = ch;
        OutputStream(newOutputStream(ch1))
        

}
