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
    /// Represents a Java Vector.
    /// Class / Mutable
    ///
    /// (Prefer ArrayList if thread safety is not needed)
    ///
    pub enum Vector[_a: Type, _r: Region](##java.util.Vector)


    instance Scoped[Vector[a]] {
        pub def regionOf(_: Vector[a, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpCollection[Vector] {
        pub def toCollection(t: Vector[a, r]): Collection[a, r] = 
            let Vector(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): Vector[a, r] = 
            let Collection(t1) = t;
            Vector(t1 as ##java.util.Vector) 
    }


}

namespace Interop/Util/Vector {

    use Interop/Util.Vector;
    use Interop/Util.Vector.{Vector};
    use Interop/Util.Comparator;
    use Interop/Flix.Marshal;


    pub def getHH(m: Vector[a, r]): ##java.util.Vector = 
        let Vector(m1) = m;
        m1
        
    pub def wrapHH(_: Region[r], prim: ##java.util.Vector): Vector[a, r] = 
        Vector(prim)


    ///
    /// Returns a new mutable ArrayList.
    ///
    pub def new(_: Region[r]): Vector[a, r] \ Write(r) =
        import new java.util.Vector(): ##java.util.Vector \ r as newVector;
        Vector(newVector())

    pub def equals(v1: Vector[a, r], v2: Vector[a, r]): Bool \  Read(r) with Marshal[a] =
        import java.util.Vector.equals(##java.lang.Object): Bool \ r; 
        let Vector(jv1) = v1;
        let Vector(jv2) = v2;
        equals(jv1, jv2 as ##java.lang.Object)


    pub def hashCode(v: Vector[a, r]): Int32 \ Read(r) = 
        import java.util.Vector.hashCode(): Int32 \ r;
        let Vector(v1) = v;
        hashCode(v1)

    pub def isEmpty(v: Vector[a, r]): Bool \ Read(r) = 
        import java.util.Vector.isEmpty(): Bool \ r;
        let Vector(v1) = v;
        isEmpty(v1)

    pub def size(v: Vector[a, r]): Int32 \ Read(r) = 
        import java.util.Vector.size(): Int32 \ r;
        let Vector(v1) = v;
        size(v1)

    pub def add!(x: a, v: Vector[a, r]): Bool \ { Write(r) } with Marshal[a] = 
        import java.util.Vector.add(##java.lang.Object): Bool & r;
        let Vector(v1) = v;
        add(v1, Interop/Flix/Marshal.toJavaObject(x))


    pub def sort!(f: (a, a) -> Int32, v: Vector[a, r]): Result[Unit, String] \ Write(r) with Marshal[a] =
        let f1 = Interop/Util/Comparator.makeComparator(f);
        sortWithComparator!(f1, v)


    pub def sortWithComparator!(c: Comparator[a], v: Vector[a, r]): Result[Unit, String] \ Write(r) with Marshal[a] =
        try {
            import java.util.Vector.sort(##java.util.Comparator): Unit \ r; 
            let Vector(v1) = v;
            sort(v1, c) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(v: Vector[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        toFlixIterator(Scoped.regionOf(v), Interop/Flix/Marshal.fromJavaObject, v)


    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(r2: Region[r2], 
                            ocast: ##java.lang.Object -> a, 
                            v: Vector[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } =
        import java.util.Vector.iterator(): ##java.util.Iterator \ Write(r);
        let Vector(v1) = v;
        if (Object.isNull(v1))
            Iterator.new(r2)
        else 
            iterator(v1) 
                |> Interop/Util/IteratorZ.wrapHH(r2)
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)

    pub def toFlixSet(v: Vector[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, v) |> Iterator.toSet
        }

    pub def toFlixList(v: Vector[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, v) |> Iterator.toList
        }

}
