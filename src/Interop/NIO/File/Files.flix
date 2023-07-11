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


mod Interop.NIO.File.Files {

    use Interop.NIO.Charset.Charset
    use Interop.NIO.Charset.Charset.{Charset}
    use Interop.NIO.File.Path
    use Interop.NIO.File.Path.{Path}
    use Interop.NIO.File.LinkOption
    use Interop.NIO.File.OpenOption
    use Interop.NIO.File.OpenOption.{OpenOption}
    use Interop.Lang.CharSequence
    use Interop.IO.InputStream
    use Interop.IO.InputStream.{InputStream}
    use Interop.IO.OutputStream
    use Interop.IO.OutputStream.{OutputStream}

    pub def newInputStream(_: Region[r], path: Path, opts: List[OpenOption]): Result[String, InputStream[r]] \ IO =
        Result.tryCatch(_ -> {
            region rc {
                import static java.nio.file.Files.newInputStream(##java.nio.file.Path, Array[##java.nio.file.OpenOption, rc]): ##java.io.InputStream \ {IO, r};
                let Path(path1) = path;
                let opts1 = List.map(Interop.NIO.File.OpenOption.getHH, opts) |> List.toArray(rc);
                InputStream(newInputStream(path1, opts1))
            }
        })

    pub def newOutputStream(_: Region[r], path: Path, opts: List[OpenOption]): Result[String, OutputStream[r]] \ {IO, r} =
        Result.tryCatch(_ -> {
            region rc {
                import static java.nio.file.Files.newOutputStream(##java.nio.file.Path, Array[##java.nio.file.OpenOption, rc]): ##java.io.OutputStream \ {IO, r};
                let Path(path1) = path;
                let opts1 = List.map(Interop.NIO.File.OpenOption.getHH, opts) |> List.toArray(rc);
                OutputStream(newOutputStream(path1, opts1))
            }
        })

    /// UTF_8
    pub def exists(path: Path, opts: List[LinkOption]): Result[String, Bool] \ IO = 
        Result.tryCatch(_ -> {
            region rc {
                import static java.nio.file.Files.exists(##java.nio.file.Path, Array[##java.nio.file.LinkOption, rc]): Bool \ {IO};
                let Path(path1) = path;
                let opts1 = List.map(Interop.NIO.File.LinkOption.getHH, opts) |> List.toArray(rc);
                exists(path1, opts1)
            }
        })

    /// UTF_8
    pub def readStringUtf8(path: Path): Result[String, String] \ IO = 
        Result.tryCatch(_ -> {
            import static java.nio.file.Files.readString(##java.nio.file.Path): String \ IO;
            let path1 = Interop.NIO.File.Path.getHH(path);
            readString(path1)
        })

    pub def readString(path: Path, cs: Charset): Result[String, String] \IO = 
        Result.tryCatch(_ -> {
            import static java.nio.file.Files.readString(##java.nio.file.Path, ##java.nio.charset.Charset): String \ IO;
            let Path(path1) = path;
            let Charset(cs1) = cs;
            readString(path1, cs1)
        })

    /// UTF_8
    pub def writeStringUtf8!(path: Path, s: CharSequence, opts: List[OpenOption]): Result[String, Path] \ IO = 
        Result.tryCatch(_ -> {
            region rc {
                import static java.nio.file.Files.writeString(##java.nio.file.Path, 
                        ##java.lang.CharSequence, Array[##java.nio.file.OpenOption, rc]): ##java.nio.file.Path \ IO;
                let Path(path1) = path;
                let s1 = Interop.Lang.CharSequence.getHH(s);
                let opts1 = List.map(Interop.NIO.File.OpenOption.getHH, opts) |> List.toArray(rc);
                writeString(path1, s1, opts1) |> Path
            }
        })

    pub def writeString!(path: Path, s: CharSequence, cs: Charset, opts: List[OpenOption]): Result[String, Path] \ IO = 
        Result.tryCatch(_ -> {
            region rc {
                import static java.nio.file.Files.writeString(##java.nio.file.Path, 
                                ##java.lang.CharSequence, ##java.nio.charset.Charset, Array[##java.nio.file.OpenOption, rc]): ##java.nio.file.Path \ IO;
                let Path(path1) = path;
                let s1 = Interop.Lang.CharSequence.getHH(s);
                let Charset(cs1) = cs;
                let opts1 = List.map(Interop.NIO.File.OpenOption.getHH, opts) |> List.toArray(rc);
                writeString(path1, s1, cs1, opts1) |> Path
            }
        })

}
