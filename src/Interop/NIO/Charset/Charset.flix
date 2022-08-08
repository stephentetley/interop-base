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

namespace Interop/NIO/Charset {

    /// 
    /// Charset is a wrapper over the Java class `java.nio.charset.Charset`.
    /// Immutable / Abstract ...
    pub enum Charset(##java.nio.charset.Charset)


    instance Interop/Flix.Marshal[Charset] {
        pub def toJavaObject(x: Charset): ##java.lang.Object =
            let Charset(x1) = x;
            x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Charset = 
            Charset(o as ##java.nio.charset.Charset)
    }

}

namespace Interop/NIO/Charset/Charset {

    use Interop/NIO/Charset.Charset;
    use Interop/NIO/Charset.Charset.{Charset};

    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    pub def forName(name: String): Option[Charset] =
        import static java.nio.charset.Charset.forName(String): ##java.nio.charset.Charset & Pure;
        try {
            Some(Charset(forName(name)))
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def forNameWithDefault(d: Charset, name: String): Charset =
        forName(name) |> Option.getWithDefault(d)


    pub def defaultCharset(): Charset & Impure =
        import static java.nio.charset.Charset.defaultCharset(): ##java.nio.charset.Charset & Impure;
        Charset(defaultCharset())


    pub def isSupported(name: String): Bool =
        import static java.nio.charset.Charset.isSupported(String): Bool & Pure;
        try {
            isSupported(name)
        } catch {
            case _: ##java.lang.Exception => false
        }

    pub def iso_8859_1(): Charset =
        import static get java.nio.charset.StandardCharsets.ISO_8859_1: ##java.nio.charset.Charset & Pure as get_ISO_8859_1;
        Charset(get_ISO_8859_1())

    pub def us_ascii(): Charset =
        import static get java.nio.charset.StandardCharsets.US_ASCII: ##java.nio.charset.Charset & Pure as get_US_ASCII;
        Charset(get_US_ASCII())

    pub def utf_16(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16: ##java.nio.charset.Charset & Pure as get_UTF_16;
        Charset(get_UTF_16())

    pub def utf_16be(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16BE: ##java.nio.charset.Charset & Pure as get_UTF_16BE;
        Charset(get_UTF_16BE())

    pub def utf_16le(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16LE: ##java.nio.charset.Charset & Pure as get_UTF_16LE;
        Charset(get_UTF_16LE())

    pub def utf_8(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_8: ##java.nio.charset.Charset & Pure as get_UTF_8;
        Charset(get_UTF_8())

    pub def equals(x: Charset, y: Charset): Bool =
        import java.nio.charset.Charset.equals(##java.lang.Object): Bool & Pure;
        let Charset(x1) = x;
        let Charset(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def hashCode(cs: Charset): Int32 =
        import java.nio.charset.Charset.hashCode(): Int32 & Pure;
        let Charset(cs1) = cs;
        hashCode(cs1)

    pub def compareTo(x: Charset, y: Charset): Int32 =
        import java.nio.charset.Charset.compareTo(##java.nio.charset.Charset): Int32 & Pure;
        let Charset(x1) = x;
        let Charset(y1) = y;
        compareTo(x1, y1)


    /// 
    /// Returns the canonical name of Charset `c`.
    /// 
    pub def name(c: Charset): String =
        import java.nio.charset.Charset.name(): String & Pure;
        let Charset(c1) = c;
        name(c1)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the system's default locale.
    ///
    pub def displayName(c: Charset): String =
        import java.nio.charset.Charset.displayName(): String & Pure;
        let Charset(c1) = c;
        displayName(c1)

    /// 
    /// Returns the human readable name of the Charset `c`.
    /// 
    /// The name is interpreted using the supplied locale.
    ///    
    pub def displayNameWithLocale(c: Charset, locale: Locale): String =
        import java.nio.charset.Charset.displayName(##java.util.Locale): String & Pure;
        let Charset(c1) = c;
        let Locale(locale1) = locale;
        displayName(c1, locale1)

    pub def isRegistered(cs: Charset): Bool =
        import java.nio.charset.Charset.isRegistered(): Bool & Pure;
        let Charset(cs1) = cs;
        isRegistered(cs1)

    pub def canEncode(cs: Charset): Bool =
        import java.nio.charset.Charset.canEncode(): Bool & Pure;
        let Charset(cs1) = cs;
        canEncode(cs1)


    pub def contains(x: Charset, y: Charset): Bool =
        import java.nio.charset.Charset.contains(##java.nio.charset.Charset): Bool & Pure;
        let Charset(x1) = x;
        let Charset(y1) = y;
        contains(x1, y1)

    pub def aliases(x: Charset): Set[String] =
        import java.nio.charset.Charset.aliases(): ##java.util.Set & Pure;
        region r1 {
            let Charset(x1) = x;
            let s1 = aliases(x1); 
            Interop/Util/RawSet.new(r1, s1) |> Interop/Util/RawSet.toSet
        }

    pub def availableCharsets(): Map[String, Charset] =
        region r1 {
            import static java.nio.charset.Charset.availableCharsets(): ##java.util.SortedMap & r1;
            let sm = availableCharsets();
            Interop/Util/SortedMap.new(r1, sm) |> Interop/Util/SortedMap.toMap
        }



    pub def encode(cs: Charset, s: String): ##java.nio.ByteBuffer = 
        import java.nio.charset.Charset.encode(String): ##java.nio.ByteBuffer & Pure;
        let Charset(cs1) = cs;
        encode(cs1, s)

    pub def encodeCharBuffer(cs: Charset, cb: ##java.nio.CharBuffer): ##java.nio.ByteBuffer = 
        import java.nio.charset.Charset.encode(##java.nio.CharBuffer): ##java.nio.ByteBuffer & Pure;
        let Charset(cs1) = cs;
        encode(cs1, cb)
    
    pub def decode(cs: Charset, cb: ##java.nio.ByteBuffer): ##java.nio.CharBuffer = 
        import java.nio.charset.Charset.decode(##java.nio.ByteBuffer): ##java.nio.CharBuffer & Pure;
        let Charset(cs1) = cs;
        decode(cs1, cb)
    

}
