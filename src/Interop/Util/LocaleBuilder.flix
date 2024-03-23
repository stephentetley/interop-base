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

    pub enum LocaleBuilder[_: Region](##java.util.Locale$Builder)
    
}


mod Interop.Util.LocaleBuilder {

    use Interop.Util.LocaleBuilder
    use Interop.Util.LocaleBuilder.{LocaleBuilder}
    use Locale.{Locale}

    pub def getHH(b: LocaleBuilder[r]): ##java.util.Locale$Builder = 
        let LocaleBuilder(b1) = b;
        b1

    pub def wrapHH(_: Region[r], prim: ##java.util.Locale$Builder): LocaleBuilder[r] = 
        LocaleBuilder(prim)


    pub def make(_: Region[r]): LocaleBuilder[r] \ r =
        import java_new java.util.Locale$Builder(): ##java.util.Locale$Builder \ r as new1;
        LocaleBuilder(new1())


    pub def build(b: LocaleBuilder[r]): Locale \ r =
        import java.util.Locale$Builder.build(): ##java.util.Locale \ r;
        let LocaleBuilder(b1) = b;
        Locale(build(b1))

    pub def setLocale!(loc: Locale, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setLocale(##java.util.Locale): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            let Locale(loc1) = loc;
            setLocale(lb1, loc1) |> LocaleBuilder
        })

    pub def setLanguageTag!(tag: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setLanguageTag(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setLanguageTag(lb1, tag) |> LocaleBuilder
        })

    pub def setLanguage!(lang: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setLanguage(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setLanguage(lb1, lang) |> LocaleBuilder
        })

    pub def setScript!(scr: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setScript(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setScript(lb1, scr) |> LocaleBuilder
        })

    pub def setRegion!(rgn: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setRegion(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setRegion(lb1, rgn) |> LocaleBuilder
        })


    pub def setVariant!(vnt: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setVariant(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setVariant(lb1, vnt) |> LocaleBuilder
        })


    pub def setExtension!(k: Char, v: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setExtension(Char, String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setExtension(lb1, k, v) |> LocaleBuilder
        })

    pub def setUnicodeLocaleKeyword!(k: String, ty: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.setUnicodeLocaleKeyword(String, String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            setUnicodeLocaleKeyword(lb1, k, ty) |> LocaleBuilder
        })


    pub def addUnicodeLocaleAttribute!(attrib: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.addUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            addUnicodeLocaleAttribute(lb1, attrib) |> LocaleBuilder
        })


    pub def removeUnicodeLocaleAttribute!(attrib: String, lb: LocaleBuilder[r]): Result[String, LocaleBuilder[r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.Locale$Builder.removeUnicodeLocaleAttribute(String): ##java.util.Locale$Builder \ r;
            let LocaleBuilder(lb1) = lb;
            removeUnicodeLocaleAttribute(lb1, attrib) |> LocaleBuilder
        })
        

    pub def clear!(lb: LocaleBuilder[r]): LocaleBuilder[r] \ r =
        import java.util.Locale$Builder.clear(): ##java.util.Locale$Builder \ r;
        let LocaleBuilder(lb1) = lb;
        clear(lb1) |> LocaleBuilder
        

    pub def clearExtensions!(lb: LocaleBuilder[r]): LocaleBuilder[r] \ r =
        import java.util.Locale$Builder.clearExtensions(): ##java.util.Locale$Builder \ r;
        let LocaleBuilder(lb1) = lb;
        clearExtensions(lb1) |> LocaleBuilder




}   
