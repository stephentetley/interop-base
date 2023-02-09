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


namespace Interop/NIO/File/Files {

    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};
    use Interop/NIO/File.Path;
    use Interop/NIO/File.Path.{Path};
    use Interop/NIO/File.LinkOption;
    use Interop/NIO/File.OpenOption;
    use Interop/NIO/File.OpenOption.{OpenOption};
    use Interop/Lang.CharSequence;
    use Interop/IO.InputStream;
    use Interop/IO.InputStream.{InputStream};
    use Interop/IO.OutputStream;
    use Interop/IO.OutputStream.{OutputStream};

    pub def newInputStream(_: Region[r], path: Path, opts: List[OpenOption]): Result[String, InputStream[r]] \ IO = region rc {
        try {
            import static flixinterop.nio.file.Filesz.newInputStream(##java.nio.file.Path, ##java.util.List): ##java.io.InputStream \ {IO, r};
            let Path(path1) = path;
            let opts1 = Interop/Util/ArrayList.fromFoldable(rc, opts) |> Interop/Util/ListZ.toListHH(rc);
            newInputStream(path1, opts1)|> InputStream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    pub def newOutputStream(_: Region[r], path: Path, opts: List[OpenOption]): Result[String, OutputStream[r]] \ {IO, Write(r)} = region rc {
        try {
            import static flixinterop.nio.file.Filesz.newOutputStream(##java.nio.file.Path, ##java.util.List): ##java.io.OutputStream \ {IO, r};
            let Path(path1) = path;
            let opts1 = Interop/Util/ArrayList.fromFoldable(rc, opts) |> Interop/Util/ListZ.toListHH(rc);
            newOutputStream(path1, opts1)|> OutputStream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    /// UTF_8
    pub def exists(path: Path, opts: List[LinkOption]): Result[String, Bool] \ IO = region rc {
        try {
            import static flixinterop.nio.file.Filesz.exists(##java.nio.file.Path, ##java.util.List): Bool \ IO;
            let Path(path1) = path;
            let opts1 = Interop/Util/ArrayList.fromFoldable(rc, opts) |> Interop/Util/ListZ.toListHH(rc);
            exists(path1, opts1)|> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    /// UTF_8
    pub def readStringUtf8(path: Path): Result[String, String] \ IO = 
        try {
            import static java.nio.file.Files.readString(##java.nio.file.Path): String \ IO;
            let path1 = Interop/NIO/File/Path.getHH(path);
            readString(path1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def readString(path: Path, cs: Charset): Result[String, String] \IO = 
        try {
            import static java.nio.file.Files.readString(##java.nio.file.Path, ##java.nio.charset.Charset): String \ IO;
            let Path(path1) = path;
            let Charset(cs1) = cs;
            readString(path1, cs1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    /// UTF_8
    pub def writeStringUtf8!(path: Path, s: CharSequence[r], opts: List[OpenOption]): Result[String, Path] \ IO = region rc {
        try {
            import static flixinterop.nio.file.Filesz.writeString(##java.nio.file.Path, 
                            ##java.lang.CharSequence, ##java.util.List): ##java.nio.file.Path \ IO;
            let Path(path1) = path;
            let s1 = Interop/Lang/CharSequence.getHH(s);
            let opts1 = Interop/Util/ArrayList.fromFoldable(rc, opts) |> Interop/Util/ListZ.toListHH(rc);
            writeString(path1, s1, opts1) |> Path |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    pub def writeString!(path: Path, s: CharSequence[r], cs: Charset, opts: List[OpenOption]): Result[String, Path] \ IO = region rc {
        try {
            import static flixinterop.nio.file.Filesz.writeString(##java.nio.file.Path, 
                            ##java.lang.CharSequence, ##java.nio.charset.Charset, ##java.util.List): ##java.nio.file.Path \ IO;
            let Path(path1) = path;
            let s1 = Interop/Lang/CharSequence.getHH(s);
            let Charset(cs1) = cs;
            let opts1 = Interop/Util/ArrayList.fromFoldable(rc, opts) |> Interop/Util/ListZ.toListHH(rc);
            writeString(path1, s1, cs1, opts1) |> Path |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

}
