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

namespace Interop/Util {

    ///
    /// Represents a Java Iterator.
    ///
    /// TODO should probably include an effect param
    ///
    pub enum IteratorZ[_a: Type, r: Region] {
        case IteratorZ(Region[r], ##java.util.Iterator)
    }


}

namespace Interop/Util/IteratorZ {

    use Interop/Util.IteratorZ;
    use Interop/Util.IteratorZ.{IteratorZ};
    use Interop/Flix.Marshal;


    pub def getHH(iter: IteratorZ[a, r]): ##java.util.Iterator = 
        let IteratorZ(_, iter1) = iter;
        iter1

    pub def wrapHH(rc: Region[r], iter: ##java.util.Iterator): IteratorZ[a, r] = 
        IteratorZ(rc, iter)

    /// Mutable (raw) to mutable (Flix iterator) so Read/Write
    pub def iterator(rc: Region[r1], iter: IteratorZ[a, r]): Iterator[a, r, r1] with Marshal[a]  =
        toFlixIterator(rc, Interop/Flix/Marshal.fromJavaObject, iter)
        

    /// Cast must be Pure!
    pub def toFlixIterator(rc: Region[r1], ocast: ##java.lang.Object -> a, iter: IteratorZ[a, r]): Iterator[a, r, r1] =
        import java.util.Iterator.hasNext(): Bool \ Read(r);
        import java.util.Iterator.next(): ##java.lang.Object \ { Write(r) }; // "destructive read" == write
        let IteratorZ(_, iter1) = iter;
        let step = () -> { 
            match hasNext(iter1) {
                case true  => next(iter1) |> ocast |> Some
                case false => None
            }
        };
        Iterator.iterate(rc, step)


    pub def enumerator(rc: Region[r1], iter: IteratorZ[a, r]): Iterator[(Int32, a), r and r1, r1] \ Write(r1) with Marshal[a] =
        iterator(rc, iter) |> Iterator.enumerator

    ///
    /// Apply the effectful function `f` to all the elements in the array `a`.
    ///
    pub def forEach(f: a -> Unit & ef, iter: IteratorZ[a, r]): Unit \ { ef, Read(r) } with Marshal[a] = region r {
        iterator(r, iter) |> Iterator.forEach(f)
    }

    pub def toList(iter: IteratorZ[a, r]): List[a] \ Read(r) with Marshal[a] = region r {
        iterator(r, iter) |> Iterator.toList
    }

    pub def toNel(iter: IteratorZ[a, r]): Option[Nel[a]] \ Read(r) with Marshal[a] = region r {
        iterator(r, iter) |> Iterator.toNel
    }

    pub def toMapWith(f: a -> (k, v) \ ef, iter: IteratorZ[a, r]): Map[k, v] \ { Read(r), ef } with Order[k], Marshal[a] = region r {
        iterator(r, iter) |> Iterator.foldLeft((acc, a) -> let (k,v) = f(a); Map.insert(k, v, acc), Map.empty())
    }

}
