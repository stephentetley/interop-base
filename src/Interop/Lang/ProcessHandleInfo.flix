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

    /// TODO check impurity...
    pub enum ProcessHandleInfo[_: Region](##java.lang.ProcessHandle$Info)


}


mod Interop.Lang.ProcessHandleInfo {

    use Interop.Lang.ProcessHandleInfo
    use Interop.Lang.ProcessHandleInfo.{ProcessHandleInfo}


    pub def getHH(p: ProcessHandleInfo[r]): ##java.lang.ProcessHandle$Info = 
        let ProcessHandleInfo(p1) = p;
        p1

    pub def wrapHH(_: Region[r], prim: ##java.lang.ProcessHandle$Info): ProcessHandleInfo[r] = 
        ProcessHandleInfo(prim)

    pub def fromJavaObject(_: Region[r], o: ##java.lang.Object): ProcessHandleInfo[r] = 
        ProcessHandleInfo(unchecked_cast(o as ##java.lang.ProcessHandle$Info))


    pub def command(info: ProcessHandleInfo[r]): Option[String] \ r = 
        import java.lang.ProcessHandle$Info.command(): ##java.util.Optional \ r;
        let ProcessHandleInfo(info1) = info;
        command(info1) 
            |> Interop.Util.Optional.wrapHH 
            |> Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject)


    pub def commandLine(info: ProcessHandleInfo[r]): Option[String] \ r = 
        import java.lang.ProcessHandle$Info.commandLine(): ##java.util.Optional \ r;
        let ProcessHandleInfo(info1) = info;
        commandLine(info1) 
            |> Interop.Util.Optional.wrapHH 
            |> Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject)


    pub def user(info: ProcessHandleInfo[r]): Option[String] \ r = 
        import java.lang.ProcessHandle$Info.user(): ##java.util.Optional \ r;
        let ProcessHandleInfo(info1) = info;
        user(info1) 
            |> Interop.Util.Optional.wrapHH 
            |> Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject)

}
