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

namespace Interop/Text {
    
    ///
    /// Represents a Collator.
    /// Mutable
    ///
    pub enum Collator[_: Region](##java.text.Collator)

    instance Scoped[Collator] {
        pub def regionOf(_: Collator[r]): Region[r] = unsafe_cast () as Region[r]
    }
}

namespace Interop/Text/Collator {

    use Interop/Text.Collator;
    use Interop/Text.Collator.{Collator};
    use Interop/Util.Locale;
    use Interop/Util.Locale.{Locale};

    pub def getHH(c: Collator[r]): ##java.text.Collator = 
        let Collator(c1) = c;
        c1


    pub def wrapHH(_: Region[r], prim: ##java.text.Collator): Collator[r] = 
        Collator(prim)


    pub def no_decomposition(): Int32 = 
        import static get java.text.Collator.NO_DECOMPOSITION: Int32 \ {} as get_NO_DECOMPOSITION;
        get_NO_DECOMPOSITION()

    pub def canonical_decomposition(): Int32 = 
        import static get java.text.Collator.CANONICAL_DECOMPOSITION: Int32 \ {} as get_CANONICAL_DECOMPOSITION;
        get_CANONICAL_DECOMPOSITION()

    pub def full_decomposition(): Int32 = 
        import static get java.text.Collator.FULL_DECOMPOSITION: Int32 \ {} as get_FULL_DECOMPOSITION;
        get_FULL_DECOMPOSITION()



    pub def identical(): Int32 = 
        import static get java.text.Collator.IDENTICAL: Int32 \ {} as get_IDENTICAL;
        get_IDENTICAL()

    pub def primary(): Int32 = 
        import static get java.text.Collator.PRIMARY: Int32 \ {} as get_PRIMARY;
        get_PRIMARY()

    pub def secondary(): Int32 = 
        import static get java.text.Collator.SECONDARY: Int32 \ {} as get_SECONDARY;
        get_SECONDARY()

    pub def tertiary(): Int32 =         
        import static get java.text.Collator.TERTIARY: Int32 \ {} as get_TERTIARY;
        get_TERTIARY()

    ///
    /// Uses a Collator to be accurate with the locale of the JVM.
    ///
    pub def getInstance(_: Region[r]): Collator[r] \ {Write(r), IO} =
        import static java.text.Collator.getInstance(): ##java.text.Collator \ {r, IO};
        getInstance() |> Collator


    pub def getInstanceWithLocale(_: Region[r], loc: Locale): Collator[r] \ Write(r) =
        import static java.text.Collator.getInstance(##java.util.Locale): ##java.text.Collator \ r;
        let Locale(loc1) = loc;
        getInstance(loc1) |> Collator

    /// TODO - instance with decomposition and strength?


    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(s1: String, s2: String, col: Collator[r]): Bool \ Read(r) =
        import java.text.Collator.equals(String, String): Bool & r;
        let Collator(col1) = col;
        equals(col1, s1, s2)

    ///
    /// Compare strings `s1` and `s2` with the collator `x``.
    ///
    pub def compare(s1: String, s2: String, col: Collator[r]): Comparison \ Read(r) =
        import java.text.Collator.compare(String, String): Int32 & r;
        let Collator(col1) = col;
        compare(col1, s1, s2) |> Comparison.fromInt32





    /// /// TODO - test cloning the Java objects and then get a pure API...

    pub def clone(x: Collator[r]): Collator[r] \ Write(r) =
        import java.text.Collator.clone(): ##java.lang.Object \ r;
        let Collator(x1) = x;
        (unsafe_cast clone(x1) as ##java.text.Collator) |> Collator

    pub def getDecomposition(col: Collator[r]): Int32 \ Read(r) =
        import java.text.Collator.getDecomposition(): Int32 & r;
        let Collator(col1) = col;
        getDecomposition(col1)

    pub def setDecomposition!(mode: Int32, col: Collator[r]): Unit \ Write(r) =
        import java.text.Collator.setDecomposition(Int32): Unit & r;
        let Collator(col1) = col;
        setDecomposition(col1, mode)

    pub def getStrength(col: Collator[r]): Int32 \ Read(r) =
        import java.text.Collator.getStrength(): Int32 & r;
        let Collator(col1) = col;
        getStrength(col1)

    pub def setStrength!(strength: Int32, col: Collator[r]): Unit \ Write(r) =
        import java.text.Collator.setStrength(Int32): Unit & r;
        let Collator(col1) = col;
        setStrength(col1, strength)
        

}
