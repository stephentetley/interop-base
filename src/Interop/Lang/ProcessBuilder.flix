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

    pub enum ProcessBuilder[_: Region](##java.lang.ProcessBuilder)

    instance Scoped[ProcessBuilder] {
        pub def regionOf(_: ProcessBuilder[r]): Region[r] = () as Region[r]
    }

}


namespace Interop/Lang/ProcessBuilder {

    use Interop/Lang.ProcessBuilder;
    use Interop/Lang.ProcessBuilder.{ProcessBuilder};

    use Interop/NIO/File.Path;
    use Interop/NIO/File.Path.{Path};
    use Interop/Lang.Process;
    use Interop/Lang.Process.{Process};


    pub def getHH(x: ProcessBuilder[r]): ##java.lang.ProcessBuilder = 
        let ProcessBuilder(x1) = x;
        x1

    pub def new(r: Region[r], l: List[String]): ProcessBuilder[r] \ Write(r) = 
        import new java.lang.ProcessBuilder(##java.util.List): ##java.lang.ProcessBuilder \ r as newProcessBuilder;
        let ls1 = Interop/Util/ArrayList.fromList(r, l) |> Interop/Util/ListZ.toListHH;
        newProcessBuilder(ls1) |> ProcessBuilder

    pub def command!(l: List[String], pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.command(##java.util.List): ##java.lang.ProcessBuilder \ r;
        let ProcessBuilder(pb1) = pb;
        let r = Scoped.regionOf(pb);
        let ls1 = Interop/Util/ArrayList.fromList(r, l) |> Interop/Util/ListZ.toListHH;
        command(pb1, ls1) |> ProcessBuilder


    pub def inheritIO!(pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.inheritIO(): ##java.lang.ProcessBuilder \ r;
        let ProcessBuilder(pb1) = pb;
        inheritIO(pb1) |> ProcessBuilder

    pub def start(pb: ProcessBuilder[r]): Process[r] \ Write(r) =
        import java.lang.ProcessBuilder.start(): ##java.lang.Process \ r;
        let ProcessBuilder(pb1) = pb;
        start(pb1) |> Process

}
