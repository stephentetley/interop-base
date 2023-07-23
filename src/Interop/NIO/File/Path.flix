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


mod Interop.NIO.File {

    use Interop.NIO.File.Path
    use Interop.NIO.File.Path.{Path}
    
    ///
    /// Represents a FilePath.
    /// Interface / Immutable
    pub enum Path(##java.nio.file.Path)

    instance ToString[Path] {
        pub def toString(x: Path): String = 
            Interop.NIO.File.Path.toString(x)
    }

    instance Eq[Path] {
        pub def eq(x: Path, y: Path): Bool = 
            Interop.NIO.File.Path.equals(x, y)
    }

    instance Order[Path] {
        pub def compare(x: Path, y: Path): Comparison =
            Interop.NIO.File.Path.compareTo(x, y) |> Comparison.fromInt32
    }

    instance Hash[Path] {
        pub def hash(x: Path): Int32 = 
            Interop.NIO.File.Path.hashCode(x)
    }


    instance Interop.Flix.GoesToJava[Path] {
        pub def toJavaObject(x: Path): ##java.lang.Object =
            let Path(x1) = x;
            checked_cast(x1)
    }


}

mod Interop.NIO.File.Path {


    use Interop.NIO.File.Path
    use Interop.NIO.File.Path.{Path}

    use Interop.IO.File
    use Interop.IO.File.{File}

    /// Note - current set of operations should be pure?

    /// Unwrap
    pub def getHH(path: Path): ##java.nio.file.Path = 
        let Path(path1) = path;
        path1

    pub def fromJavaObject(o: ##java.lang.Object): Path = 
        Path(unchecked_cast(o as ##java.nio.file.Path))



    pub def toString(path: Path): String = 
        import java.nio.file.Path.toString(): String \ {};
        let Path(path1) = path;
        toString(path1)

    pub def equals(x: Path, y: Path): Bool =
        import java.nio.file.Path.equals(##java.lang.Object): Bool \ {};
        let Path(x1) = x;
        let Path(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compareTo(x: Path, y: Path): Int32 =
        import java.nio.file.Path.compareTo(##java.nio.file.Path): Int32 \ {};
        let Path(x1) = x;
        let Path(y1) = y;
        compareTo(x1, y1)

    pub def hashCode(path: Path): Int32 =
        import java.nio.file.Path.hashCode(): Int32 \ {};
        let Path(path1) = path;
        hashCode(path1)


    ///
    /// Returns a new FilePath.
    ///
    pub def of(s: String, l: List[String]): Result[String, Path] =
        Result.tryCatch(_ -> {
            region rc {
                import static java.nio.file.Path.of(String, Array[String, rc]): ##java.nio.file.Path \ rc as of1;
                let arr = List.toArray(rc, l);
                Path(of1(s, arr))
            }
        })


    pub def normalize(path: Path): Path =
        import java.nio.file.Path.normalize(): ##java.nio.file.Path \ {};
        let Path(p1) = path;
        Path(normalize(p1))


    /// If `path` is a relative path `toAbsolutePath` resolves the path in a system specific manner.
    /// Should this be Impure?
    pub def toAbsolutePath(path: Path): Result[String, Path] =        
        Result.tryCatch(_ -> {
            import java.nio.file.Path.toAbsolutePath(): ##java.nio.file.Path \ {};
            let Path(p1) = path;
            toAbsolutePath(p1) |> Path
        })


    pub def isAbsolute(path: Path): Bool =
        import java.nio.file.Path.isAbsolute(): Bool \ {};
        let Path(path1) = path;
        isAbsolute(path1)


    pub def getRoot(path: Path): Option[Path] =
        import java.nio.file.Path.getRoot(): ##java.nio.file.Path \ {};
        let Path(path1) = path;
        getRoot(path1) |> Object.toOption |> Option.map(Path)

    pub def getParent(path: Path): Option[Path] =
        import java.nio.file.Path.getParent(): ##java.nio.file.Path \ {};
        let Path(path1) = path;
        getParent(path1) |> Object.toOption |> Option.map(Path)

    pub def getFileName(path: Path): Option[Path] =
        import java.nio.file.Path.getFileName(): ##java.nio.file.Path \ {};
        let Path(path1) = path;
        getFileName(path1) |> Object.toOption |> Option.map(Path)

    /// TODO use a record to disambiguate
    pub def resolve(path: Path, other: Path): Path =
        import java.nio.file.Path.resolve(##java.nio.file.Path): ##java.nio.file.Path \ {};
        let Path(path1) = path;
        let Path(other1) = other;
        Path(resolve(path1, other1))


    ///
    /// Returns `path1` with the path name contracted relative to `path2`.
    /// TODO use a record to disambiguate
    ///
    pub def relativize(path1: Path, path2: Path): Path =
        import java.nio.file.Path.relativize(##java.nio.file.Path): ##java.nio.file.Path \ {};
        let Path(p1) = path1;
        let Path(p2) = path2;
        Path(relativize(p1, p2))


    ///
    /// Returns `true` if the filepath `path` starts with the Path `prefix`.
    ///
    pub def startsWith(prefix: {prefix = Path}, path: Path): Bool =
        import java.nio.file.Path.startsWith(##java.nio.file.Path): Bool \ {};
        let Path(p1) = path;
        let Path(prefix1) = prefix.prefix;
        startsWith(p1, prefix1)

    ///
    /// Returns `true` if the filepath `path` starts with the String `prefix`.
    ///
    pub def startsWithString(prefix: {prefix = String}, path: Path): Bool =
        import java.nio.file.Path.startsWith(String): Bool \ {};
        let Path(p1) = path;
        startsWith(p1, prefix.prefix)


    pub def getNameCount(path: Path): Int32 =
        import java.nio.file.Path.getNameCount(): Int32 \ {};
        let Path(path1) = path;
        getNameCount(path1)


    pub def getNameAt(ix: Int32, path: Path): Result[String, Path] =
        Result.tryCatch(_ -> {
            import java.nio.file.Path.getName(Int32): ##java.nio.file.Path \ {};
            let Path(path1) = path;
            getName(path1, ix) |> Path
        })

    pub def toFile(_: Region[r], path: Path): Result[String, File[r]] \ r =
        Result.tryCatch(_ -> {
            import java.nio.file.Path.toFile(): ##java.io.File \ r;
            let Path(path1) = path;
            File(toFile(path1))
        })

}
