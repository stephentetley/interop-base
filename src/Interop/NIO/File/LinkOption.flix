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

    use Interop/Lang.Enum;
    use Interop/Lang.Enum.{Enum};
    use Interop/Lang.SubEnum;

    use Interop/NIO/File.OpenOption;
    use Interop/NIO/File.OpenOption.{OpenOption};
    use Interop/NIO/File.ImpOpenOption;

    pub enum LinkOption(##java.nio.file.LinkOption)

    instance Interop/Flix.Marshal[LinkOption] {
        pub def toJavaObject(x: LinkOption): ##java.lang.Object =
            let LinkOption(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): LinkOption = 
            LinkOption(unsafe_cast o as ##java.nio.file.LinkOption)
    }


    instance ImpOpenOption[LinkOption] {
        pub def toOpenOption(x: LinkOption): OpenOption = 
            let LinkOption(x1) = x;
            OpenOption(unsafe_cast x1 as ##java.nio.file.OpenOption)

        pub def fromOpenOption(x: OpenOption): LinkOption = 
            let OpenOption(x1) = x;
            LinkOption(unsafe_cast x1 as ##java.nio.file.LinkOption) 
    }

    instance SubEnum[LinkOption] {
        pub def toEnum(x: LinkOption): Enum[a] = 
            let LinkOption(x1) = x;
            Enum(unsafe_cast x1 as ##java.lang.Enum)

        pub def fromEnum(x: Enum[a]): LinkOption = 
            let Enum(x1) = x;
            LinkOption(unsafe_cast x1 as ##java.nio.file.LinkOption) 
    }

}

namespace Interop/NIO/File/LinkOption { 

    use Interop/NIO/File.LinkOption;
    use Interop/NIO/File.LinkOption.{LinkOption};

    pub def getHH(x: LinkOption): ##java.nio.file.LinkOption = 
        let LinkOption(x1) = x;
        x1

    pub def nofollow_links(): LinkOption = 
        import static get java.nio.file.LinkOption.NOFOLLOW_LINKS: ##java.nio.file.LinkOption \ {} as get_NOFOLLOW_LINKS;
        get_NOFOLLOW_LINKS() |> LinkOption

}
