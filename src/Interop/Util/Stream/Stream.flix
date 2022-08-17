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

namespace Interop/Util/Stream {

    ///
    /// Represents a Java Stream.
    ///
    pub enum Stream[_a: Type, _r: Region](##java.util.stream.Stream)


    instance Scoped[Stream[a]] {
        pub def regionOf(_: Stream[a, r]): Region[r] = () as Region[r]
    }

}


namespace Interop/Util/Stream/Stream {
    
    use Interop/Util/Stream.Stream;
    use Interop/Util/Stream.Stream.{Stream};
    
    use Interop/Flix.Marshal;

    pub def getHH(x: Stream[a, r]): ##java.util.stream.Stream = 
        let Stream(x1) = x;
        x1

    pub def mkStream(_: Region[r], prim: ##java.util.stream.Stream): Stream[a, r] \ Write(r) = 
        Stream(prim) as \ Write(r)


    pub def iterator(s: Stream[a, r]): Iterator[a, r] \ Write(r) with Marshal[a] =
        iteratorWith(Interop/Flix/Marshal.fromJavaObject, s)

    pub def iteratorWith(ocast: ##java.lang.Object -> a, s: Stream[a, r]): Iterator[a, r] \ Write(r) with Marshal[a] =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator & r;
        import java.util.Iterator.hasNext(): Bool & r;
        import java.util.Iterator.next(): ##java.lang.Object & r;
        let Stream(s1) = s;
        let iter1 = iterator(s1 as ##java.util.stream.BaseStream);
        let isDone = () -> { 
            let ans = hasNext(iter1);
            not ans
        };
        let getNext = () -> {
            let a1 = next(iter1);
            ocast(a1)
        };
        Iterator(isDone, getNext)

    
    pub def distinct(s: Stream[a, r]): Stream[a, r] \ Write(r) = 
        import java.util.stream.Stream.distinct(): ##java.util.stream.Stream & r;
        let Stream(s1) = s;
        Stream(distinct(s1))

    pub def count(s: Stream[a, r]): Int64 \ Write(r) = 
        import java.util.stream.Stream.count(): Int64 & r;
        let Stream(s1) = s;
        count(s1)

}
