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

    use Interop/Util.Collection;
    use Interop/Util.Collection.{Collection};

    ///
    /// Represents a ArrayList.
    ///
    pub enum ArrayList[_: Type, _: Region](##java.util.ArrayList)

    instance Interop/Util.ImpCollection[ArrayList] {
        pub def toCollection(t: ArrayList[a, r]): Collection[a, r] = 
            let ArrayList(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): ArrayList[a, r] = 
            let Collection(t1) = t;
            ArrayList(t1 as ##java.util.ArrayList) 
    }


}

namespace Interop/Util/ArrayList {

    use Interop/Util.ArrayList;
    use Interop/Util.ArrayList.{ArrayList};
    use Interop/Flix.Marshal;

    
    pub def getHH(arr: ArrayList[a, r]): ##java.util.ArrayList = 
        let ArrayList(arr1) = arr;
        arr1
        
    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(_: Region[r], prim: ##java.util.ArrayList): ArrayList[a, r] = ArrayList(prim)

    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def empty(_: Region[r]): ArrayList[a, r] \ Write(r) =
        import new java.util.ArrayList(): ##java.util.ArrayList & r as newArrayList;
        ArrayList(newArrayList())



    pub def length(arr: ArrayList[a, r]): Int32 \ Read(r) = 
        import java.util.ArrayList.size(): Int32 & r;
        let ArrayList(arr1) = arr;
        size(arr1)


    pub def get(ix: Int32, arr: ArrayList[a, r]): a \ Read(r) with Marshal[a] = 
        import java.util.ArrayList.get(Int32): ##java.lang.Object & r;
        let ArrayList(arr1) = arr;
        get(arr1, ix) |> Interop/Flix/Marshal.fromJavaObject

    pub def add!(x: a, arr: ArrayList[a, r]): Bool \ { Write(r) } with Marshal[a] = 
        import java.util.ArrayList.add(##java.lang.Object): Bool & r;
        let ArrayList(arr1) = arr;
        add(arr1, Interop/Flix/Marshal.toJavaObject(x))

    ///
    /// Apply the effectful function `f` to all the elements in the array `a`.
    ///
    pub def foreach(f: a -> Unit & ef, arr: ArrayList[a, r]): Unit \ { ef, Read(r) } with Marshal[a] =
        let len = length(arr);
        def loop(i) = {
            if (i >= len)
                ()
            else {
                let x = get(i, arr);
                f(x);
                loop(i + 1)
            }
        };
        loop(0)


    ///
    /// Returns an iterator over `arr`.
    ///
    pub def iterator(r1: Region[r1], arr: ArrayList[a, r2]): Iterator[a, r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        iteratorWith(r1, Interop/Flix/Marshal.fromJavaObject, arr)

    ///
    /// Returns an iterator over `arr`.
    ///
    pub def iteratorWith(r1: Region[r1], 
                            ocast: ##java.lang.Object -> a, 
                            arr: ArrayList[a, r2]): Iterator[a, r1] \ { Read(r2), Write(r1) } =
        import java.util.ArrayList.iterator(): ##java.util.Iterator & (r2 and r1) as iterator1;
        let ArrayList(arr1) = arr;
        Interop/Util/IteratorZ.new(r1, iterator1(arr1)) |> Interop/Util/IteratorZ.iteratorWith(ocast)



    ///
    /// Returns an iterator over `arr`.
    ///
    pub def enumerator(r1: Region[r1], arr: ArrayList[a, r2]): Iterator[(a, Int32), r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        iterator(r1, arr) |> Iterator.enumerator


    pub def unfoldArrayList(_: Region[r], f: s -> Option[(a, s)] & ef, st: s): ArrayList[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.ArrayList(): ##java.util.ArrayList & r as new1;
        import java.util.ArrayList.add(##java.lang.Object): Bool & r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => ArrayList(acc)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())

    pub def foldArrayList(f: (b, a) -> b & ef, s: b, arr: ArrayList[a, r]): b \ { Read(r), ef } with Marshal[a] =
        region r1 {
            let iter = iterator(r1, arr);
            Iterator.foldLeft(f, s, iter)
        }

    pub def toList(arr: ArrayList[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        let step = (k, a) -> ks -> k(a :: ks);
        foldArrayList(step, ks -> ks, arr) |> f -> f(Nil)

    pub def toSet(arr: ArrayList[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        let step = (acc, a) -> Set.insert(a, acc);
        foldArrayList(step, Set.empty(), arr)


    pub def toArray(r1: Region[r1], arr: ArrayList[a, r2]): Array[a, r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        let len = length(arr);
        if (len < 1) 
            [] @ r1
        else {
            let head = get(0, arr);
            let aout = Array.new(r1, head, len);
            let step = (ix, a) -> {aout[ix] = a; ix+1};
            discard foldArrayList(step, 0, arr);
            aout
        }

    pub def fromList(r: Region[r], l: List[a]): ArrayList[a, r] \ { Write(r) } with Marshal[a] =
        let step = xs -> match xs {
            case Nil     => None
            case x :: rs => Some((x, rs))
        };
        unfoldArrayList(r, step, l)

    /// asc order?
    pub def fromSet(r: Region[r], s: Set[a]): ArrayList[a, r] \ { Write(r) } with Marshal[a] =
        let arr = empty(r);
        Set.foreach(x -> discard add!(x, arr), s);
        arr

    pub def fromArray(r: Region[r1], s: Array[a, r2]): ArrayList[a, r1] \ { Read(r2), Write(r1) } with Marshal[a] =
        let arr = empty(r);
        Array.foreach(x -> discard add!(x, arr), s);
        arr

}
