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
    
    use Interop.Util.SetZ
    use Interop.Util.SetZ.{SetZ}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}

    ///
    /// Represents a Java Set.
    /// Interface
    ///
    pub enum SetZ[_a: Type, r: Region]{
        case SetZ(Region[r], ##java.util.Set)
    }

    pub class ImpSetZ[t: Type -> Region -> Type] {
        pub def toSetZ(s: t[a, r]): SetZ[a, r]
        pub def fromSetZ(s: SetZ[a, r]): t[a, r]
        
        pub def toSetHH(s: t[a, r]): ##java.util.Set = 
            ImpSetZ.toSetZ(s) |> Interop.Util.SetZ.getHH
    }

    // instance Interop.Flix.ColMarshal[SetZ] {
    //     pub def colToJavaObject(x: SetZ[a, r]): ##java.lang.Object = 
    //         let SetZ(_, t1) = x;
    //         unchecked_cast(t1 as ##java.lang.Object)

    //     pub def colFromJavaObject(rc: Region[r], o: ##java.lang.Object): SetZ[a, r] = 
    //         SetZ(rc, unchecked_cast(o as ##java.util.Set))
    // }

    instance Interop.Util.ImpCollection[SetZ] {
        pub def toCollection(t: SetZ[a, r]): Collection[a, r] = 
            let SetZ(rc, t1) = t;
            Collection(rc, unchecked_cast(t1 as ##java.util.Collection))

        pub def fromCollection(t: Collection[a, r]): SetZ[a, r] = 
            let Collection(rc, t1) = t;
            SetZ(rc, unchecked_cast(t1 as ##java.util.Set))
    }


}

mod Interop.Util.SetZ {

    use Interop.Util.SetZ
    use Interop.Util.SetZ.{SetZ}
    use Interop.Util.Collection
    use Interop.Util.Collection.{Collection}
    use Interop.Util.ImpSetZ
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.GoesToJava
    use Interop.Flix.MutMarshal

    pub def getHH(s: SetZ[a, r]): ##java.util.Set = 
        let SetZ(_, s1) = s;
        s1
        
    pub def wrapHH(rc: Region[r], prim: ##java.util.Set): SetZ[a, r] = 
        SetZ(rc, prim)





    pub def of0(rc: Region[r]): SetZ[a, r] \ r with GoesToJava[a] =
        import static java.util.Set.of(): ##java.util.Set \ r;
        SetZ(rc, of())

    pub def of1(rc: Region[r], e1: a): SetZ[a, r] \ r with GoesToJava[a] =
        import static java.util.Set.of(##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        SetZ(rc, of(eo1))

    pub def of2(rc: Region[r], e1: a, e2: a): SetZ[a, r] \ r with GoesToJava[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let eo2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        SetZ(rc, of(eo1, eo2))

    pub def of3(rc: Region[r], e1: a, e2: a, e3: a): SetZ[a, r] \ r with GoesToJava[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let eo2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        let eo3 = Interop.Flix.GoesToJava.toJavaObject(e3);
        SetZ(rc, of(eo1, eo2, eo3))

    pub def of4(rc: Region[r], e1: a, e2: a, e3: a, e4: a): SetZ[a, r] \ r with GoesToJava[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let eo2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        let eo3 = Interop.Flix.GoesToJava.toJavaObject(e3);
        let eo4 = Interop.Flix.GoesToJava.toJavaObject(e4);
        SetZ(rc, of(eo1, eo2, eo3, eo4))

    pub def of5(rc: Region[r], e1: a, e2: a, e3: a, e4: a, e5: a): SetZ[a, r] \ r with GoesToJava[a] =
        import static java.util.Set.of(##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object, ##java.lang.Object): ##java.util.Set \ r;
        let eo1 = Interop.Flix.GoesToJava.toJavaObject(e1);
        let eo2 = Interop.Flix.GoesToJava.toJavaObject(e2);
        let eo3 = Interop.Flix.GoesToJava.toJavaObject(e3);
        let eo4 = Interop.Flix.GoesToJava.toJavaObject(e4);
        let eo5 = Interop.Flix.GoesToJava.toJavaObject(e5);
        SetZ(rc, of(eo1, eo2, eo3, eo4, eo5))


    pub def equals(s1: SetZ[a, r], s2: SetZ[a, r]): Bool \ r =
        import java.util.Set.equals(##java.lang.Object): Bool \ r; 
        let SetZ(_, ss1) = s1;
        let SetZ(_, ss2) = s2;
        equals(ss1, checked_cast(ss2))


    pub def hashCode(s: SetZ[a, r]): Int32 \ r = 
        import java.util.Set.hashCode(): Int32 \ r;
        let SetZ(_, s1) = s;
        hashCode(s1)

    pub def isEmpty(s: SetZ[a, r]): Bool \ r = 
        import java.util.Set.isEmpty(): Bool \ r;
        let SetZ(_, s1) = s;
        isEmpty(s1)

    pub def size(s: SetZ[a, r]): Int32 \ r = 
        import java.util.Set.size(): Int32 \ r;
        let SetZ(_, s1) = s;
        size(s1)

    pub def add!(x: a, s: SetZ[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Set.add(##java.lang.Object): Bool \ r; 
            let SetZ(_, s1) = s;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            add(s1, x1)
        })

    // pub def addMut![r: Region, t: Region -> Type]
    //                 (x: t[r], s: SetZ[t[r], r]): Result[String, Bool] \ r with MutMarshal[t] =
    //     Result.tryCatch(_ -> {
    //         import java.util.Set.add(##java.lang.Object): Bool \ r; 
    //         let SetZ(_, s1) = s;
    //         let x1 = Interop.Flix.MutMarshal.mutToJavaObject(x);
    //         add(s1, x1)
    //     })


    pub def addAll!(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Set.addAll(##java.util.Collection): Bool \ r; 
            let SetZ(_, s1) = s;
            let Collection(_, c1) = c;
            addAll(s1, c1)
        })



    pub def contains(x: a, s: SetZ[a, r]): Result[String, Bool] \  r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Set.contains(##java.lang.Object): Bool \ r; 
            let SetZ(_, s1) = s;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            contains(s1, x1)
        })

    pub def containsAll(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \  r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Set.containsAll(##java.util.Collection): Bool \ r; 
            let SetZ(_, s1) = s;
            let Collection(_, c1) = c;
            containsAll(s1, c1)
        })

    pub def clear!(s: SetZ[a, r]): Result[String, Unit] \ r = 
        Result.tryCatch(_ -> {
            import java.util.Set.clear(): Unit \ r;
            let SetZ(_, s1) = s;
            clear(s1)
        })

    pub def remove!(x: a, s: SetZ[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Set.remove(##java.lang.Object): Bool \ r; 
            let SetZ(_, s1) = s;
            let x1 = Interop.Flix.GoesToJava.toJavaObject(x);        
            remove(s1, x1)
        })

    pub def removeAll!(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.Set.removeAll(##java.util.Collection): Bool \ r; 
            let SetZ(_, s1) = s;
            let Collection(_, c1) = c;
            removeAll(s1, c1)
        })

    
    pub def removeIf!(f: PredicateZ[a, ef], s: SetZ[a, r]): Result[String, Bool] \ {ef, r} =
        Result.tryCatch(_ -> {
            import java.util.Set.removeIf(##java.util.function.Predicate): Bool \ {ef, r};
            let SetZ(_, s1) = s;
            let PredicateZ(f1) = f;
            checked_ecast(removeIf(s1, f1))
        })

    pub def retainAll!(c: Collection[a, r], s: SetZ[a, r]): Result[String, Bool] \ r =
        Result.tryCatch(_ -> {
            import java.util.Set.retainAll(##java.util.Collection): Bool \ r; 
            let SetZ(_, s1) = s;
            let Collection(_, c1) = c;
            retainAll(s1, c1)
        })


    pub def fromFoldableViaHashSet(rc: Region[r], t: t[a]): SetZ[a, r] \ r with Foldable[t], GoesToJava[a] =
        Interop.Util.HashSet.fromFoldable(rc, t) |> Interop.Util.ImpSetZ.toSetZ

    pub def fromFoldableViaHashSetHH(t: t[a]): ##java.util.Set with Foldable[t], GoesToJava[a] = region rc {
        Interop.Util.HashSet.fromFoldable(rc, t) |> Interop.Util.ImpSetZ.toSetHH
    }


    ///
    /// Returns an iterator over `s`.
    ///
    pub def toFlixIterator(rc: Region[r1], 
                            getter: ##java.lang.Object -> b \ ef, 
                            s: SetZ[a, r]): Iterator[b, ef + r1, r1] \ r =
        import java.util.Set.iterator(): ##java.util.Iterator \ r;
        let SetZ(_, s1) = s;
        if (Object.isNull(s1))
            Iterator.iterate(rc, _ -> checked_ecast(None))
        else 
            iterator(s1) 
                |> Interop.Util.IteratorZ.wrapHH(rc) 
                |> Interop.Util.IteratorZ.toFlixIterator(rc, getter)

    pub def toFlixList(getter: ##java.lang.Object -> b \ ef, s: SetZ[a, r]): List[b] \ {ef, r} = region rc {
        toFlixIterator(rc, getter, s) |> Iterator.toList
    }

    pub def toFlixSet(fromJava: ##java.lang.Object -> b \ ef, s: SetZ[a, r]): Set[b] \ {ef, r} with Order[b] = region rc {
        toFlixIterator(rc, fromJava, s) |> Iterator.toSet
    }

    pub def toFlixVector(fromJava: ##java.lang.Object -> b \ ef, s: SetZ[a, r]): Vector[b] \ {ef, r} = region rc {
        toFlixIterator(rc, fromJava, s) |> Iterator.toVector
    }

}
