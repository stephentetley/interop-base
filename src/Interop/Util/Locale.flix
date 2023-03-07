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

namespace Interop/Util {

    /// 
    /// Locale is a wrapper over the Java class `java.util.Locale`.
    /// Class / Immutable
    pub enum Locale(##java.util.Locale)

    instance ToString[Locale] {
        pub def toString(x: Locale): String = 
            Interop/Util/Locale.toString(x)
    }

    instance Eq[Locale] {
        pub def eq(x: Locale, y: Locale): Bool = 
            Interop/Util/Locale.equals(x, y)
    }

    instance Hash[Locale] {
        pub def hash(x: Locale): Int32 = 
            Interop/Util/Locale.hashCode(x)
    }

    instance Interop/Flix.Marshal[Locale] {
        pub def toJavaObject(x: Locale): ##java.lang.Object =
            let Locale(x1) = x;
            unsafe_cast x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Locale = 
            Locale(unsafe_cast o as ##java.util.Locale)
    }

}



namespace Interop/Util/Locale {

    use Interop/Util.Locale
    use Interop/Util.Locale.{Locale}

    use Interop/Util/Locale.LanguageRange
    use Interop/Util/Locale.LanguageRange.{LanguageRange}

    /// 
    /// `Category` is an enum for Locale categories.
    /// 
    /// Case `Display` represents the default locale for displaying user interfaces.
    //
    /// Case `Format` represents the default locale for formatting dates / times / numbers etc.
    //
    pub enum Category with Eq, Order, Boxable, Hash, ToString {
        case Display
        case Format
    }


    pub enum FilteringMode with Eq, Order, Boxable, Hash, ToString {
        case AutoselectFiltering
        case ExtendedFiltering
        case IgnoreExtendedRanges
        case MapExtendedRanges
        case RejectExtendedRanges
    }


    pub def marshalFilteringMode(x: FilteringMode): ##java.util.Locale$FilteringMode =
        import static get java.util.Locale$FilteringMode.AUTOSELECT_FILTERING: ##java.util.Locale$FilteringMode \ {} as get_AUTOSELECT_FILTERING;
        import static get java.util.Locale$FilteringMode.EXTENDED_FILTERING: ##java.util.Locale$FilteringMode \ {} as get_EXTENDED_FILTERING;
        import static get java.util.Locale$FilteringMode.IGNORE_EXTENDED_RANGES: ##java.util.Locale$FilteringMode \ {} as get_IGNORE_EXTENDED_RANGES;
        import static get java.util.Locale$FilteringMode.MAP_EXTENDED_RANGES: ##java.util.Locale$FilteringMode \ {} as get_MAP_EXTENDED_RANGES;
        import static get java.util.Locale$FilteringMode.REJECT_EXTENDED_RANGES: ##java.util.Locale$FilteringMode \ {} as get_REJECT_EXTENDED_RANGES;
        match x {
            case AutoselectFiltering    => get_AUTOSELECT_FILTERING()
            case ExtendedFiltering      => get_EXTENDED_FILTERING()
            case IgnoreExtendedRanges   => get_IGNORE_EXTENDED_RANGES()
            case MapExtendedRanges      => get_MAP_EXTENDED_RANGES()
            case RejectExtendedRanges   => get_REJECT_EXTENDED_RANGES()
        }

    pub enum IsoCountryCode with Eq, Order, Boxable, Hash, ToString {
        case Part1Alpha2
        case Part1Alpha3
        case Part3
    }

    pub def marshalIsoCountryCode(x: IsoCountryCode): ##java.util.Locale$IsoCountryCode =
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA2: ##java.util.Locale$IsoCountryCode \ {} as get_PART1_ALPHA2;
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA3: ##java.util.Locale$IsoCountryCode \ {} as get_PART1_ALPHA3;
        import static get java.util.Locale$IsoCountryCode.PART3: ##java.util.Locale$IsoCountryCode \ {} as get_PART3;
        match x {
            case Part1Alpha2    => get_PART1_ALPHA2()
            case Part1Alpha3    => get_PART1_ALPHA3()
            case Part3          => get_PART3()
        }



    pub def getHH(loc: Locale): ##java.util.Locale = 
        let Locale(loc1) = loc;
        loc1

    /// Design note
    /// `new` functions should not return Result as there isn't a tangible notion of failure.
    /// Unrecognized locales can be built - operations on them won't produce results.


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def newLocale(lang: String): Locale =
        import new java.util.Locale(String): ##java.util.Locale & Pure as new1;
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
        try {
            import static java.util.Locale.setDefault(##java.util.Locale): Unit \ IO;
            let Locale(x1) = x;
            setDefault(x1);
            Ok()
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }




    pub def setJvmDefaultLocaleWithCategory!(category: Category, x: Locale): Result[String, Unit] \ IO =
        import static java.util.Locale.setDefault(##java.util.Locale$Category, ##java.util.Locale): Unit \ IO;
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category \ {} as getDisplay;
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category \ {} as getFormat;
        try {
            let Locale(x1) = x;
            let cat1 = match category {
                case Display => getDisplay()
                case Format  => getFormat()
            };
            setDefault(cat1, x1);
            Ok()
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def equals(x: Locale, y: Locale): Bool =
        import java.util.Locale.equals(##java.lang.Object): Bool \ {};
        let Locale(x1) = x;
        let Locale(y1) = y;
        equals(x1, unsafe_cast y1 as ##java.lang.Object)

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

    pub def getDefaultWithCategory(x: Category): Locale \ IO =
        import static java.util.Locale.getDefault(##java.util.Locale$Category): ##java.util.Locale \ IO;
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category \ {} as getDisplay;
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category \ {} as getFormat;
        match x {
            case Display => getDisplay() |> getDefault |> Locale
            case Format  => getFormat() |> getDefault |> Locale
        }

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
        try {
            import java.util.Locale.getISO3Country(): String \ {};
            let Locale(x1) = x;
            getISO3Country(x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getISO3Language(x: Locale): Result[String, String] =
        try {
            import java.util.Locale.getISO3Language(): String \ {};
            let Locale(x1) = x;
            getISO3Language(x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

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
        import static java.util.Locale.getAvailableLocales(): Array[##java.util.Locale, rc] \ { Write(rc), IO } ;
        let _ = Array#{} @ rc;
        let xs = getAvailableLocales() |> Array.toList;
        List.map(Locale, xs)
    }

    pub def getIsoCountries(): List[String] = region rc {
        import static java.util.Locale.getISOCountries(): Array[String, rc] \ Write(rc);
        let _ = Array#{} @ rc;
        getISOCountries() |> Array.toList
    }

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[String, Set[String]] = region r {
        try {
            import static java.util.Locale.getISOCountries(##java.util.Locale$IsoCountryCode): ##java.util.Set \ {};
            let icc1 = marshalIsoCountryCode(icc);
            getISOCountries(icc1)             
                |> Interop/Util/SetZ.wrapHH(r)
                |> Interop/Util/SetZ.toFlixSet
                |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    pub def getIsoLanguages(): Result[String, List[String]] =
        Interop/Flix/Util.try(_ -> {
            region rc {
                import static java.util.Locale.getISOLanguages(): Array[String, rc] \ Write(rc);
                let _ = Array#{} @ rc;            
                getISOLanguages() |> Array.toList
            }
        })

    pub def getExtension(key: Char, x: Locale): Result[String, String] =
        try {
            import java.util.Locale.getExtension(Char): String \ {};
            let Locale(x1) = x;
            let ext = getExtension(x1, key);
            Interop/Flix/Util.getStringWithoutNull(default = "", ext) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def getExtensionKeys(x: Locale): Set[Char] = region rc {
        import java.util.Locale.getExtensionKeys(): ##java.util.Set \ {};
        let Locale(x1) = x;
        getExtensionKeys(x1) 
            |> Interop/Util/SetZ.wrapHH(rc)
            |> Interop/Util/SetZ.toFlixSet
    }

    pub def getUnicodeLocaleAttributes(x: Locale): Set[String] = region rc {
        import java.util.Locale.getUnicodeLocaleAttributes(): ##java.util.Set \ {};
        let Locale(x1) = x;
        getUnicodeLocaleAttributes(x1) 
            |> Interop/Util/SetZ.wrapHH(rc)
            |> Interop/Util/SetZ.toFlixSet
    }

    pub def getUnicodeLocaleKeys(x: Locale): Set[String] = region rc {
        import java.util.Locale.getUnicodeLocaleKeys(): ##java.util.Set \ {};
        let Locale(x1) = x;
        getUnicodeLocaleKeys(x1) 
            |> Interop/Util/SetZ.wrapHH(rc)
            |> Interop/Util/SetZ.toFlixSet
    }

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, Option[Locale]] = region rc {
        try {
            import static java.util.Locale.lookup(##java.util.List, ##java.util.Collection): ##java.util.Locale \ {};
            let ls  = Interop/Util/ArrayList.fromFoldable(rc, priorityList) |> Interop/Util/ListZ.toListHH;
            let col = Interop/Util/ArrayList.fromFoldable(rc, locales)      |> Interop/Util/Collection.toCollectionHH;
            let ans = lookup(ls, col);
            Object.toOption(ans) |> Option.map(Locale) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
    }

    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Result[String, Option[String]] =
        region rc {
            try { 
                import static java.util.Locale.lookupTag(##java.util.List, ##java.util.Collection): String \ {};
                let ls      = Interop/Util/ArrayList.fromFoldable(rc, priorityList) |> Interop/Util/ListZ.toListHH;
                let col     = Interop/Util/ArrayList.fromFoldable(rc, tags)         |> Interop/Util/Collection.toCollectionHH;
                let ans     = lookupTag(ls, col);
                Object.toOption(ans) |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): Result[String, List[Locale]] = 
        import static java.util.Locale.filter(##java.util.List, ##java.util.Collection): ##java.util.List \ {};
        region rc {
            try {
                let ls      = Interop/Util/ArrayList.fromFoldable(rc, priorityList) |> Interop/Util/ListZ.toListHH;
                let col     = Interop/Util/ArrayList.fromFoldable(rc, locales)      |> Interop/Util/Collection.toCollectionHH;
                let prim    = filter(ls, col);
                Interop/Util/ListZ.wrapHH(rc, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def filterWithFilteringMode(priorityList: List[LanguageRange], 
                                    mode: FilteringMode, 
                                    locales: List[Locale]): Result[String, List[Locale]] = 
        region rc {
            try {
                import static java.util.Locale.filter(##java.util.List, ##java.util.Collection, ##java.util.Locale$FilteringMode): ##java.util.List \ {};
                let ps      = Interop/Util/ArrayList.fromFoldable(rc, priorityList) |> Interop/Util/ListZ.toListHH;
                let col     = Interop/Util/ArrayList.fromFoldable(rc, locales)      |> Interop/Util/Collection.toCollectionHH;
                let mode1   = marshalFilteringMode(mode);
                let prim    = filter(ps, col, mode1);
                Interop/Util/ListZ.wrapHH(rc, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): Result[String, List[String]] = 
        region rc {
            try {
                import static java.util.Locale.filterTags(##java.util.List, ##java.util.Collection): ##java.util.List \ {};
                let ls      = Interop/Util/ArrayList.fromFoldable(rc, priorityList) |> Interop/Util/ListZ.toListHH;
                let col     = Interop/Util/ArrayList.fromFoldable(rc, tags)         |> Interop/Util/Collection.toCollectionHH;
                let prim    = filterTags(ls, col);
                Interop/Util/ListZ.wrapHH(rc, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }

    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], 
                                        mode: FilteringMode, 
                                        tags: List[String]): Result[String, List[String]] = 
        region rc {
            try {
                import static java.util.Locale.filterTags(##java.util.List, ##java.util.Collection, ##java.util.Locale$FilteringMode): ##java.util.List \ {};
                let ls      = Interop/Util/ArrayList.fromFoldable(rc, priorityList) |> Interop/Util/ListZ.toListHH;
                let col     = Interop/Util/ArrayList.fromFoldable(rc, tags)         |> Interop/Util/Collection.toCollectionHH;
                let mode1   = marshalFilteringMode(mode);
                let prim    = filterTags(ls, col, mode1);
                Interop/Util/ListZ.wrapHH(rc, prim) 
                    |> Interop/Util/ListZ.toFlixList
                    |> Ok
            } catch {
                case ex: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(ex))
            }
        }
}
