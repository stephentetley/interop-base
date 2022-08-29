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
    /// Represents a Java LongStream.
    ///
    pub enum LongStream[_r: Region](##java.util.stream.LongStream)

    instance Scoped[LongStream] {
        pub def regionOf(_: LongStream[r]): Region[r] = () as Region[r]
    }


}


namespace Interop/Util/Stream/Stream {
    
    use Interop/Util/Stream.LongStream;
    use Interop/Util/Stream.LongStream.{LongStream};
    use Interop/Flix.Marshal;

    pub def newLongStream(_: Region[r], prim: ##java.util.stream.LongStream): LongStream[r] = LongStream(prim)

    pub def longStreamIterator(s: LongStream[r]): Iterator[Int64, r] \ Write(r) =
        import java.util.stream.BaseStream.iterator(): ##java.util.Iterator & r;
        let r = Scoped.regionOf(s);
        let LongStream(s1) = s;
        let iter1 = iterator(s1 as ##java.util.stream.BaseStream);
        let iter2 = Interop/Util/IteratorZ.wrapHH(r, iter1);
        Interop/Util/IteratorZ.iterator(iter2)


}
