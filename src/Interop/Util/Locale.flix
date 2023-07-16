/*
 * Copyright 2020 Stephen Tetley
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

    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}
    
    /// 
    /// Locale is a wrapper over the Java class `java.util.Locale`.
    /// Class / Immutable
    pub enum Locale(##java.util.Locale)

    instance ToString[Locale] {
        pub def toString(x: Locale): String = 
            Interop.Util.Locale.toString(x)
    }

    instance Eq[Locale] {
        pub def eq(x: Locale, y: Locale): Bool = 
            Interop.Util.Locale.equals(x, y)
    }

    instance Hash[Locale] {
        pub def hash(x: Locale): Int32 = 
            Interop.Util.Locale.hashCode(x)
    }
    
    instance Interop.Flix.GoesToJava[Locale] {
        pub def toJavaObject(x: Locale): ##java.lang.Object =
            let Locale(x1) = x;
            checked_cast(x1)
    }
    
    instance Interop.Flix.ComesFromJava[Locale] {
        pub def fromJavaObject(o: ##java.lang.Object): Locale = 
            Locale(unchecked_cast(o as ##java.util.Locale))
    }

}



mod Interop.Util.Locale {

    use Interop.Util.Locale
    use Interop.Util.Locale.{Locale}
    use Interop.Util.LocaleCategory
    use Interop.Util.LocaleCategory.{LocaleCategory}
    use Interop.Util.LocaleFilteringMode
    use Interop.Util.LocaleFilteringMode.{LocaleFilteringMode}
    use Interop.Util.LocaleIsoCountryCode
    use Interop.Util.LocaleIsoCountryCode.{LocaleIsoCountryCode}
    use Interop.Util.Locale.LanguageRange
    use Interop.Util.Locale.LanguageRange.{LanguageRange}

    /// TODO - move enums into Basis-Base...



    pub def getHH(loc: Locale): ##java.util.Locale = 
        let Locale(loc1) = loc;
        loc1


    pub def wrapHH(prim: ##java.util.Locale): Locale = 
        Locale(prim)


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def newLocale(lang: String): Locale =
        import new java.util.Locale(String): ##java.util.Locale \ {} as new1;
        Locale(new1(lang))

    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(lang: {lang = String}, country: {country = String}): Locale =
        import new java.util.Locale(String, String): ##java.util.Locale \ {} as new1;
        Locale(new1(lang.lang, country.country))

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def newLocaleWithVariant(lang: {lang = String}, country: {country = String}, variant: {variant = String}): Locale =
        import new java.util.Locale(String, String, String): ##java.util.Locale \ {} as new1;
        Locale(new1(lang.lang, country.country, variant.variant))



    pub def setJvmDefaultLocale!(x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.setDefault(##java.util.Locale): Unit \ IO;
            let Locale(x1) = x;
            setDefault(x1)
        })




    pub def setJvmDefaultLocaleWithCategory!(cat: LocaleCategory, x: Locale): Result[String, Unit] \ IO =
        Result.tryCatch(_ -> {
            import static java.util.Locale.setDefault(##java.util.Locale$Category, ##java.util.Locale): Unit \ IO;
            let Locale(x1) = x;
            let LocaleCategory(cat1) = cat;
            setDefault(cat1, x1)
        })

    pub def equals(x: Locale, y: Locale): Bool =
        import java.util.Locale.equals(##java.lang.Object): Bool \ {};
        let Locale(x1) = x;
        let Locale(y1) = y;
        equals(x1, checked_cast(y1))

    pub def toString(x: Locale): String =
        import java.util.Locale.toString(): String \ {};
        let Locale(x1) = x;
        toString(x1)

    pub def hashCode(x: Locale): Int32 =
        import java.util.Locale.hashCode(): Int32 \ {};
        let Locale(x1) = x;
        hashCode(x1)

    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        import static get java.util.Locale.ROOT: ##java.util.Locale \ {} as get_ROOT;
        Locale(get_ROOT())

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        import static get java.util.Locale.CANADA: ##java.util.Locale \ {} as get_CANADA;
        Locale(get_CANADA())

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        import static get java.util.Locale.CANADA_FRENCH: ##java.util.Locale \ {} as get_CANADA_FRENCH;
        Locale(get_CANADA_FRENCH())

    pub def china(): Locale =
        import static get java.util.Locale.CHINA: ##java.util.Locale \ {} as get_CHINA;
        Locale(get_CHINA())

    pub def chinese(): Locale =
        import static get java.util.Locale.CHINESE: ##java.util.Locale \ {} as get_CHINESE;
        Locale(get_CHINESE())

    pub def english(): Locale =
        import static get java.util.Locale.ENGLISH: ##java.util.Locale \ {} as get_ENGLISH;
        Locale(get_ENGLISH())

    pub def france(): Locale =
        import static get java.util.Locale.FRANCE: ##java.util.Locale \ {} as get_FRANCE;
        Locale(get_FRANCE())

    pub def french(): Locale =
        import static get java.util.Locale.FRENCH: ##java.util.Locale \ {} as get_FRENCH;
        Locale(get_FRENCH())

    pub def german(): Locale =
        import static get java.util.Locale.GERMAN: ##java.util.Locale \ {} as get_GERMAN;
        Locale(get_GERMAN())

    pub def germany(): Locale =
        import static get java.util.Locale.GERMANY: ##java.util.Locale \ {} as get_GERMANY;
        Locale(get_GERMANY())

    pub def italian(): Locale =
        import static get java.util.Locale.ITALIAN: ##java.util.Locale \ {} as get_ITALIAN;
        Locale(get_ITALIAN())

    pub def italy(): Locale =
        import static get java.util.Locale.ITALY: ##java.util.Locale \ {} as get_ITALY;
        Locale(get_ITALY())

    pub def japan(): Locale =
        import static get java.util.Locale.JAPAN: ##java.util.Locale \ {} as get_JAPAN;
        Locale(get_JAPAN())

    pub def japanese(): Locale =
        import static get java.util.Locale.JAPANESE: ##java.util.Locale \ {} as get_JAPANESE;
        Locale(get_JAPANESE())

    pub def korea(): Locale =
        import static get java.util.Locale.KOREA: ##java.util.Locale \ {} as get_KOREA;
        Locale(get_KOREA())

    pub def korean(): Locale =
        import static get java.util.Locale.KOREAN: ##java.util.Locale \ {} as get_KOREAN;
        Locale(get_KOREAN())

    pub def prc(): Locale =
        import static get java.util.Locale.PRC: ##java.util.Locale \ {} as get_PRC;
        Locale(get_PRC())


    pub def simplified_chinese(): Locale =
        import static get java.util.Locale.SIMPLIFIED_CHINESE: ##java.util.Locale \ {} as get_SIMPLIFIED_CHINESE;
        Locale(get_SIMPLIFIED_CHINESE())

    pub def taiwan(): Locale =
        import static get java.util.Locale.TAIWAN: ##java.util.Locale \ {} as get_TAIWAN;
        Locale(get_TAIWAN())

    pub def traditional_chinese(): Locale =
        import static get java.util.Locale.TRADITIONAL_CHINESE: ##java.util.Locale \ {} as get_TRADITIONAL_CHINESE;
        Locale(get_TRADITIONAL_CHINESE())

    pub def uk(): Locale =
        import static get java.util.Locale.UK: ##java.util.Locale \ {} as get_UK;
        Locale(get_UK())

    pub def us(): Locale =
        import static get java.util.Locale.US: ##java.util.Locale \ {} as get_US;
        Locale(get_US())


    pub def getDefault(): Locale \ IO =
        import static java.util.Locale.getDefault(): ##java.util.Locale \ IO;
        Locale(getDefault())

    pub def getDefaultWithCategory(cat: LocaleCategory): Locale \ IO =
        import static java.util.Locale.getDefault(##java.util.Locale$Category): ##java.util.Locale \ IO;
        let LocaleCategory(cat1) = cat;
        Locale(getDefault(cat1))

    pub def getCountry(x: Locale): String =
        import java.util.Locale.getCountry(): String \ {};
        let Locale(x1) = x;
        getCountry(x1)

    pub def getLanguage(x: Locale): String =
        import java.util.Locale.getLanguage(): String \ {};
        let Locale(x1) = x;
        getLanguage(x1)

    pub def getScript(x: Locale): String =
        import java.util.Locale.getScript(): String \ {};
        let Locale(x1) = x;
        getScript(x1)

    pub def getISO3Country(x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            import java.util.Locale.getISO3Country(): String \ {};
            let Locale(x1) = x;
            getISO3Country(x1)
        })

    pub def getISO3Language(x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            import java.util.Locale.getISO3Language(): String \ {};
            let Locale(x1) = x;
            getISO3Language(x1)
        })

    pub def getDisplayCountry(x: Locale): String =
        import java.util.Locale.getDisplayCountry(): String \ {};
        let Locale(x1) = x;
        getDisplayCountry(x1)

    pub def getDisplayCountryWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayCountry(##java.util.Locale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayCountry(x1, inLocale1)

    pub def getDisplayLanguage(x: Locale): String =
        import java.util.Locale.getDisplayLanguage(): String \ {};
        let Locale(x1) = x;
        getDisplayLanguage(x1)

    pub def getDisplayLanguageWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayLanguage(##java.util.Locale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayLanguage(x1, inLocale1)

    pub def getDisplayName(x: Locale): String =
        import java.util.Locale.getDisplayName(): String \ {};
        let Locale(x1) = x;
        getDisplayName(x1)

    pub def getDisplayNameWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayName(##java.util.Locale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayName(x1, inLocale1)

    pub def getDisplayScript(x: Locale): String =
        import java.util.Locale.getDisplayScript(): String \ {};
        let Locale(x1) = x;
        getDisplayScript(x1)

    pub def getDisplayScriptWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayScript(##java.util.Locale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayScript(x1, inLocale1)


    pub def getDisplayVariant(x: Locale): String =
        import java.util.Locale.getDisplayVariant(): String \ {};
        let Locale(x1) = x;
        getDisplayVariant(x1)

    pub def getDisplayVariantWithLocale(inLocale: {inLocale = Locale}, x: Locale): String =
        import java.util.Locale.getDisplayVariant(##java.util.Locale): String \ {};
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayVariant(x1, inLocale1)        

    pub def hasExtensions(x: Locale): Bool =
        import java.util.Locale.hasExtensions(): Bool \ {};
        let Locale(x1) = x;
        hasExtensions(x1)

    /// Produces a new Locale...
    pub def stripExtensions(x: Locale): Locale =
        import java.util.Locale.stripExtensions(): ##java.util.Locale \ {};
        let Locale(x1) = x;
        Locale(stripExtensions(x1))


    pub def toLanguageTag(x: Locale): String =
        import java.util.Locale.toLanguageTag(): String \ {};
        let Locale(x1) = x;
        toLanguageTag(x1)

    pub def forLanguageTag(tag: String): Locale =
        import static java.util.Locale.forLanguageTag(String): ##java.util.Locale \ {};
        Locale(forLanguageTag(tag))



    /// This marshals okay...
    pub def getAvailableLocales(): List[Locale] \ IO = region rc {
        import static java.util.Locale.getAvailableLocales(): Array[##java.util.Locale, rc] \ { rc, IO } ;
        let _ = Array#{} @ rc;
        let xs = getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }

    pub def getIsoCountries(): List[String] = region rc {
        import static java.util.Locale.getISOCountries(): Array[String, rc] \ rc;
        let _ = Array#{} @ rc;
        getISOCountries() |> Array.toList
    }

    pub def getIsoCountriesWithIsoCountryCode(icc: LocaleIsoCountryCode): Result[String, Set[String]] =
        Result.tryCatch(_ -> {
            import static java.util.Locale.getISOCountries(##java.util.Locale$IsoCountryCode): ##java.util.Set \ {};
            let LocaleIsoCountryCode(icc1) = icc;
            getISOCountries(icc1) |> Interop.Util.SetZ.primSetToFlixSet
        })


    pub def getIsoLanguages(): Result[String, List[String]] =
        Result.tryCatch(_ -> {
            region rc {
                import static java.util.Locale.getISOLanguages(): Array[String, rc] \ rc;
                let _ = Array#{} @ rc;            
                getISOLanguages() |> Array.toList
            }
        })

    pub def getExtension(key: Char, x: Locale): Result[String, String] =
        Result.tryCatch(_ -> {
            import java.util.Locale.getExtension(Char): String \ {};
            let Locale(x1) = x;
            getExtension(x1, key) |> Interop.Flix.Util.getStringWithoutNull(default = "")
        })

    pub def getExtensionKeys(x: Locale): Set[Char] = 
        import java.util.Locale.getExtensionKeys(): ##java.util.Set \ {};
        let Locale(x1) = x;
        getExtensionKeys(x1) |> Interop.Util.SetZ.primSetToFlixSet


    pub def getUnicodeLocaleAttributes(x: Locale): Set[String] =
        import java.util.Locale.getUnicodeLocaleAttributes(): ##java.util.Set \ {};
        let Locale(x1) = x;
        getUnicodeLocaleAttributes(x1) |> Interop.Util.SetZ.primSetToFlixSet


    pub def getUnicodeLocaleKeys(x: Locale): Set[String] = 
        import java.util.Locale.getUnicodeLocaleKeys(): ##java.util.Set \ {};
        let Locale(x1) = x;
        getUnicodeLocaleKeys(x1) |> Interop.Util.SetZ.primSetToFlixSet


    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, Option[Locale]] =
        Result.tryCatch(_ -> {
            import static java.util.Locale.lookup(##java.util.List, ##java.util.Collection): ##java.util.Locale \ {};
            let ls  = Interop.Util.ListZ.fromFoldableViaArrayListHH(priorityList);
            let col = Interop.Util.Collection.fromFoldableViaArrayListHH(locales);
            lookup(ls, col) |> Object.toOption |> Option.map(Locale)
        })


    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Result[String, Option[String]] =
        Result.tryCatch(_ -> {
            import static java.util.Locale.lookupTag(##java.util.List, ##java.util.Collection): String \ {};
            let ls      = Interop.Util.ListZ.fromFoldableViaArrayListHH(priorityList);
            let col     = Interop.Util.Collection.fromFoldableViaArrayListHH(tags);
            lookupTag(ls, col) |> Object.toOption
        })


    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, List[Locale]] =         
        Result.tryCatch(_ -> {
            import static java.util.Locale.filter(##java.util.List, ##java.util.Collection): ##java.util.List \ {};
            let ls      = Interop.Util.ListZ.fromFoldableViaArrayListHH(priorityList);
            let col     = Interop.Util.Collection.fromFoldableViaArrayListHH(locales);
            filter(ls, col) |> Interop.Util.ListZ.primListToFlixList
        })


    pub def filterWithFilteringMode(priorityList: List[LanguageRange], 
                                    mode: LocaleFilteringMode, 
                                    locales: List[Locale]): Result[String, List[Locale]] = 
        Result.tryCatch(_ -> {
            import static java.util.Locale.filter(##java.util.List, ##java.util.Collection, ##java.util.Locale$FilteringMode): ##java.util.List \ {};
            let ps      = Interop.Util.ListZ.fromFoldableViaArrayListHH(priorityList);
            let col     = Interop.Util.Collection.fromFoldableViaArrayListHH(locales);
            let LocaleFilteringMode(mode1) = mode;
            filter(ps, col, mode1) |> Interop.Util.ListZ.primListToFlixList
        })

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): Result[String, List[String]] = 
        Result.tryCatch(_ -> {
            import static java.util.Locale.filterTags(##java.util.List, ##java.util.Collection): ##java.util.List \ {};
            let ls      = Interop.Util.ListZ.fromFoldableViaArrayListHH(priorityList);
            let col     = Interop.Util.Collection.fromFoldableViaArrayListHH(tags);
            filterTags(ls, col) |> Interop.Util.ListZ.primListToFlixList
        })

    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], 
                                        mode: LocaleFilteringMode, 
                                        tags: List[String]): Result[String, List[String]] = 
        Result.tryCatch(_ -> {
            import static java.util.Locale.filterTags(##java.util.List, ##java.util.Collection, ##java.util.Locale$FilteringMode): ##java.util.List \ {};
            let ls      = Interop.Util.ListZ.fromFoldableViaArrayListHH(priorityList);
            let col     = Interop.Util.Collection.fromFoldableViaArrayListHH(tags);
            let LocaleFilteringMode(mode1) = mode;
            filterTags(ls, col, mode1) |> Interop.Util.ListZ.primListToFlixList
        })
}
