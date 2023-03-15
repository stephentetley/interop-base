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

    use Interop/NIO/File.StandardOpenOption
    use Interop/NIO/File.StandardOpenOption.{StandardOpenOption}
    use Interop/Lang.Enum
    use Interop/Lang.Enum.{Enum}
    use Interop/NIO/File.OpenOption
    use Interop/NIO/File.OpenOption.{OpenOption}

    pub enum StandardOpenOption(##java.nio.file.StandardOpenOption)

    instance Interop/Flix.Marshal[StandardOpenOption] {
        pub def toJavaObject(x: StandardOpenOption): ##java.lang.Object =
            let StandardOpenOption(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): StandardOpenOption = 
            StandardOpenOption(unchecked_cast(o as ##java.nio.file.StandardOpenOption))
    }


    instance Interop/NIO/File.ImpOpenOption[StandardOpenOption] {
        pub def toOpenOption(x: StandardOpenOption): OpenOption = 
            let StandardOpenOption(x1) = x;
            OpenOption(unchecked_cast(x1 as ##java.nio.file.OpenOption))

        pub def fromOpenOption(x: OpenOption): StandardOpenOption = 
            let OpenOption(x1) = x;
            StandardOpenOption(unchecked_cast(x1 as ##java.nio.file.StandardOpenOption))
    }

    instance Interop/Lang.SubEnum[StandardOpenOption] {
        pub def toEnum(x: StandardOpenOption): Enum[a] = 
            let StandardOpenOption(x1) = x;
            Enum(unchecked_cast(x1 as ##java.lang.Enum))

        pub def fromEnum(x: Enum[a]): StandardOpenOption = 
            let Enum(x1) = x;
            StandardOpenOption(unchecked_cast(x1 as ##java.nio.file.StandardOpenOption))
    }

}

namespace Interop/NIO/File/StandardOpenOption { 

    use Interop/NIO/File.StandardOpenOption
    use Interop/NIO/File.StandardOpenOption.{StandardOpenOption}

    pub def getHH(x: StandardOpenOption): ##java.nio.file.StandardOpenOption = 
        let StandardOpenOption(x1) = x;
        x1

    pub def append(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.APPEND: ##java.nio.file.StandardOpenOption \ {} as get_APPEND;
        get_APPEND() |> StandardOpenOption

    pub def create(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.CREATE: ##java.nio.file.StandardOpenOption \ {} as get_CREATE;
        get_CREATE() |> StandardOpenOption

    pub def create_new(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.CREATE_NEW: ##java.nio.file.StandardOpenOption \ {} as get_CREATE_NEW;
        get_CREATE_NEW() |> StandardOpenOption

    pub def delete_on_close(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.DELETE_ON_CLOSE: ##java.nio.file.StandardOpenOption \ {} as get_DELETE_ON_CLOSE;
        get_DELETE_ON_CLOSE() |> StandardOpenOption

    pub def dsync(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.DSYNC: ##java.nio.file.StandardOpenOption \ {} as get_DSYNC;
        get_DSYNC() |> StandardOpenOption

    pub def read(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.READ: ##java.nio.file.StandardOpenOption \ {} as get_READ;
        get_READ() |> StandardOpenOption

    pub def sparse(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.SPARSE: ##java.nio.file.StandardOpenOption \ {} as get_SPARSE;
        get_SPARSE() |> StandardOpenOption

    pub def sync(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.SYNC: ##java.nio.file.StandardOpenOption \ {} as get_SYNC;
        get_SYNC() |> StandardOpenOption

    pub def truncate_existing(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.TRUNCATE_EXISTING: ##java.nio.file.StandardOpenOption \ {} as get_TRUNCATE_EXISTING;
        get_TRUNCATE_EXISTING() |> StandardOpenOption

    pub def write(): StandardOpenOption = 
        import static get java.nio.file.StandardOpenOption.WRITE: ##java.nio.file.StandardOpenOption \ {} as get_WRITE;
        get_WRITE() |> StandardOpenOption

}
