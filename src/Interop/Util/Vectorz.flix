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
    /// Represents a Java VectorZ.
    /// Class / Mutable
    ///
    /// (Prefer ArrayList if thread safety is not needed)
    ///
    pub enum VectorZ[_a: Type, _r: Region](##java.util.Vector)


    instance Interop/Util.ImpCollection[VectorZ] {
        pub def toCollection(t: VectorZ[a, r]): Collection[a, r] = 
            let VectorZ(t1) = t;
            Collection(unsafe_cast t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): VectorZ[a, r] = 
            let Collection(t1) = t;
            VectorZ(unsafe_cast t1 as ##java.util.Vector) 
    }


}

namespace Interop/Util/VectorZ {

    use Interop/Util.VectorZ;
    use Interop/Util.VectorZ.{VectorZ};
    use Interop/Util.Comparator;
    use Interop/Flix.Marshal;


    pub def getHH(m: VectorZ[a, r]): ##java.util.Vector = 
        let VectorZ(m1) = m;
        m1
        
    pub def wrapHH(_: Region[r], prim: ##java.util.Vector): VectorZ[a, r] = 
        VectorZ(prim)


    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(_: Region[r]): VectorZ[a, r] \ Write(r) =
        import new java.util.Vector(): ##java.util.Vector \ r as newVector;
        VectorZ(newVector())

    pub def equals(v1: VectorZ[a, r], v2: VectorZ[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.Vector.equals(##java.lang.Object): Bool \ r; 
        let VectorZ(jv1) = v1;
        let VectorZ(jv2) = v2;
        equals(jv1, unsafe_cast jv2 as ##java.lang.Object)


    pub def hashCode(v: VectorZ[a, r]): Int32 \ Read(r) = 
        import java.util.Vector.hashCode(): Int32 \ r;
        let VectorZ(v1) = v;
        hashCode(v1)

    pub def isEmpty(v: VectorZ[a, r]): Bool \ Read(r) = 
        import java.util.Vector.isEmpty(): Bool \ r;
        let VectorZ(v1) = v;
        isEmpty(v1)

    pub def size(v: VectorZ[a, r]): Int32 \ Read(r) = 
        import java.util.Vector.size(): Int32 \ r;
        let VectorZ(v1) = v;
        size(v1)

    pub def add!(x: a, v: VectorZ[a, r]): Bool \ { Write(r) } with Marshal[a] = 
        import java.util.Vector.add(##java.lang.Object): Bool & r;
        let VectorZ(v1) = v;
        add(v1, Interop/Flix/Marshal.toJavaObject(x))


    pub def sort!(f: (a, a) -> Int32, v: VectorZ[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        let f1 = Interop/Util/Comparator.makeComparator(f);
        sortWithComparator!(f1, v)


    pub def sortWithComparator!(c: Comparator[a], v: VectorZ[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        try {
            import java.util.Vector.sort(##java.util.Comparator): Unit \ r; 
            let VectorZ(v1) = v;
            sort(v1, c) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(rh: Region[rh], v: VectorZ[a, r]): Iterator[a, rh] \ { Read(r), Write(rh) } with Marshal[a] =
        toFlixIterator(rh, Interop/Flix/Marshal.fromJavaObject, v)


    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(rh: Region[rh], 
                            ocast: ##java.lang.Object -> a, 
                            v: VectorZ[a, r]): Iterator[a, rh] \ { Read(r), Write(rh) } =
        import java.util.Vector.iterator(): ##java.util.Iterator \ { Read(r), Write(rh) };
        let VectorZ(v1) = v;
        if (Object.isNull(v1))
            Iterator.new(rh)
        else 
            iterator(v1) 
                |> Interop/Util/IteratorZ.wrapHH(rh)
                |> Interop/Util/IteratorZ.toFlixIterator(rh, ocast)

    pub def toFlixSet(v: VectorZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, v) |> Iterator.toSet
        }

    pub def toFlixList(v: VectorZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, v) |> Iterator.toList
        }

}
