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

    pub enum ProcessBuilder[_: Region](##java.lang.ProcessBuilder)


}


mod Interop.Lang.ProcessBuilder {

    use Interop.Lang.ProcessBuilder;
    use Interop.Lang.ProcessBuilder.{ProcessBuilder};

    use Interop.IO.File;
    use Interop.IO.File.{File};
    use Interop.Lang.Process;
    use Interop.Lang.Process.{Process};
    use Interop.Lang.ProcessBuilder.Redirect;
    use Interop.Lang.ProcessBuilder.Redirect.{Redirect};
    use Interop.NIO.File.Path;
    use Interop.NIO.File.Path.{Path};
    

    pub def getHH(pb: ProcessBuilder[r]): ##java.lang.ProcessBuilder = 
        let ProcessBuilder(pb1) = pb;
        pb1

    pub def wrapHH(_: Region[r], prim: ##java.lang.ProcessBuilder): ProcessBuilder[r] = 
        ProcessBuilder(prim)

    // ProcessBuilder has both getters and setters this implies "interactive" use 
    // rather than simply a list of commands...
    // ... this seems like a job for a monad.


    pub def new(_: Region[r], l: List[String]): ProcessBuilder[r] \ Write(r) = 
        import new java.lang.ProcessBuilder(##java.util.List): ##java.lang.ProcessBuilder \ r as newProcessBuilder;
        let ls1 = Interop.Util.ListZ.fromFoldableViaArrayListHH(l);
        ProcessBuilder(newProcessBuilder(ls1))

    pub def command!(l: List[String], pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.command(##java.util.List): ##java.lang.ProcessBuilder \ Write(r);
        let ProcessBuilder(pb1) = pb;
        let ls1 = Interop.Util.ListZ.fromFoldableViaArrayListHH(l);
        ProcessBuilder(command(pb1, ls1))


    pub def getCommand(pb: ProcessBuilder[r]): List[String] \ Read(r) =
        import java.lang.ProcessBuilder.command(): ##java.util.List \ r;
        let ProcessBuilder(pb1) = pb;
        command(pb1) |> Interop.Util.ListZ.primListToFlixList


    pub def directory!(f: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ { Write(r), Read(r1) } = 
        import java.lang.ProcessBuilder.directory(##java.io.File): ##java.lang.ProcessBuilder \ {r, r1} ;
        let ProcessBuilder(pb1) = pb;
        let File(f1) = f;
        ProcessBuilder(directory(pb1, f1))

    pub def getDirectory(_: Region[r1], pb: ProcessBuilder[r]): File[r1] \ { Read(r), Write(r1) } = 
        import java.lang.ProcessBuilder.directory(): ##java.io.File \ {r, r1};
        let ProcessBuilder(pb1) = pb;
        File(directory(pb1))

    pub def environment(pb: ProcessBuilder[r]): Result[String, Map[String, String]] \ {Read(r), IO} =
        Result.tryCatch(_ -> {
            import java.lang.ProcessBuilder.environment(): ##java.util.Map \ {r, IO};
            let ProcessBuilder(pb1) = pb;
            environment(pb1) |> Interop.Util.MapZ.primMapToFlixMap
        })


    pub def inheritIO!(pb: ProcessBuilder[r]): ProcessBuilder[r] \ Write(r) = 
        import java.lang.ProcessBuilder.inheritIO(): ##java.lang.ProcessBuilder \ r;
        let ProcessBuilder(pb1) = pb;
        ProcessBuilder(inheritIO(pb1))


    pub def redirectError!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectError(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let Redirect(red1) = red;
        ProcessBuilder(redirectError(pb1, red1))


    pub def redirectErrorTo!(f: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectError(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let File(f1) = f;
        ProcessBuilder(redirectError(pb1, f1))

    pub def redirectInput!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectInput(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let Redirect(red1) = red;
        ProcessBuilder(redirectInput(pb1, red1))

    pub def redirectInputTo!(f: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectInput(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let File(f1) = f;
        ProcessBuilder(redirectInput(pb1, f1))

    pub def redirectOutput!(red: Redirect, pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectOutput(##java.lang.ProcessBuilder$Redirect): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let Redirect(red1) = red;
        ProcessBuilder(redirectOutput(pb1, red1))

    pub def redirectOutputTo!(f: File[r1], pb: ProcessBuilder[r]): ProcessBuilder[r] \ {Read(r1), Write(r)} = 
        import java.lang.ProcessBuilder.redirectOutput(##java.io.File): ##java.lang.ProcessBuilder \ {r1, r};
        let ProcessBuilder(pb1) = pb;
        let File(f1) = f;
        ProcessBuilder(redirectOutput(pb1, f1))


    pub def start(_: Region[r1], pb: ProcessBuilder[r]): Result[String, Process[r1]] \ { Read(r), Write(r1) } =
        Result.tryCatch(_ -> {
            import java.lang.ProcessBuilder.start(): ##java.lang.Process \ {r, r1};
            let ProcessBuilder(pb1) = pb;
            Process(start(pb1))
        })

}
