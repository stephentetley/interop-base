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

    pub enum Builder[_: Region](##java.util.Locale$Builder)

    
}


namespace Interop/Util/Locale/Builder {

    use Interop/Util/Locale.Builder;
    use Interop/Util/Locale.Builder.{Builder};
    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    ///
    /// Returns a new LanguageRange for the supplied `range`.
    ///
    pub def new(_: Region[r]): Builder[r] \ Write(r) =
        import new java.util.Locale$Builder(): ##java.util.Locale$Builder \ r as new1;
        new1() |> Builder

    pub def setLocale!(loc: Locale, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setLocale(##java.util.Locale): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            let Locale(loc1) = loc;
            setLocale(lb1, loc1) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def setLanguageTag!(tag: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setLanguageTag(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setLanguageTag(lb1, tag) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def setLanguage!(lang: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setLanguage(lb1, lang) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def setScript!(scr: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setScript(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setScript(lb1, scr) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def setRegion!(rgn: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setRegion(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setRegion(lb1, rgn) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def setVariant!(vnt: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setVariant(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setVariant(lb1, vnt) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def setExtension!(k: Char, v: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setExtension(Char, String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setExtension(lb1, k, v) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def setUnicodeLocaleKeyword!(k: String, ty: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.setUnicodeLocaleKeyword(String, String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            setUnicodeLocaleKeyword(lb1, k, ty) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def addUnicodeLocaleAttribute!(attrib: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.addUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            addUnicodeLocaleAttribute(lb1, attrib) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def removeUnicodeLocaleAttribute!(attrib: String, lb: Builder[r]): Result[Builder[r], String] \ Write(r) =
        try {
            import java.util.Locale$Builder.removeUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let Builder(lb1) = lb;
            removeUnicodeLocaleAttribute(lb1, attrib) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def clear!(lb: Builder[r]): Builder[r] \ Write(r) =
        import java.util.Locale$Builder.clear(  ): ##java.util.Locale$Builder \ r;
        let Builder(lb1) = lb;
        clear(lb1) |> Builder

    pub def clearExtensions!(lb: Builder[r]): Builder[r] \ Write(r) =
        import java.util.Locale$Builder.clearExtensions(  ): ##java.util.Locale$Builder \ r;
        let Builder(lb1) = lb;
        clearExtensions(lb1) |> Builder

    pub def build(lb: Builder[r]): Locale \ Write(r) =
        import java.util.Locale$Builder.build(): ##java.util.Locale \ r;
        let Builder(lb1) = lb;
        build(lb1) |> Locale

}   
