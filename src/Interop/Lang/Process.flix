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


mod Interop.Lang {

    pub enum Process[_: Region](##java.lang.Process)


}


mod Interop.Lang.Process {
    
    use Interop.NIO.Charset.Charset
    use Interop.NIO.Charset.Charset.{Charset}
    use Interop.IO.InputStream
    use Interop.IO.InputStream.{InputStream}
    use Interop.IO.OutputStream
    use Interop.IO.OutputStream.{OutputStream}
    use Interop.Lang.Process
    use Interop.Lang.Process.{Process}
    use Interop.Lang.ProcessBuilder
    use Interop.Lang.ProcessBuilder.{ProcessBuilder}
    use Interop.Lang.ProcessHandle
    use Interop.Lang.ProcessHandle.{ProcessHandle}


    pub def getHH(p: Process[r]): ##java.lang.Process = 
        let Process(p1) = p;
        p1

    pub def wrapHH(_: Region[r], prim: ##java.lang.Process): Process[r] = 
        Process(prim)

    pub def new(_: Region[r]): Process[r] \ IO =
        import new java.lang.Process(): ##java.lang.Process \ IO as new1;
        Process(new1())


    pub def waitFor!(p: Process[r]): Result[String, Int32] \ { IO } =
        Result.tryCatch(_ -> {
            import java.lang.Process.waitFor(): Int32 \ { IO };
            let Process(p1) = p;
            waitFor(p1)
        })

    // `inputReader` / `errorReader` / `outputWriter` are Java 17

    pub def getOutputStream(rc: Region[r1], p: Process[r]): OutputStream[r1] \ { r, r1, IO } =
        import java.lang.Process.getOutputStream(): ##java.io.OutputStream \ { r, r1, IO };
        let Process(p1) = p;
        getOutputStream(p1) |> Interop.IO.OutputStream.wrapHH(rc)

    pub def getInputStream(rc: Region[r1], p: Process[r]): InputStream[r1] \ { r, r1, IO } = 
        import java.lang.Process.getInputStream(): ##java.io.InputStream \ { r, r1, IO };
        let Process(p1) = p;
        getInputStream(p1) |> Interop.IO.InputStream.wrapHH(rc)
    
    pub def getErrorStream(rc: Region[r1], p: Process[r]): InputStream[r1] \ { r, r1, IO } =
        import java.lang.Process.getErrorStream(): ##java.io.InputStream \ { r, r1, IO };
        let Process(p1) = p;
        getErrorStream(p1) |> Interop.IO.InputStream.wrapHH(rc)


    pub def supportsNormalTermination(p: Process[r]): Bool \ r =
        import java.lang.Process.supportsNormalTermination(): Bool \ r;
        let Process(p1) = p;
        supportsNormalTermination(p1)

    pub def isAlive(p: Process[r]): Bool \ r =
        import java.lang.Process.isAlive(): Bool \ r;
        let Process(p1) = p;
        isAlive(p1)


    pub def pid(p: Process[r]): Int64 \ r =
        import java.lang.Process.pid(): Int64 \ r;
        let Process(p1) = p;
        pid(p1)


    pub def toHandle(p: Process[r]): Result[String, ProcessHandle[r]] \ { IO } =
        Result.tryCatch(_ -> {
            import java.lang.Process.toHandle(): ##java.lang.ProcessHandle \ { IO };
            let Process(p1) = p;
            ProcessHandle(toHandle(p1))
        })

}
