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


namespace Interop/Lang {

    pub enum Process[_: Region](##java.lang.Process)

    instance Scoped[Process] {
        pub def regionOf(_: Process[r]): Region[r] = () as Region[r]
    }
}


namespace Interop/Lang/Process {
    
    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};

    use Interop/IO.InputStream;
    use Interop/IO.InputStream.{InputStream};
    use Interop/IO.OutputStream;
    use Interop/IO.OutputStream.{OutputStream};
    use Interop/Lang.Process;
    use Interop/Lang.Process.{Process};
    use Interop/Lang.ProcessBuilder;
    use Interop/Lang.ProcessBuilder.{ProcessBuilder};


    pub def getHH(x: Process[r]): ##java.lang.Process = 
        let Process(x1) = x;
        x1

    pub def waitFor!(p: Process[r]): Result[Int32, String] \ { Write(r), IO } =
        try {
            import java.lang.Process.waitFor(): Int32 \ { Write(r), IO };
            let Process(p1) = p;
            waitFor(p1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \{};
                Err(getMessage(ex))
        }

    pub def getOutputStream(p: Process[r]): OutputStream[r] \ {Write(r), IO}=
        import java.lang.Process.getOutputStream(): ##java.io.OutputStream \ IO;
        let Process(p1) = p;
        let r = Scoped.regionOf(p);
        getOutputStream(p1) |> Interop/IO/OutputStream.mkOutputStream(r)

    pub def getInputStream(p: Process[r]): InputStream[r] \ {Write(r), IO}=
        import java.lang.Process.getInputStream(): ##java.io.InputStream \ IO;
        let Process(p1) = p;
        let r = Scoped.regionOf(p);
        getInputStream(p1) |> Interop/IO/InputStream.mkInputStream(r)

    pub def getErrorStream(p: Process[r]): InputStream[r] \ {Write(r), IO}=
        import java.lang.Process.getErrorStream(): ##java.io.InputStream \ IO;
        let Process(p1) = p;
        let r = Scoped.regionOf(p);
        getErrorStream(p1) |> Interop/IO/InputStream.mkInputStream(r)


}
