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
    /// Represents a Java IntStream.
    ///
    pub enum IntStream[_r: Region](##java.util.stream.IntStream)

    instance Scoped[IntStream] {
        pub def regionOf(_: IntStream[r]): Region[r] = () as Region[r]
    }


}


namespace Interop/Util/Stream/IntStream {
    
    use Interop/Util/Stream.IntStream;
    use Interop/Util/Stream.IntStream.{IntStream};
    
    use Interop/Flix.Marshal;

    pub def getHH(x: IntStream[r]): ##java.util.stream.IntStream = 
        let IntStream(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.util.stream.IntStream): IntStream[r] = IntStream(prim)

    pub def intStreamIterator(s: IntStream[r]): Iterator[Int32, r] \ Write(r) =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator \ r;
        let r = Scoped.regionOf(s);
        let IntStream(s1) = s;
        let iter1 = iterator(s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(r, iter1);
        Interop/Util/IteratorZ.iterator(iter2)

    pub def range(_: Region[r], b: Int32, e: Int32): IntStream[r] \ Write(r) = 
        import static java.util.stream.IntStream.range(Int32, Int32): ##java.util.stream.IntStream \ r;
        range(b, e) |> IntStream
        
}
