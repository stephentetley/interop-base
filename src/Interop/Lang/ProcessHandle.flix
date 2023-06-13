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

    pub enum ProcessHandle[_: Region](##java.lang.ProcessHandle)


}


mod Interop.Lang.ProcessHandle {
    
    use Interop.NIO.Charset.Charset
    use Interop.NIO.Charset.Charset.{Charset}
    use Interop.IO.InputStream
    use Interop.IO.InputStream.{InputStream}
    use Interop.IO.OutputStream
    use Interop.IO.OutputStream.{OutputStream}
    use Interop.Lang.ProcessHandle
    use Interop.Lang.ProcessHandle.{ProcessHandle}


    pub def getHH(p: ProcessHandle[r]): ##java.lang.ProcessHandle = 
        let ProcessHandle(p1) = p;
        p1

    pub def wrapHH(_: Region[r], prim: ##java.lang.ProcessHandle): ProcessHandle[r] = 
        ProcessHandle(prim)

    pub def current(_: Region[r]): ProcessHandle[r] \ IO =
        import static java.lang.ProcessHandle.current(): ##java.lang.ProcessHandle \ IO;
        ProcessHandle(current())



    pub def destroy!(p: ProcessHandle[r]): Result[String, Bool] \ r =
        Result.tryCatch(_ -> {
            import java.lang.ProcessHandle.destroy(): Bool \ r;
            let ProcessHandle(p1) = p;
            destroy(p1)
        })

    pub def isAlive(p: ProcessHandle[r]): Bool \ r =
        import java.lang.ProcessHandle.isAlive(): Bool \ r;
        let ProcessHandle(p1) = p;
        isAlive(p1)


    pub def pid(p: ProcessHandle[r]): Int64 \ r =
        import java.lang.ProcessHandle.pid(): Int64 \ r;
        let ProcessHandle(p1) = p;
        pid(p1)

}
