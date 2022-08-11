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
    pub enum IteratorZ[_a: Type, _r: Region](##java.util.Iterator)


}

namespace Interop/Util/IteratorZ {

    use Interop/Util.IteratorZ;
    use Interop/Util.IteratorZ.{IteratorZ};
    use Interop/Flix.Marshal;


    pub def getHH(iter: IteratorZ[a, r]): ##java.util.Iterator = 
        let IteratorZ(iter1) = iter;
        iter1

    /// Cast must be Pure!
    pub def hhToIterator(_: Region[r], ocast: ##java.lang.Object -> a, iter: ##java.util.Iterator): Iterator[a, r] \ { Read(r), Write(r) }   =
        import java.util.Iterator.hasNext(): Bool \ Read(r);
        import java.util.Iterator.next(): ##java.lang.Object \ { Write(r) };
        let isDone = () -> { 
            let ans = hasNext(iter);
            not ans
        };
        let getNext = () -> {
            let a1 = next(iter);
            ocast(a1)
        };
        Iterator(isDone, getNext) as \ { Read(r), Write(r) }



    pub def new(_: Region[r], iter: ##java.util.Iterator): IteratorZ[a, r] \ Write(r) = 
        IteratorZ(iter) as \ Write(r)

    /// Mutable (raw) to mutable (Filx iterator) so Read/Write
    pub def iterator(iter: IteratorZ[a, r]): Iterator[a, r] \ { Read(r), Write(r) } with Marshal[a]  =
        iteratorWith(Interop/Flix/Marshal.fromJavaObject, iter)
        

    /// iteratorWith ???
    pub def iteratorWith(ocast: ##java.lang.Object -> a, iter: IteratorZ[a, r]): Iterator[a, r] \ { Read(r), Write(r) }   =
        import java.util.Iterator.hasNext(): Bool \ Read(r);
        import java.util.Iterator.next(): ##java.lang.Object \ { Write(r) };
        let IteratorZ(iter1) = iter;
        let isDone = () -> { 
            let ans = hasNext(iter1);
            not ans
        };
        let getNext = () -> {
            let a1 = next(iter1);
            ocast(a1)
        };
        Iterator(isDone, getNext) as \ { Read(r), Write(r) }

    pub def enumerator(iter: IteratorZ[a, r]): Iterator[(a, Int32), r] \ Write(r) with Marshal[a] =
        iterator(iter) |> Iterator.enumerator

    ///
    /// Apply the effectful function `f` to all the elements in the array `a`.
    ///
    pub def foreach(f: a -> Unit & ef, iter: IteratorZ[a, r]): Unit \ { ef, Read(r) } with Marshal[a] =
        iterator(iter) |> Iterator.foreach(f)

    pub def toList(iter: IteratorZ[a, r]): List[a] \ Read(r) with Marshal[a] = 
        iterator(iter) |> Iterator.toList

    pub def toNel(iter: IteratorZ[a, r]): Option[Nel[a]] \ Read(r) with Marshal[a] =
        iterator(iter) |> Iterator.toNel


    pub def toMapWith(f: a -> (k, v) & ef, iter: IteratorZ[a, r]): Map[k, v] \ { Read(r), ef } with Order[k], Marshal[a] =
        iterator(iter) |> Iterator.foldLeft((acc, a) -> let (k,v) = f(a); Map.insert(k, v, acc), Map.empty())

}