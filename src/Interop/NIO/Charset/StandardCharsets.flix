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

mod Interop.NIO.Charset.StandardCharsets {

    use Interop.NIO.Charset.Charset
    use Interop.NIO.Charset.Charset.{Charset}

 
    pub def iso_8859_1(): Charset =
        import static get java.nio.charset.StandardCharsets.ISO_8859_1: ##java.nio.charset.Charset \ {} as get_ISO_8859_1;
        Charset(get_ISO_8859_1())

    pub def us_ascii(): Charset =
        import static get java.nio.charset.StandardCharsets.US_ASCII: ##java.nio.charset.Charset \ {} as get_US_ASCII;
        Charset(get_US_ASCII())

    pub def utf_16(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16: ##java.nio.charset.Charset \ {} as get_UTF_16;
        Charset(get_UTF_16())

    pub def utf_16be(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16BE: ##java.nio.charset.Charset \ {} as get_UTF_16BE;
        Charset(get_UTF_16BE())

    pub def utf_16le(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_16LE: ##java.nio.charset.Charset \ {} as get_UTF_16LE;
        Charset(get_UTF_16LE())

    pub def utf_8(): Charset =
        import static get java.nio.charset.StandardCharsets.UTF_8: ##java.nio.charset.Charset \ {} as get_UTF_8;
        Charset(get_UTF_8())


}
