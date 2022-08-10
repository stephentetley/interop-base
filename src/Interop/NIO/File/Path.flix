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


namespace Interop/NIO/File {

    ///
    /// Represents a FilePath.
    /// Interface / Immutable
    pub enum Path(##java.nio.file.Path)


}

namespace Interop/NIO/File/Path {


    use Interop/NIO/File.Path;
    use Interop/NIO/File.Path.{Path};

    use Interop/IO.File;
    use Interop/IO.File.{File};

    /// Note - current set of operations should be pure?

    /// Unwrap
    pub def getHH(p: Path): ##java.nio.file.Path = 
        let Path(p1) = p;
        p1


    pub def normalize(path: Path): Path =
        import java.nio.file.Path.normalize(): ##java.nio.file.Path & Pure;
        let Path(p1) = path;
        Path(normalize(p1))


    /// If `path` is a relative path `toAbsolutePath` resolves the path in a system specific manner.
    /// Should this be Impure?
    pub def toAbsolutePath(path: Path): Result[Path, String] =        
        try {
            import java.nio.file.Path.toAbsolutePath(): ##java.nio.file.Path & Pure;
            let Path(p1) = path;
            toAbsolutePath(p1) |> Path |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }


    pub def isAbsolute(path: Path): Bool =
        import java.nio.file.Path.isAbsolute(): Bool & Pure;
        let Path(path1) = path;
        isAbsolute(path1)


    pub def getRoot(path: Path): Option[Path] =
        import java.nio.file.Path.getRoot(): ##java.nio.file.Path & Pure;
        let Path(path1) = path;
        getRoot(path1) |> Object.toOption |> Option.map(Path)

    pub def getParent(path: Path): Option[Path] =
        import java.nio.file.Path.getParent(): ##java.nio.file.Path & Pure;
        let Path(path1) = path;
        getParent(path1) |> Object.toOption |> Option.map(Path)

    pub def getFileName(path: Path): Option[Path] =
        import java.nio.file.Path.getFileName(): ##java.nio.file.Path & Pure;
        let Path(path1) = path;
        getFileName(path1) |> Object.toOption |> Option.map(Path)

    /// TODO use a record to disambiguate
    pub def resolve(path: Path, other: Path): Path =
        import java.nio.file.Path.resolve(##java.nio.file.Path): ##java.nio.file.Path & Pure;
        let Path(path1) = path;
        let Path(other1) = other;
        Path(resolve(path1, other1))


    ///
    /// Returns `path1` with the path name contracted relative to `path2`.
    /// TODO use a record to disambiguate
    ///
    pub def relativize(path1: Path, path2: Path): Path =
        import java.nio.file.Path.relativize(##java.nio.file.Path): ##java.nio.file.Path & Pure;
        let Path(p1) = path1;
        let Path(p2) = path2;
        Path(relativize(p1, p2))


    ///
    /// Returns `true` if the filepath `path` starts with the Path `prefix`.
    ///
    pub def startsWith(prefix: {prefix :: Path}, path: Path): Bool =
        import java.nio.file.Path.startsWith(##java.nio.file.Path): Bool & Pure;
        let Path(p1) = path;
        let Path(prefix1) = prefix.prefix;
        startsWith(p1, prefix1)

    ///
    /// Returns `true` if the filepath `path` starts with the String `prefix`.
    ///
    pub def startsWithString(prefix: {prefix :: String}, path: Path): Bool =
        import java.nio.file.Path.startsWith(String): Bool & Pure;
        let Path(p1) = path;
        startsWith(p1, prefix.prefix)


    pub def getNameCount(path: Path): Int32 =
        import java.nio.file.Path.getNameCount(): Int32 & Pure;
        let Path(path1) = path;
        getNameCount(path1)


    pub def getNameAt(ix: Int32, path: Path): Result[Path, String] =
        try {
            import java.nio.file.Path.getName(Int32): ##java.nio.file.Path & Pure;
            let Path(path1) = path;
            getName(path1, ix) |> Path |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String & Pure;
                Err(getMessage(ex))
        }

    pub def toFile(_: Region[r], path: Path): File[r] \ Write(r) =
        import java.nio.file.Path.toFile(): ##java.io.File & Pure;
        let Path(path1) = path;
        File(toFile(path1)) as \ Write(r)

}
