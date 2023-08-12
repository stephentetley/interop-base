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

mod Interop.Util {

    ///
    /// Represents a Java Iterator.
    ///
    pub enum IteratorZ[_a: Type, _ef: Eff, r: Region] {
        case IteratorZ(Region[r], ##java.util.Iterator)
    }


}

mod Interop.Util.IteratorZ {

    use Interop.Util.IteratorZ
    use Interop.Util.IteratorZ.{IteratorZ}
    use Interop.Util.Function.ConsumerZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Flix.ComesFromJava


    pub def getHH(iter: IteratorZ[a, ef, r]): ##java.util.Iterator = 
        let IteratorZ(_, iter1) = iter;
        iter1

    pub def wrapHH(rc: Region[r], iter: ##java.util.Iterator): IteratorZ[a, ef, r] = 
        IteratorZ(rc, iter)

    /// Cast must be Pure!
    pub def toFlixIterator(rc: Region[r1], getter: ##java.lang.Object -> b \ ef1, iter: IteratorZ[a, ef, r]): Iterator[b, ef + ef1 + r + r1, r1] =
        import java.util.Iterator.hasNext(): Bool \ r;
        import java.util.Iterator.next(): ##java.lang.Object \ {ef, r};
        let IteratorZ(_, iter1) = iter;
        let step = () -> { 
            match hasNext(iter1) {
                case true  => next(iter1) |> getter |> Some
                case false => None
            }
        };
        let iterF = () -> checked_ecast(step());
        Iterator.iterate(rc, iterF)

    pub def primIteratorToFlixIterator(rc: Region[r], 
                                        ocast: ##java.lang.Object -> a, 
                                        prim: ##java.util.Iterator): Iterator[a, r, r] =
        wrapHH(rc, prim) |> toFlixIterator(rc, ocast)



    ///
    /// Apply the effectful function `f` to all the elements in the array `a`.
    ///
    pub def forEachRemaining(f: ConsumerZ[a, ef1], iter: IteratorZ[a, ef, r]): Result[String, Unit] \ {ef, ef1, r} = 
        Result.tryCatch(_ -> {
            import java.util.Iterator.forEachRemaining(##java.util.function.Consumer): Unit \ {ef, ef1, r};
            let IteratorZ(_, iter1) = iter;
            let ConsumerZ(f1) = f;
            forEachRemaining(iter1, f1)
        })

    pub def toList(getter: ##java.lang.Object -> b \ ef1, iter: IteratorZ[a, ef, r]): List[b] \ {ef, ef1, r} = region r {
        toFlixIterator(r, getter, iter) |> Iterator.toList
    }

    pub def toNel(getter: ##java.lang.Object -> b \ ef1, iter: IteratorZ[a, ef, r]): Option[Nel[b]] \ {ef, ef1, r} = region r {
        toFlixIterator(r, getter, iter) |> Iterator.toNel
    }

    pub def toMapWith(getter: ##java.lang.Object -> b \ ef1, f: b -> (k, v) \ ef2, iter: IteratorZ[a, ef, r]): Map[k, v] \ {ef, ef1, ef2, r} with Order[k] = region r {
        toFlixIterator(r, getter, iter) |> Iterator.foldLeft((acc, a) -> let (k,v) = f(a); Map.insert(k, v, acc), Map.empty())
    }

}
