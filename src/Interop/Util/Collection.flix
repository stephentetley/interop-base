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
    /// Represents a Java Collection.
    /// Interface / Mutable (some implementations may not be mutable)
    ///
    pub enum Collection[_: Type, _: Region](##java.util.Collection)


    pub class ImpCollection[t: Type -> Region -> Type] {
        pub def toCollection[a: Type, r: Region](s: t[a, r]): Collection[a, r]
        pub def fromCollection[a: Type, r: Region](s: Collection[a, r]): t[a, r]
    }


}

namespace Interop/Util/Collection {

    use Interop/Util.Collection
    use Interop/Util.Collection.{Collection}
    use Interop/Util.ImpCollection
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}

    use Interop/Flix.Marshal


    pub def getHH(c: Collection[a, r]): ##java.util.Collection = 
        let Collection(c1) = c;
        c1


    pub def wrapHH(_: Region[r], col: ##java.util.Collection): Collection[a, r] = 
        Collection(col)


    pub def toCollectionHH[t: Type -> Region -> Type, a: Type, r: Region](col: t[a, r]): ##java.util.Collection with ImpCollection[t] = 
        Interop/Util/ImpCollection.toCollection(col) |> getHH



    pub def size(c: Collection[a, r]): Int32 \ Read(r) =
        import java.util.Collection.size(): Int32 \ r;
        let Collection(c1) = c;
        size(c1)

    pub def isEmpty(c: Collection[a, r]): Bool \ Read(r) =
        import java.util.Collection.isEmpty(): Bool \ r;
        let Collection(c1) = c;
        isEmpty(c1)

    pub def hashCode(c: Collection[a, r]): Int32 \ Read(r) =
        import java.util.Collection.hashCode(): Int32 \ r;
        let Collection(c1) = c;
        hashCode(c1)

    pub def clear!(c: Collection[a, r]): Result[String, Unit] \ Write(r) =
        try {
            import java.util.Collection.clear(): Unit \ r;
            let Collection(c1) = c;
            clear(c1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def add!(x: a, s: Collection[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Collection.add(##java.lang.Object): Bool \ r; 
            let Collection(s1) = s;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            add(s1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def remove!(x: a, c: Collection[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Collection.remove(##java.lang.Object): Bool \ r; 
            let Collection(c1) = c;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            remove(c1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    pub def removeIf!(f: a -> Bool \ ef, c: Collection[a, r]): Result[String, Bool] \  {ef, Write(r)} with Marshal[a] =
        try {
            import java.util.Collection.removeIf(##java.util.function.Predicate): Bool \ {ef, r}; 
            let Collection(c1) = c;            
            let f1 = Interop/Util/Function/Predicate.makePredicate(f);
            (unsafe_cast removeIf(c1, f1) as _ \ {ef, Write(r)}) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def forEach(f: a -> Unit \ ef, c: Collection[a, r]): Result[String, Unit] \  {ef, Read(r)} with Marshal[a] =
        try {
            import java.util.Collection.forEach(##java.util.function.Consumer): Unit \ r; 
            let Collection(c1) = c;
            let f1 = Interop/Util/Function/Consumer.makeConsumer(f);
            forEach(c1, f1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }


    // Uses `Object.equals` for comparing.
    pub def contains(x: a, c: Collection[a, r]): Result[String, Bool] \  Write(r) with Marshal[a] =
        try {
            import java.util.Collection.contains(##java.lang.Object): Bool \ r; 
            let Collection(c1) = c;
            let x1 = Interop/Flix/Marshal.toJavaObject(x);        
            contains(c1, x1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def stream(rc: Region[r1], c: Collection[a, r]): Stream[a, r1] \ { Read(r) }  with Marshal[a] =
        import java.util.Collection.stream(): ##java.util.stream.Stream \ r; 
        let Collection(c1) = c;
        Stream(rc, stream(c1))

    pub def iterator(rc: Region[r1], c: Collection[a, r]): Iterator[a, r1, r1] \ { Read(r) } with Marshal[a] =
        toFlixIterator(rc, Interop/Flix/Marshal.fromJavaObject, c)
        

    pub def toFlixIterator(rc: Region[r1], 
                            ocast: ##java.lang.Object -> a,
                            c: Collection[a, r]): Iterator[a, r1, r1] \ { Read(r) } with Marshal[a] =
        import java.util.Collection.iterator(): ##java.util.Iterator \ { Read(r) } as iterator;
        let Collection(c1) = c;
        if (Object.isNull(c1))
            Iterator.empty(rc)
        else 
            iterator(c1) 
                |> Interop/Util/IteratorZ.wrapHH(rc)
                |> Interop/Util/IteratorZ.toFlixIterator(rc, ocast)

    /// pub def enumerator(r: Region[r1], c: Collection[a, r2]): Iterator[(a, Int32), r] \ { Read(r2), Write(r1) }  with Marshal[a] =
    ///     iterator(r, c) |> Iterator.enumerator

    pub def unfoldCollection(_: Region[r], f: s -> Option[(a, s)] & ef, st: s): Collection[a, r] \ { Write(r),  ef } with Marshal[a] =
        import new java.util.LinkedList(): ##java.util.LinkedList & r as new1;
        import java.util.LinkedList.add(##java.lang.Object): Bool & r as add1;
        def loop(st1, acc) = match f(st1) {
            case None         => Collection(unsafe_cast acc as ##java.util.Collection)
            case Some(o, st2) => {discard add1(acc, Interop/Flix/Marshal.toJavaObject(o)); loop(st2, acc)}
        };
        loop(st, new1())


    pub def fromList(r: Region[r], l: List[a]): Collection[a, r] \ { Write(r) } with Marshal[a] =
        let step = xs -> match xs {
            case Nil     => None
            case x :: rs => Some((x, rs))
        };
        unfoldCollection(r, step, l)

}
