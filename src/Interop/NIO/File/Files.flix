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
    use Interop/NIO/File.OpenOption;
    use Interop/NIO/File.OpenOption.{OpenOption};
    use Interop/Lang.ImpCharSequence;

    pub def readStringUtf8(path: Path): Result[String, String] \IO = 
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

    pub def writeString[t: Region -> Type, r: Region](path: Path, cseq: t[r], cs: Charset, opts: List[OpenOption]): Result[Path, String] \ IO with ImpCharSequence[t], Scoped[t] = 
        try {
            import static flixinterop.nio.file.Filesz.writeString(##java.nio.file.Path, 
                            ##java.lang.CharSequence, ##java.nio.charset.Charset, ##java.util.List): ##java.nio.file.Path \ IO;
            let Path(path1) = path;
            let cseq1 = Interop/Lang/CharSequence.toCharSequenceHH(cseq);
            let Charset(cs1) = cs;
            let r = Scoped.regionOf(cseq);
            let opts1 = Interop/Util/ArrayList.fromList(r, opts) |> Interop/Util/ListZ.toListHH;
            writeString(path1, cseq1, cs1, opts1) |> Path |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


}
