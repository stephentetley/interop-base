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

    instance Interop/Util.ImpCollection[SetZ] {
        pub def toCollection(t: SetZ[a, r]): Collection[a, r] = 
            let SetZ(t1) = t;
            Collection(unsafe_cast t1 as ##java.util.Collection)

        pub def fromCollection(t: Collection[a, r]): SetZ[a, r] = 
            let Collection(t1) = t;
            SetZ(unsafe_cast t1 as ##java.util.Set) 
    }


}

namespace Interop/Util/SetZ {

    use Interop/Util.SetZ
    use Interop/Util.SetZ.{SetZ}
    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.ImpSetZ
    use Interop/Flix.Marshal


    pub def getHH(m: SetZ[a, r]): ##java.util.Set = 
        let SetZ(m1) = m;
        m1
        
    pub def wrapHH(_: Region[r], prim: ##java.util.Set): SetZ[a, r] = 
        SetZ(prim)


    pub def toSetHH[t: Type -> Region -> Type, a: Type, r: Region](s: t[a, r]): ##java.util.Set with ImpSetZ[t] = 
        Interop/Util/ImpSetZ.toSetZ(s) |> getHH

    pub def of0(_: Region[r]): SetZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Set.of(): ##java.util.Set \ r;
        of() |> SetZ

    pub def of1(_: Region[r], e1: a): SetZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Set.of(##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        of(eo1) |> SetZ

    pub def of2(_: Region[r], e1: a, e2: a): SetZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        of(eo1, eo2) |> SetZ

    pub def of3(_: Region[r], e1: a, e2: a, e3: a): SetZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        of(eo1, eo2, eo3) |> SetZ

    pub def of4(_: Region[r], e1: a, e2: a, e3: a, e4: a): SetZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        let eo4 = Interop/Flix/Marshal.toJavaObject(e4);
        of(eo1, eo2, eo3, eo4) |> SetZ

    pub def of5(_: Region[r], e1: a, e2: a, e3: a, e4: a, e5: a): SetZ[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop/Flix/Marshal.toJavaObject(e1);
        let eo2 = Interop/Flix/Marshal.toJavaObject(e2);
        let eo3 = Interop/Flix/Marshal.toJavaObject(e3);
        let eo4 = Interop/Flix/Marshal.toJavaObject(e4);
        let eo5 = Interop/Flix/Marshal.toJavaObject(e5);
        of(eo1, eo2, eo3, eo4, eo5) |> SetZ


    pub def equals(s1: SetZ[a, r], s2: SetZ[a, r]): Bool \ Read(r) =
        import java.util.Set.equals(##java.lang.Object): Bool \ r; 
        let SetZ(js1) = s1;
        let SetZ(js2) = s2;
        equals(js1, unsafe_cast js2 as ##java.lang.Object)


    pub def hashCode(s: SetZ[a, r]): Int32 \ Read(r) = 
        import java.util.Set.hashCode(): Int32 \ r;
        let SetZ(s1) = s;
        hashCode(s1)

    pub def isEmpty(s: SetZ[a, r]): Bool \ Read(r) = 
        import java.util.Set.isEmpty(): Bool \ r;
        let SetZ(s1) = s;
        isEmpty(s1)

    pub def size(s: SetZ[a, r]): Int32 \ Read(r) = 
        import java.util.Set.size(): Int32 \ r;
        let SetZ(s1) = s;
        size(s1)

    pub def add!(x: a, s: SetZ[a, r]): Result[String, Bool] \  Read(r) with Marshal[a] =
        try {
            import java.util.Set.add(##java.lang.Object): Bool \ r; 
            let SetZ(s1) = s;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            add(s1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def addAll!(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Set.addAll(##java.util.Collection): Bool \ r; 
            let SetZ(s1) = s;
            let Collection(c1) = c;
            addAll(s1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def contains(x: a, s: SetZ[a, r]): Result[String, Bool] \  Read(r) with Marshal[a] =
        try {
            import java.util.Set.contains(##java.lang.Object): Bool \ r; 
            let SetZ(s1) = s;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            contains(s1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def containsAll(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Set.containsAll(##java.util.Collection): Bool \ r; 
            let SetZ(s1) = s;
            let Collection(c1) = c;
            containsAll(s1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def clear!(s: SetZ[a, r]): Result[String, Unit] \ Read(r) = 
        try {
            import java.util.Set.clear(): Unit \ r;
            let SetZ(s1) = s;
            clear(s1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def remove!(x: a, s: SetZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
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

    pub def removeAll!(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Set.removeAll(##java.util.Collection): Bool \ r; 
            let SetZ(s1) = s;
            let Collection(c1) = c;
            removeAll(s1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    
    pub def removeIf!(f: a -> Bool \ ef, s: SetZ[a, r]): Result[String, Bool] \  {ef, Write(r)} with Marshal[a] =
        try {
            import java.util.Set.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let SetZ(s1) = s;        
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            (unsafe_cast (removeIf(s1, f1)) as _ \ {ef, Write(r)}) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def retainAll!(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Set.retainAll(##java.util.Collection): Bool \ r; 
            let SetZ(s1) = s;
            let Collection(c1) = c;
            retainAll(s1, c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    ///
    /// Returns an iterator over `s`.
    ///
    pub def iterator(rh: Region[rh], s: SetZ[a, r]): Iterator[a, rh] \ { Read(r), Write(rh) } with Marshal[a] =
        toFlixIterator(rh, Interop/Flix/Marshal.fromJavaObject, s)


    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(rh: Region[rh], 
                            ocast: ##java.lang.Object -> a, 
                            s: SetZ[a, r]): Iterator[a, rh] \ { Read(r), Write(rh) } =
        import java.util.Set.iterator(): ##java.util.Iterator \ { Read(r), Write(rh) };
        let SetZ(s1) = s;
        if (Object.isNull(s1))
            Iterator.new(rh)
        else 
            iterator(s1) 
                |> Interop/Util/IteratorZ.wrapHH(rh)
                |> Interop/Util/IteratorZ.toFlixIterator(rh, ocast)

    pub def toFlixSet(s: SetZ[a, r]): Set[a] \ { Read(r) } with Order[a], Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, s) |> Iterator.toSet
        }

    pub def toFlixList(s: SetZ[a, r]): List[a] \ { Read(r) } with Marshal[a] =
        region r2 {
            toFlixIterator(r2, Interop/Flix/Marshal.fromJavaObject, s) |> Iterator.toList
        }

}
