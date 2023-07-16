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

mod Interop.Util.Stream {


    ///
    /// Represents a Java Stream.Builder
    ///
    pub enum StreamBuilder[_a: Type, r: Region] { 
        case StreamBuilder(Region[r], ##java.util.stream.Stream$Builder)
    }


}


mod Interop.Util.Stream.StreamBuilder {
    
    use Interop.Util.Stream.StreamBuilder
    use Interop.Util.Stream.StreamBuilder.{StreamBuilder}
    use Interop.Util.Stream.Stream
    use Interop.Util.Stream.Stream.{Stream}
    use Interop.Flix.GoesToJava
    
    pub def getHH(x: StreamBuilder[a, r]): ##java.util.stream.Stream$Builder = 
        let StreamBuilder(_, x1) = x;
        x1

    pub def wrapHH(rc: Region[r], prim: ##java.util.stream.Stream$Builder): StreamBuilder[a, r] = 
        StreamBuilder(rc, prim)


    pub def accept(t: a, b: StreamBuilder[a, r]): Result[String, Unit] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.stream.Stream$Builder.accept(##java.lang.Object): Unit \ r;
            let StreamBuilder(_, b1) = b;
            let t1 = Interop.Flix.GoesToJava.toJavaObject(t);
            accept(b1, t1)
        })

    pub def add(t: a, b: StreamBuilder[a, r]): Result[String, StreamBuilder[a, r]] \ r with GoesToJava[a] =
        Result.tryCatch(_ -> {
            import java.util.stream.Stream$Builder.add(##java.lang.Object): ##java.util.stream.Stream$Builder \ r;
            let StreamBuilder(rc, b1) = b;
            let t1 = Interop.Flix.GoesToJava.toJavaObject(t);
            StreamBuilder(rc, add(b1, t1))
        })

    pub def build(b: StreamBuilder[a, r]): Result[String, Stream[a, ef, r]] \ r =
        Result.tryCatch(_ -> {
            import java.util.stream.Stream$Builder.build(): ##java.util.stream.Stream \ {};
            let StreamBuilder(rc, b1) = b;
            Stream(rc, checked_ecast(build(b1)))
        })

}
