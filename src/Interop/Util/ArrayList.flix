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
    use Interop/Util.ListZ;
    use Interop/Util.ListZ.{ListZ};

    ///
    /// Represents a ArrayList.
    /// Class / Mutable
    ///
    pub enum ArrayList[_: Type, _: Region](##java.util.ArrayList)

    instance Scoped[ArrayList[a]] {
        pub def regionOf(_: ArrayList[a, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpCollection[ArrayList] {
        pub def toCollection(t: ArrayList[a, r]): Collection[a, r] = 
            let ArrayList(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): ArrayList[a, r] = 
            let Collection(t1) = t;
            ArrayList(t1 as ##java.util.ArrayList) 
    }


    instance Interop/Util.ImpListZ[ArrayList] {
        pub def toListZ(t: ArrayList[a, r]): ListZ[a, r] = 
            let ArrayList(t1) = t;
            ListZ(t1 as ##java.util.List)

        pub def fromListZ(t: ListZ[a, r]): ArrayList[a, r] = 
            let ListZ(t1) = t;
            ArrayList(t1 as ##java.util.ArrayList) 
    }

}

namespace Interop/Util/ArrayList {

    use Interop/Util.ArrayList;
    use Interop/Util.ArrayList.{ArrayList};
    use Interop/Util.ImpCollection;
    use Interop/Flix.Marshal;

    
    pub def getHH(arr: ArrayList[a, r]): ##java.util.ArrayList = 
        let ArrayList(arr1) = arr;
        arr1

    pub def wrapHH(_: Region[r], prim: ##java.util.ArrayList): ArrayList[a, r] \ Write(r) =
        ArrayList(prim) as \ Write(r)




    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(_: Region[r]): ArrayList[a, r] \ Write(r) =
        import new java.util.ArrayList(): ##java.util.ArrayList & r as newArrayList;
        ArrayList(newArrayList())


    pub def fromIterable[a: Type, t: Type -> Region -> Type, r: Region, r2: Region]
                        (r: Region[r2], t: t[a, r]): ArrayList[a, r2] \ { Read(r), Write(r2) } with Iterable[t], Marshal[a] =
        let als = new(r);
        let iter1 = Iterable.iterator(t);
        Iterator.foreach(x -> discard add!(x, als), iter1);
        als

    pub def fromFoldable(r: Region[r], t: t[a]): ArrayList[a, r] \ { Write(r) } with Foldable[t], Marshal[a] =
        let als = new(r);
        Foldable.foreach(x -> discard add!(x, als), t);
        als

    pub def fromFoldableWith(r: Region[r], ocast: a -> ##java.lang.Object, t: t[a]): ArrayList[a, r] \ { Write(r) } with Foldable[t] =
        let als = new(r);
        Foldable.foreach(x -> discard addWith!(x, ocast, als), t);
        als


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

    pub def addWith!(x: a, ocast: a -> ##java.lang.Object, arr: ArrayList[a, r]): Bool \ { Write(r) } = 
        import java.util.ArrayList.add(##java.lang.Object): Bool & r;
        let ArrayList(arr1) = arr;
        add(arr1, ocast(x))

    pub def addAll![t: Type -> Region -> Type, r: Region, a: Type](col: t[a, r], 
                                                                    arr: ArrayList[a, r]): Result[Bool, String] \ { Write(r) } with ImpCollection[t] = 
        try { 
            import java.util.ArrayList.addAll(##java.util.Collection): Bool & r;
            let ArrayList(arr1) = arr;
            let col1 = Interop/Util/Collection.toCollectionHH(col);
            addAll(arr1, col1) |> Ok 
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }
        


    ///
    /// Returns an iterator over `arr`.
    ///
    pub def iterator(arr: ArrayList[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        toFlixIterator(Scoped.regionOf(arr), Interop/Flix/Marshal.fromJavaObject, arr)

    ///
    /// Returns an iterator over `arr`.
    ///
    pub def toFlixIterator(r2: Region[r2], 
                            ocast: ##java.lang.Object -> a, 
                            arr: ArrayList[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } =
        import java.util.ArrayList.iterator(): ##java.util.Iterator \ {r, r2} as iterator;
        let ArrayList(arr1) = arr;
        if (Object.isNull(arr1))
            Iterator.new(r2)
        else 
            iterator(arr1) 
                |> Interop/Util/IteratorZ.wrapHH(r2) 
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)



    ///
    /// Returns an iterator over `arr`.
    ///
    pub def enumerator(arr: ArrayList[a, r]): Iterator[(a, Int32), r] \ { Write(r) } with Marshal[a] =
        iterator(arr) |> Iterator.enumerator


    pub def unfoldArrayList(_: Region[r], f: s -> Option[(a, s)] & ef, st: s): ArrayList[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.ArrayList(): ##java.util.ArrayList & r as new1;
        import java.util.ArrayList.add(##java.lang.Object): Bool & r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => ArrayList(acc)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())

    pub def foldArrayList(f: (b, a) -> b & ef, s: b, arr: ArrayList[a, r]): b \ { Read(r), ef } with Marshal[a] =
        iterator(arr) |> Iterator.foldLeft(f, s)

    pub def toFlixList(arr: ArrayList[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        iterator(arr) |> Iterator.toList

    pub def toFlixSet(arr: ArrayList[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        let step = (acc, a) -> Set.insert(a, acc);
        iterator(arr) |> Iterator.foldLeft(step, Set.empty())


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


}
