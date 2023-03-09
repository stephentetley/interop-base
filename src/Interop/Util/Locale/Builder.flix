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

namespace Interop/Util/Locale {

    pub enum Builder[r: Region] { 
        case Builder(Region[r], ##java.util.Locale$Builder)
    }
    
}


namespace Interop/Util/Locale/Builder {

    use Interop/Util/Locale.Builder;
    use Interop/Util/Locale.Builder.{Builder};
    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};


    pub def getHH(c: Builder[r]): ##java.util.Locale$Builder = 
        let Builder(_, c1) = c;
        c1


    pub def wrapHH(rc: Region[r], prim: ##java.util.Locale$Builder): Builder[r] = 
        Builder(rc, prim)

    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def new(rc: Region[r]): Builder[r] \ Write(r) =
        import new java.util.Locale$Builder(): ##java.util.Locale$Builder \ r as newBuilder;
        Builder(rc, newBuilder())

    pub def setLocale!(loc: Locale, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setLocale(##java.util.Locale): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            let Locale(loc1) = loc;
            Builder(rc, setLocale(b1, loc1))
        })

    pub def setLanguageTag!(tag: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setLanguageTag(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setLanguageTag(b1, tag))
        })

    pub def setLanguage!(lang: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setLanguage(b1, lang))
        })

    pub def setScript!(scr: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setScript(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setScript(b1, scr))
        })

    pub def setRegion!(rgn: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setRegion(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setRegion(b1, rgn))
        })


    pub def setVariant!(vnt: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setVariant(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setVariant(b1, vnt))
        })


    pub def setExtension!(k: Char, v: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setExtension(Char, String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setExtension(b1, k, v))
        })

    pub def setUnicodeLocaleKeyword!(k: String, ty: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.setUnicodeLocaleKeyword(String, String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, setUnicodeLocaleKeyword(b1, k, ty))
        })


    pub def addUnicodeLocaleAttribute!(attrib: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.addUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, addUnicodeLocaleAttribute(b1, attrib))
        })


    pub def removeUnicodeLocaleAttribute!(attrib: String, b: Builder[r]): Result[String, Builder[r]] \ Write(r) =
        Interop/Flix/Util.try(_ -> {
            import java.util.Locale$Builder.removeUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let Builder(rc, b1) = b;
            Builder(rc, removeUnicodeLocaleAttribute(b1, attrib))
        })


    pub def clear!(b: Builder[r]): Builder[r] \ Write(r) =
        import java.util.Locale$Builder.clear( ): ##java.util.Locale$Builder \ r;
        let Builder(rc, b1) = b;
        Builder(rc, clear(b1))

    pub def clearExtensions!(b: Builder[r]): Builder[r] \ Write(r) =
        import java.util.Locale$Builder.clearExtensions(  ): ##java.util.Locale$Builder \ r;
        let Builder(rc, b1) = b;
        Builder(rc, clearExtensions(b1))

    pub def build(b: Builder[r]): Locale \ Write(r) =
        import java.util.Locale$Builder.build(): ##java.util.Locale \ r;
        let Builder(_, b1) = b;
        Locale(build(b1))

}   
