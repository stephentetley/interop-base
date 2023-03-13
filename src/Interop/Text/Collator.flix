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
    /// Class / Represents a Collator.
    /// "Immutable with Setter"
    ///
    pub enum Collator(##java.text.Collator)

    pub class SubCollator[t: Type] {
        pub def toCollator(o: t): Collator
        pub def fromCollator(c: Collator): t
    }


}

namespace Interop/Text/Collator {

    use Interop/Text.Collator
    use Interop/Text.Collator.{Collator}    
    use Interop/Util.Locale
    use Interop/Util.Locale.{Locale}
    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def getHH(c: Collator): ##java.text.Collator = 
        let Collator(c1) = c;
        c1


    pub def wrapHH(prim: ##java.text.Collator): Collator = 
        Collator(prim)


    pub enum CollatorProperty {
        case Decomposition(Int32)
        case Strength(Int32)
    }
    

    pub def makeSetter(rc: Region[r], xs: List[CollatorProperty]): Setter[Collator, r] = 
        def f(x) = match x {
            case Decomposition(x1) => setDecomposition!(rc, x1)
            case Strength(x1)      => setStrength!(rc, x1)
        };
        Interop/Flix/Setter.makeSetter(rc, f, xs)


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
    /// Get a Collator with the locale of the JVM.
    /// Apply the setters in `fs` to further configure the Collator.
    ///
    pub def getInstance(props: List[CollatorProperty]): Result[String, Collator] \ IO = region rc {
        import static java.text.Collator.getInstance(): ##java.text.Collator \ IO;
        Collator(getInstance()) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    pub def getInstanceWithLocale(loc: Locale, props: List[CollatorProperty]): Result[String, Collator] = region rc {
        import static java.text.Collator.getInstance(##java.util.Locale): ##java.text.Collator \ {};
        let Locale(loc1) = loc;
        Collator(getInstance(loc1)) |> Interop/Flix/Setter.apply(rc, makeSetter(rc, props))
    }

    /// TODO - instance with decomposition and strength?


    ///
    /// Test equality of strings `s1` and `s2` with the collator `x``.
    ///
    pub def equals(s1: String, s2: String, c: Collator): Bool =
        import java.text.Collator.equals(String, String): Bool \ {};
        let Collator(c1) = c;
        equals(c1, s1, s2)

    ///
    /// Compare strings `s1` and `s2` with the collator `x``.
    ///
    pub def compare(s1: String, s2: String, c: Collator): Comparison =
        import java.text.Collator.compare(String, String): Int32 \ {};
        let Collator(c1) = c;
        compare(c1, s1, s2) |> Comparison.fromInt32


    /// Maybe `clone` not so useful...

    pub def clone(c: Collator): Collator =
        import java.text.Collator.clone(): ##java.lang.Object \ {};
        let Collator(c1) = c;
        Collator(unchecked_cast(clone(c1) as ##java.text.Collator))

    pub def getDecomposition(c: Collator): Int32 =
        import java.text.Collator.getDecomposition(): Int32 \ {};
        let Collator(c1) = c;
        getDecomposition(c1)


    pub def getStrength(c: Collator): Int32 =
        import java.text.Collator.getStrength(): Int32 \ {};
        let Collator(c1) = c;
        getStrength(c1)


    pub def setDecomposition!(_: Region[r], mode: Int32): Setter[Collator, r] =
        Interop/Flix/Setter.lift(c -> 
            import java.text.Collator.setDecomposition(Int32): Unit \ Write(r);
            let Collator(c1) = c;
            setDecomposition(c1, mode)
        )

    pub def setStrength!(_: Region[r], strength: Int32): Setter[Collator, r] =
        Interop/Flix/Setter.lift(c -> 
            import java.text.Collator.setStrength(Int32): Unit \ Write(r);
            let Collator(c1) = c;
            setStrength(c1, strength)
        )

}
