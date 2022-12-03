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
        pub def regionOf(_: ProcessBuilder[r]): Region[r] = unsafe_cast () as Region[r]
    }

}


namespace Interop/Lang/ProcessBuilder {

    use Interop/Lang.ProcessBuilder;
    use Interop/Lang.ProcessBuilder.{ProcessBuilder};

    use Interop/IO.File;
    use Interop/IO.File.{File};
    use Interop/Lang.Process;
    use Interop/Lang.Process.{Process};
    use Interop/Lang/ProcessBuilder.Redirect;
    use Interop/Lang/ProcessBuilder.Redirect.{Redirect};
    use Interop/NIO/File.Path;
    use Interop/NIO/File.Path.{Path};
    

    pub def getHH(x: ProcessBuilder[r]): ##java.lang.ProcessBuilder = 
        let ProcessBuilder(x1) = x;
        x1

    pub def new(r: Region[r], l: List[String]): ProcessBuilder[r] \ Write(r) = 
        import new java.lang.ProcessBuilder(##java.util.List): ##java.lang.ProcessBuilder \ r as newProcessBuilder;
        let ls1 = Interop/Util/ArrayList.fromFoldable(r, l) |> Interop/Util/ListZ.toListHH;
        newProcessBuilder(ls1) |> ProcessBuilder

    pub def command!(l: List[String], pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.command(##java.util.List): ##java.lang.ProcessBuilder \ r;
        let ProcessBuilder(pb1) = pb;
        let r = Scoped.regionOf(pb);
        let ls1 = Interop/Util/ArrayList.fromFoldable(r, l) |> Interop/Util/ListZ.toListHH;
        command(pb1, ls1) |> ProcessBuilder

    pub def getCommand(pb: ProcessBuilder[r]): List[String] \ Read(r) = 
        region r1 {
            import java.lang.ProcessBuilder.command(): ##java.util.List \ r;
            let ProcessBuilder(pb1) = pb;
            command(pb1) 
                |> Interop/Util/ListZ.wrapHH(r1)
                |> Interop/Util/ListZ.toFlixList
        }

    pub def directory!(f: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ { Write(r), Read(r1) } = 
        import java.lang.ProcessBuilder.directory(##java.io.File): ##java.lang.ProcessBuilder \ {r, r1} ;
        let ProcessBuilder(pb1) = pb;
        let File(f1) = f;
        directory(pb1, f1) |> ProcessBuilder

    pub def getDirectory(pb: ProcessBuilder[r]): File[r] \ { Write(r) } = 
        import java.lang.ProcessBuilder.directory(): ##java.io.File \ r;
        let ProcessBuilder(pb1) = pb;
        directory(pb1) |> File

    pub def environment(pb: ProcessBuilder[r]): Result[Map[String, String], String] \ Read(r) = 
        region r1 {
            try {
                import java.lang.ProcessBuilder.environment(): ##java.util.Map \ r;
                let ProcessBuilder(pb1) = pb;
                environment(pb1) 
                    |> Interop/Util/MapZ.wrapHH(r1)
                    |> Interop/Util/MapZ.toFlixMap
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def inheritIO!(pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.inheritIO(): ##java.lang.ProcessBuilder \ r;
        let ProcessBuilder(pb1) = pb;
        inheritIO(pb1) |> ProcessBuilder


    pub def redirectError!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectError(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let Redirect(red1) = red;
        redirectError(pb1, red1) |> ProcessBuilder


    pub def redirectErrorTo!(file: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectError(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let File(file1) = file;
        redirectError(pb1, file1) |> ProcessBuilder

    pub def redirectInput!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectInput(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let Redirect(red1) = red;
        redirectInput(pb1, red1) |> ProcessBuilder

    pub def redirectInputTo!(file: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectInput(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let File(file1) = file;
        redirectInput(pb1, file1) |> ProcessBuilder

    pub def redirectOutput!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectOutput(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let Redirect(red1) = red;
        redirectOutput(pb1, red1) |> ProcessBuilder

    pub def redirectOutputTo!(file: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectOutput(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let File(file1) = file;
        redirectOutput(pb1, file1) |> ProcessBuilder


    pub def start(pb: ProcessBuilder[r]): Result[Process[r], String] \ Write(r) =
        try {
            import java.lang.ProcessBuilder.start(): ##java.lang.Process \ r;
            let ProcessBuilder(pb1) = pb;
            start(pb1) |> Process |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
}
