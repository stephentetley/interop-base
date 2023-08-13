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

mod Interop.Lang {

    ///
    /// Represents a Java Iterable.
    ///
    /// Interface
    ///
    pub enum IterableZ[_a: Type, r: Region] {
        case IterableZ(Region[r], ##java.lang.Iterable)
    }

    pub class ImpIterable[t: Type -> Region -> Type] {
        pub def toIterable(s: t[a, r]): IterableZ[a, r]
        pub def fromIterable(s: IterableZ[a, r]): t[a, r]

        pub def toIterableHH(s: t[a, r]): ##java.lang.Iterable = 
           ImpIterable.toIterable(s) |> Interop.Lang.IterableZ.getHH
    }

}

mod Interop.Lang.IterableZ {

    use Interop.Lang.IterableZ
    use Interop.Lang.IterableZ.{IterableZ}
    use Interop.Util.Function.ConsumerZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.IteratorZ
    use Interop.Util.IteratorZ.{IteratorZ}

    pub def getHH(iter: IterableZ[a, r]): ##java.lang.Iterable = 
        let IterableZ(_, iter1) = iter;
        iter1

    pub def wrapHH(rc: Region[r], iter: ##java.lang.Iterable): IterableZ[a, r] = 
        IterableZ(rc, iter)


    pub def iterator(iter: IterableZ[a, r]): IteratorZ[a, r, r] \ r =
        import java.lang.Iterable.iterator(): ##java.util.Iterator \ r ;
        let IterableZ(rc, iter1) = iter;
        IteratorZ(rc, iterator(iter1))


    // Iterable to mutable (Flix iterator) 
    pub def toFlixIterator(getter: ##java.lang.Object -> b \ ef, iter: IterableZ[a, r]): Iterator[b, ef + r, r] \ r =
        let IterableZ(rc, _) = iter;
        let iter1 = iterator(iter);
        Interop.Util.IteratorZ.toFlixIterator(rc, getter, iter1)


    pub def forEach(f: ConsumerZ[a, ef], l: IterableZ[a, r]): Result[String, Unit] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.lang.Iterable.forEach(##java.util.function.Consumer): Unit \ {ef, r}; 
            let IterableZ(_, l1) = l;
            let ConsumerZ(f1) = f;
            forEach(l1, f1)
        })

}
