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
    /// Represents a Java Set.
    /// Interface
    ///
    pub enum SetZ[_a: Type, _r: Region](##java.util.Set)

    pub class ImpSetZ[t: Type -> Region -> Type] {
        pub def toSetZ[a: Type, r: Region](s: t[a, r]): SetZ[a, r]
        pub def fromSetZ[a: Type, r: Region](s: SetZ[a, r]): t[a, r]
    }


    instance Scoped[SetZ[a]] {
        pub def regionOf(_: SetZ[a, r]): Region[r] = () as Region[r]
    }

    instance Interop/Util.ImpCollection[SetZ] {
        pub def toCollection(t: SetZ[a, r]): Collection[a, r] = 
            let SetZ(t1) = t;
            Collection(t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): SetZ[a, r] = 
            let Collection(t1) = t;
            SetZ(t1 as ##java.util.Set) 
    }


}

namespace Interop/Util/SetZ {

    use Interop/Util.SetZ;
    use Interop/Util.SetZ.{SetZ};
    use Interop/Util.ImpSetZ;
    use Interop/Flix.Marshal;


    pub def getHH(m: SetZ[a, r]): ##java.util.Set = 
        let SetZ(m1) = m;
        m1
        
    pub def wrapHH(_: Region[r], prim: ##java.util.Set): SetZ[a, r] = 
        SetZ(prim)


    pub def toSetHH[t: Type -> Region -> Type, a: Type, r: Region](s: t[a, r]): ##java.util.Set with ImpSetZ[t] = 
        Interop/Util/ImpSetZ.toSetZ(s) |> getHH


    pub def isEmpty(s: SetZ[a, r]): Bool \ Read(r) = 
        import java.util.Set.isEmpty(): Bool \ r;
        let SetZ(s1) = s;
        isEmpty(s1)

    pub def size(s: SetZ[a, r]): Int32 \ Read(r) = 
        import java.util.Set.size(): Int32 \ r;
        let SetZ(s1) = s;
        size(s1)

    pub def clear!(s: SetZ[a, r]): Unit \ Read(r) = 
        import java.util.Set.clear(): Unit \ r;
        let SetZ(s1) = s;
        clear(s1)


    pub def remove!(x: a, s: SetZ[a, r]): Result[Bool, String] \  Write(r) with Marshal[a] =
        try {
            import java.util.Set.remove(##java.lang.Object): Bool \ r; 
            let SetZ(s1) = s;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(s1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(s: SetZ[a, r]): Iterator[a, r] \ { Write(r) } with Marshal[a] =
        toFlixIterator(Scoped.regionOf(s), Interop/Flix/Marshal.fromJavaObject, s)


    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(r2: Region[r2], 
                            ocast: ##java.lang.Object -> a, 
                            s: SetZ[a, r]): Iterator[a, r2] \ { Read(r), Write(r2) } =
        import java.util.Set.iterator(): ##java.util.Iterator \ Write(r);
        let SetZ(s1) = s;
        if (Object.isNull(s1))
            Iterator.new(r2)
        else 
            iterator(s1) 
                |> Interop/Util/IteratorZ.wrapHH(r2)
                |> Interop/Util/IteratorZ.toFlixIterator(ocast)

    pub def toFlixSet(s: SetZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, s) |> Iterator.toSet
        }

    pub def toFlixList(s: SetZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, s) |> Iterator.toList
        }

}
