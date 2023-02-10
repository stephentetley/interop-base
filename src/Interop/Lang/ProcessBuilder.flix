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

    pub enum ProcessBuilder[r: Region] {
        case ProcessBuilder(Region[r], ##java.lang.ProcessBuilder)
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
    

    pub def getHH(pb: ProcessBuilder[r]): ##java.lang.ProcessBuilder = 
        let ProcessBuilder(_, pb1) = pb;
        pb1

    pub def new(rc: Region[r], l: List[String]): ProcessBuilder[r] \ Write(r) = 
        import new java.lang.ProcessBuilder(##java.util.List): ##java.lang.ProcessBuilder \ r as newProcessBuilder;
        let ls1 = Interop/Util/ArrayList.fromFoldable(rc, l) |> Interop/Util/ListZ.toListHH(rc);
        ProcessBuilder(rc, newProcessBuilder(ls1))

    pub def command!(l: List[String], pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.command(##java.util.List): ##java.lang.ProcessBuilder \ Write(r);
        let ProcessBuilder(rc, pb1) = pb;
        let ls1 = region rc1 { Interop/Util/ArrayList.fromFoldable(rc1, l) |> Interop/Util/ListZ.toListHH(rc1)};
        ProcessBuilder(rc, command(pb1, ls1))

    pub def getCommand(pb: ProcessBuilder[r]): List[String] \ Read(r) = region rc {
        import java.lang.ProcessBuilder.command(): ##java.util.List \ r;
        let ProcessBuilder(_, pb1) = pb;
        command(pb1) 
            |> Interop/Util/ListZ.wrapHH(rc)
            |> Interop/Util/ListZ.toFlixList
    }

    pub def directory!(f: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ { Write(r), Read(r1) } = 
        import java.lang.ProcessBuilder.directory(##java.io.File): ##java.lang.ProcessBuilder \ {r, r1} ;
        let ProcessBuilder(rc, pb1) = pb;
        let File(f1) = f;
        ProcessBuilder(rc, directory(pb1, f1))

    pub def getDirectory(_rc: Region[r1], pb: ProcessBuilder[r]): File[r] \ { Read(r), Write(r1) } = 
        import java.lang.ProcessBuilder.directory(): ##java.io.File \ {r, r1};
        let ProcessBuilder(_, pb1) = pb;
        File(directory(pb1))

    pub def environment(pb: ProcessBuilder[r]): Result[String, Map[String, String]] \ Read(r) = region rc {
        try {
            import java.lang.ProcessBuilder.environment(): ##java.util.Map \ r;
            let ProcessBuilder(_, pb1) = pb;
            environment(pb1) 
                |> Interop/Util/MapZ.wrapHH(rc)
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
        let ProcessBuilder(rc, pb1) = pb;
        ProcessBuilder(rc, inheritIO(pb1))


    pub def redirectError!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectError(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(rc, pb1) = pb;
        let Redirect(red1) = red;
        ProcessBuilder(rc, redirectError(pb1, red1))


    pub def redirectErrorTo!(file: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectError(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(rc, pb1) = pb;
        let File(file1) = file;
        ProcessBuilder(rc, redirectError(pb1, file1))

    pub def redirectInput!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectInput(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(rc, pb1) = pb;
        let Redirect(red1) = red;
        ProcessBuilder(rc, redirectInput(pb1, red1))

    pub def redirectInputTo!(file: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectInput(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(rc, pb1) = pb;
        let File(file1) = file;
        ProcessBuilder(rc, redirectInput(pb1, file1))

    pub def redirectOutput!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectOutput(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(rc, pb1) = pb;
        let Redirect(red1) = red;
        ProcessBuilder(rc, redirectOutput(pb1, red1))

    pub def redirectOutputTo!(file: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectOutput(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(rc, pb1) = pb;
        let File(file1) = file;
        ProcessBuilder(rc, redirectOutput(pb1, file1))


    pub def start(rc: Region[r1], pb: ProcessBuilder[r]): Result[String, Process[r1]] \ { Read(r), Write(r1) } =
        try {
            import java.lang.ProcessBuilder.start(): ##java.lang.Process \ {r, r1};
            let ProcessBuilder(_, pb1) = pb;
            Process(rc, start(pb1)) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
}
