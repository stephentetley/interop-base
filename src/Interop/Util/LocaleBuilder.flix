/*
 * Copyright 2023 Stephen Tetley
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

mod Interop.Util {

    pub enum LocaleBuilder(##java.util.Locale$Builder)
    
}


mod Interop.Util.LocaleBuilder {

    use Interop.Util.LocaleBuilder
    use Interop.Util.LocaleBuilder.{LocaleBuilder}
    use Interop.Util.LocaleBuilder.LocaleBuilderAction
    use Interop.Util.LocaleBuilder.LocaleBuilderAction.{
        AddUnicodeLocaleAttribute, Clear, ClearExtensions,
        RemoveUnicodeLocaleAttribute, SetExtension, SetLanguage,
        SetLanguageTag, SetLocale, SetRegion,
        SetScript, SetUnicodeLocaleKeyword, SetVariant
    }
    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}
    use Interop.Flix.Builder

    pub def getHH(b: LocaleBuilder): ##java.util.Locale$Builder = 
        let LocaleBuilder(b1) = b;
        b1

    pub def wrapHH(prim: ##java.util.Locale$Builder): LocaleBuilder = 
        LocaleBuilder(prim)

    pub enum LocaleBuilderAction {
        case AddUnicodeLocaleAttribute(String)
        case Clear
        case ClearExtensions
        case RemoveUnicodeLocaleAttribute(String)
        case SetExtension(Char, String)
        case SetLanguage(String)
        case SetLanguageTag(String)
        case SetLocale(Locale)
        case SetRegion(String)
        case SetScript(String)
        case SetUnicodeLocaleKeyword(String, String)
        case SetVariant(String)
    }
    

    pub def makeBuilder(rc: Region[r], xs: List[LocaleBuilderAction]): Builder[LocaleBuilder, r] = 
        def f(x) = match x {
            case AddUnicodeLocaleAttribute(x1)      => addUnicodeLocaleAttribute!(rc, x1)
            case Clear                              => clear!(rc)
            case ClearExtensions                    => clearExtensions!(rc)
            case RemoveUnicodeLocaleAttribute(x1)   => removeUnicodeLocaleAttribute!(rc, x1)
            case SetExtension(x1, y1)               => setExtension!(rc, x1, y1)
            case SetLanguage(x1)                    => setLanguage!(rc, x1)
            case SetLanguageTag(x1)                 => setLanguageTag!(rc, x1)
            case SetLocale(x1)                      => setLocale!(rc, x1)
            case SetRegion(x1)                      => setRegion!(rc, x1)
            case SetScript(x1)                      => setScript!(rc, x1)
            case SetUnicodeLocaleKeyword(x1, y1)    => setUnicodeLocaleKeyword!(rc, x1, y1)
            case SetVariant(x1)                     => setVariant!(rc, x1)
        };
        Interop.Flix.Builder.makeBuilder(rc, f, xs)


    pub def buildLocale(xs: List[LocaleBuilderAction]): Result[String, Locale] = region rc {
        new(rc) |> Interop.Flix.Builder.apply(rc, makeBuilder(rc, xs)) |> Result.map(build(rc))
    }

    pub def new(_: Region[r]): LocaleBuilder \ Write(r) =
        import new java.util.Locale$Builder(): ##java.util.Locale$Builder \ r as new1;
        LocaleBuilder(new1())


    pub def build(_: Region[r], b: LocaleBuilder): Locale \ Write(r) =
        import java.util.Locale$Builder.build(): ##java.util.Locale \ r;
        let LocaleBuilder(b1) = b;
        Locale(build(b1))

    pub def setLocale!(_: Region[r], loc: Locale): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setLocale(##java.util.Locale): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            let Locale(loc1) = loc;
            setLocale(b1, loc1) |> LocaleBuilder
        })

    pub def setLanguageTag!(_: Region[r], tag: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setLanguageTag(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setLanguageTag(b1, tag) |> LocaleBuilder
        })

    pub def setLanguage!(_: Region[r], lang: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setLanguage(b1, lang) |> LocaleBuilder
        })

    pub def setScript!(_: Region[r], scr: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setScript(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setScript(b1, scr) |> LocaleBuilder
        })

    pub def setRegion!(_: Region[r], rgn: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setRegion(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setRegion(b1, rgn) |> LocaleBuilder
        })


    pub def setVariant!(_: Region[r], vnt: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setVariant(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setVariant(b1, vnt) |> LocaleBuilder
        })


    pub def setExtension!(_: Region[r], k: Char, v: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setExtension(Char, String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setExtension(b1, k, v) |> LocaleBuilder
        })

    pub def setUnicodeLocaleKeyword!(_: Region[r], k: String, ty: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.setUnicodeLocaleKeyword(String, String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            setUnicodeLocaleKeyword(b1, k, ty) |> LocaleBuilder
        })


    pub def addUnicodeLocaleAttribute!(_: Region[r], attrib: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.addUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            addUnicodeLocaleAttribute(b1, attrib) |> LocaleBuilder
        })


    pub def removeUnicodeLocaleAttribute!(_: Region[r], attrib: String): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.removeUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            removeUnicodeLocaleAttribute(b1, attrib) |> LocaleBuilder
        })
        

    pub def clear!(_: Region[r]): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.clear(): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            clear(b1) |> LocaleBuilder
        })

    pub def clearExtensions!(_: Region[r]): Builder[LocaleBuilder, r] =
        Interop.Flix.Builder.lift(b -> {
            import java.util.Locale$Builder.clearExtensions(): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(b1) = b;
            clearExtensions(b1) |> LocaleBuilder
        })



}   
