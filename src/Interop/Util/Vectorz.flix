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

    use Interop.Util.VectorZ.{VectorZ}
    use Interop.Lang.IterableZ
    use Interop.Lang.IterableZ.{IterableZ}
    use Interop.Util.Collection.{Collection}
    use Interop.Util.ListZ.{ListZ}

    ///
    /// Represents a Java VectorZ.
    /// Class / Mutable
    ///
    /// (Prefer ArrayList if thread safety is not needed)
    ///
    pub enum VectorZ[_a: Type, r: Region] {
        case VectorZ(Region[r], ##java.util.Vector)
    }


    // instance Interop.Flix.ColMarshal[VectorZ] {
    //     pub def colToJavaObject(x: VectorZ[a, r]): ##java.lang.Object = 
    //         let VectorZ(_, t1) = x;
    //         unchecked_cast(t1 as ##java.lang.Object)

    //     pub def colFromJavaObject(rc: Region[r], o: ##java.lang.Object): VectorZ[a, r] = 
    //         VectorZ(rc, unchecked_cast(o as ##java.util.Vector))
    // }

    instance Interop.Util.ImpCollection[VectorZ] {
        pub def toCollection(t: VectorZ[a, r]): Collection[a, r] = 
            let VectorZ(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): VectorZ[a, r] = 
            let Collection(rc, t1) = t;
            VectorZ(rc, unchecked_cast(t1 as ##java.util.Vector))
    }


    instance Interop.Util.ImpListZ[VectorZ] {
        pub def toListZ(t: VectorZ[a, r]): ListZ[a, r] = 
            let VectorZ(rc, t1) = t;
            ListZ(rc, unchecked_cast(t1 as ##java.util.List))

        pub def fromListZ(t: ListZ[a, r]): VectorZ[a, r] = 
            let ListZ(rc, t1) = t;
            VectorZ(rc, unchecked_cast(t1 as ##java.util.Vector))
    }

    instance Interop.Lang.ImpIterable[VectorZ] {
        pub def toIterable(t: VectorZ[a, r]): IterableZ[a, r] = 
            let VectorZ(rc, t1) = t;
            IterableZ(rc, unchecked_cast(t1 as ##java.lang.Iterable))

        pub def fromIterable(t: IterableZ[a, r]): VectorZ[a, r] = 
            let IterableZ(rc, t1) = t;
            VectorZ(rc, unchecked_cast(t1 as ##java.util.Vector))
    }

}

mod Interop.Util.VectorZ {

    use Interop.Util.VectorZ
    use Interop.Util.VectorZ.{VectorZ}
    use Interop.Util.Comparator
    use Interop.Util.Comparator.{Comparator}
    use Interop.Flix.GoesToJava


    pub def getHH(v: VectorZ[a, r]): ##java.util.Vector = 
        let VectorZ(_, v1) = v;
        v1
        
    pub def wrapHH(rc: Region[r], prim: ##java.util.Vector): VectorZ[a, r] = 
        VectorZ(rc, prim)


    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(rc: Region[r]): VectorZ[a, r] \ r =
        import new java.util.Vector(): ##java.util.Vector \ r as newVector;
        VectorZ(rc, newVector())

    pub def equals(v1: VectorZ[a, r], v2: VectorZ[a, r]): Bool \ r =
        import java.util.Vector.equals(##java.lang.Object): Bool \ r; 
        let VectorZ(_, jv1) = v1;
        let VectorZ(_, jv2) = v2;
        equals(jv1, checked_cast(jv2))


    pub def hashCode(v: VectorZ[a, r]): Int32 \ r = 
        import java.util.Vector.hashCode(): Int32 \ r;
        let VectorZ(_, v1) = v;
        hashCode(v1)

    pub def isEmpty(v: VectorZ[a, r]): Bool \ r = 
        import java.util.Vector.isEmpty(): Bool \ r;
        let VectorZ(_, v1) = v;
        isEmpty(v1)

    pub def size(v: VectorZ[a, r]): Int32 \ r = 
        import java.util.Vector.size(): Int32 \ r;
        let VectorZ(_, v1) = v;
        size(v1)

    pub def add!(x: a, v: VectorZ[a, r]): Bool \ r with GoesToJava[a] = 
        import java.util.Vector.add(##java.lang.Object): Bool \ r;
        let VectorZ(_, v1) = v;
        add(v1, Interop.Flix.GoesToJava.toJavaObject(x))


    pub def sort!(c: Comparator[a, ef], v: VectorZ[a, r]): Result[String, Unit] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.Vector.sort(##java.util.Comparator): Unit \ {ef, r}; 
            let VectorZ(_, v1) = v;
            let Comparator(c1) = c;
            sort(v1, c1)
        })



    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            getter: ##java.lang.Object -> b \ ef, 
                            v: VectorZ[a, r]): Iterator[b, ef + r1, r1] \ r =
        import java.util.Vector.iterator(): ##java.util.Iterator \ r;
        let VectorZ(_, v1) = v;
        if (Object.isNull(v1))
            Iterator.iterate(rc, _ -> checked_ecast(None))
        else 
            iterator(v1) 
                |> Interop.Util.IteratorZ.wrapHH(rc)
                |> Interop.Util.IteratorZ.toFlixIterator(rc, getter)

    pub def toFlixList(getter: ##java.lang.Object -> b \ ef, v: VectorZ[a, r]): List[b] \ {ef, r}  = region rc {
        toFlixIterator(rc, getter, v) |> Iterator.toList
    }
    
    pub def toFlixSet(getter: ##java.lang.Object -> b \ ef, v: VectorZ[a, r]): Set[b] \ {ef, r} with Order[b] = region rc {
        toFlixIterator(rc, getter, v) |> Iterator.toSet
    }


}
