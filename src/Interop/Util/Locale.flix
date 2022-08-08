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
    /// Immutable
    pub enum Locale(##java.util.Locale)


    instance Interop/Flix.Marshal[Locale] {
        pub def toJavaObject(x: Locale): ##java.lang.Object =
            let Locale(x1) = x;
            x1 as ##java.lang.Object

        pub def fromJavaObject(o: ##java.lang.Object): Locale = 
            Locale(o as ##java.util.Locale)
    }

}



namespace Interop/Util/Locale {

    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    use Interop/Util/Locale.LanguageRange;
    use Interop/Util/Locale.LanguageRange.{LanguageRange};

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
        import static get java.util.Locale$FilteringMode.AUTOSELECT_FILTERING: ##java.util.Locale$FilteringMode & Pure as get_AUTOSELECT_FILTERING;
        import static get java.util.Locale$FilteringMode.EXTENDED_FILTERING: ##java.util.Locale$FilteringMode & Pure as get_EXTENDED_FILTERING;
        import static get java.util.Locale$FilteringMode.IGNORE_EXTENDED_RANGES: ##java.util.Locale$FilteringMode & Pure as get_IGNORE_EXTENDED_RANGES;
        import static get java.util.Locale$FilteringMode.MAP_EXTENDED_RANGES: ##java.util.Locale$FilteringMode & Pure as get_MAP_EXTENDED_RANGES;
        import static get java.util.Locale$FilteringMode.REJECT_EXTENDED_RANGES: ##java.util.Locale$FilteringMode & Pure as get_REJECT_EXTENDED_RANGES;
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
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA2: ##java.util.Locale$IsoCountryCode & Pure as get_PART1_ALPHA2;
        import static get java.util.Locale$IsoCountryCode.PART1_ALPHA3: ##java.util.Locale$IsoCountryCode & Pure as get_PART1_ALPHA3;
        import static get java.util.Locale$IsoCountryCode.PART3: ##java.util.Locale$IsoCountryCode & Pure as get_PART3;
        match x {
            case Part1Alpha2    => get_PART1_ALPHA2()
            case Part1Alpha3    => get_PART1_ALPHA3()
            case Part3          => get_PART3()
        }




    /// Design note
    /// `new` functions should not return Result as there isn't a tangible notion of failure.
    /// Unrecognized locales can be built - operations on them won't produce results.


    ///
    /// Returns a new Locale for the supplied language.
    ///
    pub def newLocale(language: String): Locale =
        import new java.util.Locale(String): ##java.util.Locale & Pure as new1;
        Locale(new1(language))

    ///
    /// Returns a new Locale for the supplied language and country.
    ///
    pub def newLocaleWithCountry(r: {language :: String, country :: String}): Locale =
        import new java.util.Locale(String, String): ##java.util.Locale & Pure as new1;
        Locale(new1(r.language, r.country))

    ///
    /// Returns a new Locale for the supplied language, country and variant.
    ///
    /// `variant` is an arbitrary tag to distinguish this Locale from other locales 
    /// representing the same country and language.
    ///
    /// For guidelines to the formatting of a valid tag see the Javadoc for `java.util.Locale`.
    /// 
    pub def newLocaleWithVariant(r: {language :: String, country :: String, variant :: String}): Locale =
        import new java.util.Locale(String, String, String): ##java.util.Locale & Pure as new1;
        Locale(new1(r.language, r.country, r.variant))



    pub def setJvmDefaultLocale!(x: Locale): Result[Unit, String] & Impure =
        import static java.util.Locale.setDefault(##java.util.Locale): Unit & Impure;
        try {
            let Locale(x1) = x;
            setDefault(x1);
            Ok()
        } catch {
            case _: ##java.lang.Exception => Err("setJvmDefaultLocale! failed")
        }




    pub def setJvmDefaultLocaleWithCategory!(category: Category, x: Locale): Result[Unit, String] & Impure =
        import static java.util.Locale.setDefault(##java.util.Locale$Category, ##java.util.Locale): Unit & Impure;
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category & Pure as getDisplay;
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category & Pure as getFormat;
        try {
            let Locale(x1) = x;
            let cat1 = match category {
                case Display => getDisplay()
                case Format  => getFormat()
            };
            setDefault(cat1, x1);
            Ok()
        } catch {
            case _: ##java.lang.Exception => Err("setDefaultWithCategory! failed")
        }

    pub def equals(x: Locale, y: Locale): Bool =
        import java.util.Locale.equals(##java.lang.Object): Bool & Pure;
        let Locale(x1) = x;
        let Locale(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def toString(x: Locale): String =
        import java.util.Locale.toString(): String & Pure;
        let Locale(x1) = x;
        toString(x1)

    pub def hashCode(x: Locale): Int32 =
        import java.util.Locale.hashCode(): Int32 & Pure;
        let Locale(x1) = x;
        hashCode(x1)

    ///
    /// Returns the "root" locale.
    /// 
    /// The root locale has empty string for country, language and variant.
    ///
    pub def root(): Locale =
        import static get java.util.Locale.ROOT: ##java.util.Locale & Pure as get_ROOT;
        Locale(get_ROOT())

    ///
    /// Returns the locale for country Canada with language English.
    /// 
    pub def canada(): Locale =
        import static get java.util.Locale.CANADA: ##java.util.Locale & Pure as get_CANADA;
        Locale(get_CANADA())

    ///
    /// Returns the locale for country Canada with language French.
    /// 
    pub def canada_french(): Locale =
        import static get java.util.Locale.CANADA_FRENCH: ##java.util.Locale & Pure as get_CANADA_FRENCH;
        Locale(get_CANADA_FRENCH())

    pub def china(): Locale =
        import static get java.util.Locale.CHINA: ##java.util.Locale & Pure as get_CHINA;
        Locale(get_CHINA())

    pub def chinese(): Locale =
        import static get java.util.Locale.CHINESE: ##java.util.Locale & Pure as get_CHINESE;
        Locale(get_CHINESE())

    pub def english(): Locale =
        import static get java.util.Locale.ENGLISH: ##java.util.Locale & Pure as get_ENGLISH;
        Locale(get_ENGLISH())

    pub def france(): Locale =
        import static get java.util.Locale.FRANCE: ##java.util.Locale & Pure as get_FRANCE;
        Locale(get_FRANCE())

    pub def french(): Locale =
        import static get java.util.Locale.FRENCH: ##java.util.Locale & Pure as get_FRENCH;
        Locale(get_FRENCH())

    pub def german(): Locale =
        import static get java.util.Locale.GERMAN: ##java.util.Locale & Pure as get_GERMAN;
        Locale(get_GERMAN())

    pub def germany(): Locale =
        import static get java.util.Locale.GERMANY: ##java.util.Locale & Pure as get_GERMANY;
        Locale(get_GERMANY())

    pub def italian(): Locale =
        import static get java.util.Locale.ITALIAN: ##java.util.Locale & Pure as get_ITALIAN;
        Locale(get_ITALIAN())

    pub def italy(): Locale =
        import static get java.util.Locale.ITALY: ##java.util.Locale & Pure as get_ITALY;
        Locale(get_ITALY())

    pub def japan(): Locale =
        import static get java.util.Locale.JAPAN: ##java.util.Locale & Pure as get_JAPAN;
        Locale(get_JAPAN())

    pub def japanese(): Locale =
        import static get java.util.Locale.JAPANESE: ##java.util.Locale & Pure as get_JAPANESE;
        Locale(get_JAPANESE())

    pub def korea(): Locale =
        import static get java.util.Locale.KOREA: ##java.util.Locale & Pure as get_KOREA;
        Locale(get_KOREA())

    pub def korean(): Locale =
        import static get java.util.Locale.KOREAN: ##java.util.Locale & Pure as get_KOREAN;
        Locale(get_KOREAN())

    pub def prc(): Locale =
        import static get java.util.Locale.PRC: ##java.util.Locale & Pure as get_PRC;
        Locale(get_PRC())


    pub def simplified_chinese(): Locale =
        import static get java.util.Locale.SIMPLIFIED_CHINESE: ##java.util.Locale & Pure as get_SIMPLIFIED_CHINESE;
        Locale(get_SIMPLIFIED_CHINESE())

    pub def taiwan(): Locale =
        import static get java.util.Locale.TAIWAN: ##java.util.Locale & Pure as get_TAIWAN;
        Locale(get_TAIWAN())

    pub def traditional_chinese(): Locale =
        import static get java.util.Locale.TRADITIONAL_CHINESE: ##java.util.Locale & Pure as get_TRADITIONAL_CHINESE;
        Locale(get_TRADITIONAL_CHINESE())

    pub def uk(): Locale =
        import static get java.util.Locale.UK: ##java.util.Locale & Pure as get_UK;
        Locale(get_UK())

    pub def us(): Locale =
        import static get java.util.Locale.US: ##java.util.Locale & Pure as get_US;
        Locale(get_US())


    pub def getDefault(): Locale & Impure =
        import static java.util.Locale.getDefault(): ##java.util.Locale & Impure;
        Locale(getDefault())

    pub def getDefaultWithCategory(x: Category): Locale & Impure =
        import static java.util.Locale.getDefault(##java.util.Locale$Category): ##java.util.Locale & Impure;
        import static get java.util.Locale$Category.DISPLAY: ##java.util.Locale$Category & Pure as getDisplay;
        import static get java.util.Locale$Category.FORMAT: ##java.util.Locale$Category & Pure as getFormat;
        match x {
            case Display => getDisplay() |> getDefault |> Locale
            case Format  => getFormat() |> getDefault |> Locale
        }

    pub def getCountry(x: Locale): String =
        import java.util.Locale.getCountry(): String & Pure;
        let Locale(x1) = x;
        getCountry(x1)

    pub def getLanguage(x: Locale): String =
        import java.util.Locale.getLanguage(): String & Pure;
        let Locale(x1) = x;
        getLanguage(x1)

    pub def getScript(x: Locale): String =
        import java.util.Locale.getScript(): String & Pure;
        let Locale(x1) = x;
        getScript(x1)

    pub def getISO3Country(x: Locale): Option[String] =
        import java.util.Locale.getISO3Country(): String & Pure;
        try {
            let Locale(x1) = x;
            Some(getISO3Country(x1))
        } catch {
            case _: ##java.util.MissingResourceException => None
        }

    pub def getISO3Language(x: Locale): Option[String] =
        import java.util.Locale.getISO3Language(): String & Pure;
        try {
            let Locale(x1) = x;
            Some(getISO3Language(x1))
        } catch {
            case _: ##java.util.MissingResourceException => None
        }

    pub def getDisplayCountry(x: Locale): String =
        import java.util.Locale.getDisplayCountry(): String & Pure;
        let Locale(x1) = x;
        getDisplayCountry(x1)

    pub def getDisplayCountryWithLocale(inLocale: {inLocale :: Locale}, x: Locale): String =
        import java.util.Locale.getDisplayCountry(##java.util.Locale): String & Pure;
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayCountry(x1, inLocale1)

    pub def getDisplayLanguage(x: Locale): String =
        import java.util.Locale.getDisplayLanguage(): String & Pure;
        let Locale(x1) = x;
        getDisplayLanguage(x1)

    pub def getDisplayLanguageWithLocale(inLocale: {inLocale :: Locale}, x: Locale): String =
        import java.util.Locale.getDisplayLanguage(##java.util.Locale): String & Pure;
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayLanguage(x1, inLocale1)

    pub def getDisplayName(x: Locale): String =
        import java.util.Locale.getDisplayName(): String & Pure;
        let Locale(x1) = x;
        getDisplayName(x1)

    pub def getDisplayNameWithLocale(inLocale: {inLocale :: Locale}, x: Locale): String =
        import java.util.Locale.getDisplayName(##java.util.Locale): String & Pure;
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayName(x1, inLocale1)

    pub def getDisplayScript(x: Locale): String =
        import java.util.Locale.getDisplayScript(): String & Pure;
        let Locale(x1) = x;
        getDisplayScript(x1)

    pub def getDisplayScriptWithLocale(inLocale: {inLocale :: Locale}, x: Locale): String =
        import java.util.Locale.getDisplayScript(##java.util.Locale): String & Pure;
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayScript(x1, inLocale1)


    pub def getDisplayVariant(x: Locale): String =
        import java.util.Locale.getDisplayVariant(): String & Pure;
        let Locale(x1) = x;
        getDisplayVariant(x1)

    pub def getDisplayVariantWithLocale(inLocale: {inLocale :: Locale}, x: Locale): String =
        import java.util.Locale.getDisplayVariant(##java.util.Locale): String & Pure;
        let Locale(inLocale1) = inLocale.inLocale;
        let Locale(x1) = x;
        getDisplayVariant(x1, inLocale1)        

    pub def hasExtensions(x: Locale): Bool =
        import java.util.Locale.hasExtensions(): Bool & Pure;
        let Locale(x1) = x;
        hasExtensions(x1)

    pub def stripExtensions(x: Locale): Locale =
        import java.util.Locale.stripExtensions(): ##java.util.Locale & Pure;
        let Locale(x1) = x;
        Locale(stripExtensions(x1))


    pub def toLanguageTag(x: Locale): String =
        import java.util.Locale.toLanguageTag(): String & Pure;
        let Locale(x1) = x;
        toLanguageTag(x1)

    pub def forLanguageTag(tag: String): Locale =
        import static java.util.Locale.forLanguageTag(String): ##java.util.Locale & Pure;
        Locale(forLanguageTag(tag))



    /// This marshals okay...
    pub def getAvailableLocales(): Array[Locale, Static] & Impure =
        import static java.util.Locale.getAvailableLocales(): Array[##java.util.Locale, Static] & Impure;
        let arr = getAvailableLocales();
        Array.map(Locale, arr)


    pub def getIsoCountries(): Array[String, Static] & Impure =
        import static java.util.Locale.getISOCountries(): Array[String, Static] & Impure;
        try {
            getISOCountries()
        } catch {
            case _: ##java.lang.Exception => []
        }

    pub def getIsoCountriesWithIsoCountryCode(icc: IsoCountryCode): Result[Set[String], String] & Impure =
        import static java.util.Locale.getISOCountries(##java.util.Locale$IsoCountryCode): ##java.util.Set & Impure;
        region r1 {
            try {
                let icc1 = marshalIsoCountryCode(icc);
                let s1 = getISOCountries(icc1);
                let ans = Interop/Util/RawSet.new(r1, s1) |> Interop/Util/RawSet.toSet;
                Ok(ans)
            } catch {
                case _: ##java.lang.Exception => Err("getIsoCountriesWithIsoCountryCode")
            }
        }

    pub def getIsoLanguages(): Result[List[String], String] & Impure =
        import static java.util.Locale.getISOLanguages(): Array[String, Static] & Impure;
        try {
            let arr = getISOLanguages();
            Ok(Array.toList(arr))
        } catch {
            case _: ##java.lang.Exception => Err("getIsoLanguages")
        }

    pub def getExtension(key: Char, x: Locale): Option[String] =
        import java.util.Locale.getExtension(Char): String & Pure;
        try {
            let Locale(x1) = x;
            let ext = getExtension(x1, key);
            if (Object.isNull(ext))
                None
            else
                Some(ext)
        } catch {
            case _: ##java.lang.Exception => None
        }

    pub def getExtensionKeys(x: Locale): Set[Char] & Impure =
        import java.util.Locale.getExtensionKeys(): ##java.util.Set & Impure;
        region r1 {
            try {
                let Locale(x1) = x;
                let s1 = getExtensionKeys(x1);
                Interop/Util/RawSet.new(r1, s1) |> Interop/Util/RawSet.toSet
            } catch {
                case _: ##java.lang.Exception => Set.empty()
            }
        }


    pub def getUnicodeLocaleAttributes(x: Locale): Result[Set[String], String] & Impure =
        import java.util.Locale.getUnicodeLocaleAttributes(): ##java.util.Set & Impure;
        region r1 {
            try {
                let Locale(x1) = x;
                let s1 = getUnicodeLocaleAttributes(x1);
                let ans = Interop/Util/RawSet.new(r1, s1) |> Interop/Util/RawSet.toSet;
                Ok(ans)
            } catch {
                case _: ##java.lang.Exception => Err("getUnicodeLocaleAttributes")
            }
        }

    pub def getUnicodeLocaleKeys(x: Locale): Result[Set[String], String] & Impure =
        import java.util.Locale.getUnicodeLocaleKeys(): ##java.util.Set & Impure;
        region r1 {
            try {
                let Locale(x1) = x;
                let s1 = getUnicodeLocaleKeys(x1);
                let ans = Interop/Util/RawSet.new(r1, s1) |> Interop/Util/RawSet.toSet;
                Ok(ans)
            } catch {
                case _: ##java.lang.Exception => Err("getUnicodeLocaleKeys")
            }
        }

    pub def lookup(priorityList: List[LanguageRange], locales: List[Locale]): Option[Locale] = 
        import static java.util.Locale.lookup(##java.util.List, ##java.util.Collection): ##java.util.Locale & Pure;
        region r1 {
            try {
                let ls = Interop/Util/RawList.fromListViaArrayList(r1, priorityList) |> Interop/Util/RawList.getRawList;
                let col = Interop/Util/Collection.fromList(r1, locales) |> Interop/Util/Collection.getCollection;
                let ans = lookup(ls, col);
                if (Object.isNull(ans))
                    None
                else 
                    Some(Locale(ans))
            } catch {
                case _: ##java.lang.Exception => None
            }
        }
    pub def lookupTag(priorityList: List[LanguageRange], tags: List[String]): Option[String] = 
        import static java.util.Locale.lookupTag(##java.util.List, ##java.util.Collection): String & Pure;
        region r1 {
            try {
                let ls = Interop/Util/RawList.fromListViaArrayList(r1, priorityList) |> Interop/Util/RawList.getRawList;
                let col = Interop/Util/Collection.fromList(r1, tags) |> Interop/Util/Collection.getCollection;
                let ans = lookupTag(ls, col);
                if (Object.isNull(ans))
                    None
                else 
                    Some(ans)
            } catch {
                case _: ##java.lang.Exception => None
            }
        }

    pub def filter(priorityList: List[LanguageRange], locales: List[Locale]): List[Locale] = 
        import static java.util.Locale.filter(##java.util.List, ##java.util.Collection): ##java.util.List & Pure;
        region r1 {
            try {
                let ls = Interop/Util/RawList.fromListViaArrayList(r1, priorityList) |> Interop/Util/RawList.getRawList;
                let col = Interop/Util/Collection.fromList(r1, locales) |> Interop/Util/Collection.getCollection;
                let ans = filter(ls, col);
                if (Object.isNull(ans))
                    Nil
                else 
                    Interop/Util/RawList.new(r1, ans) |> Interop/Util/RawList.toList
            } catch {
                case _: ##java.lang.Exception => Nil
            }
        }

    pub def filterWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, locales: List[Locale]): List[Locale] = 
        import static java.util.Locale.filter(##java.util.List, ##java.util.Collection, ##java.util.Locale$FilteringMode): ##java.util.List & Pure;
        region r1 {
            try {
                let ls = Interop/Util/RawList.fromListViaArrayList(r1, priorityList) |> Interop/Util/RawList.getRawList;
                let col = Interop/Util/Collection.fromList(r1, locales) |> Interop/Util/Collection.getCollection;
                let mode1 = marshalFilteringMode(mode);
                let ans = filter(ls, col, mode1);
                if (Object.isNull(ans))
                    Nil
                else 
                    Interop/Util/RawList.new(r1, ans) |> Interop/Util/RawList.toList
            } catch {
                case _: ##java.lang.Exception => Nil
            }
        }

    pub def filterTags(priorityList: List[LanguageRange], tags: List[String]): List[String] = 
        import static java.util.Locale.filterTags(##java.util.List, ##java.util.Collection): ##java.util.List & Pure;
        region r1 {
            try {
                let ls = Interop/Util/RawList.fromListViaArrayList(r1, priorityList) |> Interop/Util/RawList.getRawList;
                let col = Interop/Util/Collection.fromList(r1, tags) |> Interop/Util/Collection.getCollection;
                let prim = filterTags(ls, col);
                if (Object.isNull(prim))
                    Nil
                else 
                    Interop/Util/RawList.new(r1, prim) |> Interop/Util/RawList.toList
            } catch {
                case _: ##java.lang.Exception => Nil
            }
        }

    pub def filterTagsWithFilteringMode(priorityList: List[LanguageRange], mode: FilteringMode, tags: List[String]): List[String] = 
        import static java.util.Locale.filterTags(##java.util.List, ##java.util.Collection, ##java.util.Locale$FilteringMode): ##java.util.List & Pure;
        region r1 {
            try {
                let ls = Interop/Util/RawList.fromListViaArrayList(r1, priorityList) |> Interop/Util/RawList.getRawList;
                let col = Interop/Util/Collection.fromList(r1, tags) |> Interop/Util/Collection.getCollection;
                let mode1 = marshalFilteringMode(mode);
                let ans = filterTags(ls, col, mode1);
                if (Object.isNull(ans))
                    Nil
                else 
                    Interop/Util/RawList.new(r1, ans) |> Interop/Util/RawList.toList
            } catch {
                case _: ##java.lang.Exception => Nil
            }
        }
}
