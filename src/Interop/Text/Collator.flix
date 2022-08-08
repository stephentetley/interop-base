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
    
}

namespace Interop/Text/Collator {

    use Interop/Text.Collator;
    use Interop/Text.Collator.{Collator};

    // Note - Java's Collator dates from 1.1 and predates enums (1.5), I think the use of 
    // enums here is safe.

    pub enum DecompositionMode with Eq, Order, ToString, Hash, Boxable {
        case NoDecomposition
        case CanonicalDecomposition
        case FullDecomposition
    }

    pub enum CollatorStrength with Eq, Order, ToString, Hash, Boxable {
        case Identical
        case Primary
        case Secondary
        case Tertiary
    }


    def marshallDecompositionMode(x: DecompositionMode): Int32 =
        import static get java.text.Collator.NO_DECOMPOSITION: Int32 & Pure as get_NO_DECOMPOSITION;
        import static get java.text.Collator.CANONICAL_DECOMPOSITION: Int32 & Pure as get_CANONICAL_DECOMPOSITION;
        import static get java.text.Collator.FULL_DECOMPOSITION: Int32 & Pure as get_FULL_DECOMPOSITION;
        match x {
            case NoDecomposition        => get_NO_DECOMPOSITION()
            case CanonicalDecomposition => get_CANONICAL_DECOMPOSITION()
            case FullDecomposition      => get_FULL_DECOMPOSITION()
        }

    /// Fallback or bug! ?
    def unmarshallDecompositionMode(i: Int32): DecompositionMode =
        import static get java.text.Collator.CANONICAL_DECOMPOSITION: Int32 & Pure as get_CANONICAL_DECOMPOSITION;
        import static get java.text.Collator.FULL_DECOMPOSITION: Int32 & Pure as get_FULL_DECOMPOSITION;
        match i {
            case n if n == get_CANONICAL_DECOMPOSITION()    => CanonicalDecomposition
            case n if n == get_FULL_DECOMPOSITION()         => FullDecomposition
            case _                                          => NoDecomposition
        }

    def marshallCollatorStrength(x: CollatorStrength): Int32 =
        import static get java.text.Collator.IDENTICAL: Int32 & Pure as get_IDENTICAL;
        import static get java.text.Collator.PRIMARY: Int32 & Pure as get_PRIMARY;
        import static get java.text.Collator.SECONDARY: Int32 & Pure as get_SECONDARY;
        import static get java.text.Collator.TERTIARY: Int32 & Pure as get_TERTIARY;
        match x {
            case Identical => get_IDENTICAL()
            case Primary   => get_PRIMARY()
            case Secondary => get_SECONDARY()
            case Tertiary  => get_TERTIARY()
        }

    /// Warning - I am not sure each enum has a distinct int value in Java land...
    def unmarshallCollatorStrength(i: Int32): CollatorStrength =
        import static get java.text.Collator.IDENTICAL: Int32 & Pure as get_IDENTICAL;
        import static get java.text.Collator.PRIMARY: Int32 & Pure as get_PRIMARY;
        import static get java.text.Collator.SECONDARY: Int32 & Pure as get_SECONDARY;
        import static get java.text.Collator.TERTIARY: Int32 & Pure as get_TERTIARY;
        match i {
            case n if n == get_IDENTICAL()  => Identical
            case n if n == get_PRIMARY()    => Primary
            case n if n == get_SECONDARY()  => Secondary
            case n if n == get_TERTIARY()   => Tertiary
        }

    ///
    /// Uses a Collator to be accurate with the locale of the JVM.
    ///
    pub def getInstance(_: Region[r]): Collator[r] \ {Write(r), IO} =
        import static java.text.Collator.getInstance(): ##java.text.Collator \ {r, IO};
        Collator(getInstance())


    pub def getInstanceWithLocale(loc: Interop/Util.Locale): Collator[r] \ Write(r) =
        import static java.text.Collator.getInstance(##java.util.Locale): ##java.text.Collator & r;
        use Interop/Util.Locale.{Locale};
        let Locale(loc1) = loc;
        Collator(getInstance(loc1))

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



    pub def getDecomposition(col: Collator[r]): DecompositionMode \ Read(r) =
        import java.text.Collator.getDecomposition(): Int32 & r;
        let Collator(col1) = col;
        getDecomposition(col1) |> unmarshallDecompositionMode

    /// /// TODO - test cloning the Java objects and then get a pure API...

    /// def clone(x: Collator): ##java.text.Collator & Impure =
    ///     import java.text.Collator.clone(): ##java.text.Collator & Impure;
    ///     let Collator(x1) = x;
    ///     clone(x1) as ##java.text.Collator

    pub def setDecomposition!(mode: DecompositionMode, col: Collator[r]): Unit \ Write(r) =
        import java.text.Collator.setDecomposition(Int32): Unit & r;
        let Collator(col1) = col;
        let mode1 = marshallDecompositionMode(mode);
        setDecomposition(col1, mode1)

    pub def getStrength(col: Collator[r]): CollatorStrength \ Read(r) =
        import java.text.Collator.getStrength(): Int32 & r;
        let Collator(col1) = col;
        getStrength(col1) |> unmarshallCollatorStrength

    pub def setStrength!(strength: CollatorStrength, col: Collator[r]): Unit \ Write(r) =
        import java.text.Collator.setStrength(Int32): Unit & r;
        let Collator(col1) = col;
        let strength1 = marshallCollatorStrength(strength);
        setStrength(col1, strength1)
        

}
