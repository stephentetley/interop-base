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

namespace Interop/Util/Stream/Stream {


    ///
    /// Represents a Java Stream.Builder
    ///
    pub enum Builder[_: Type, _: Region](##java.util.stream.Stream$Builder)


}


namespace Interop/Util/Stream/Stream/Builder {
    
    use Interop/Util/Stream/Stream.Builder
    use Interop/Util/Stream/Stream.Builder.{Builder}
    use Interop/Util/Stream.Stream
    use Interop/Util/Stream.Stream.{Stream}
    use Interop/Flix.Marshal;
    
    pub def getHH(x: Builder[a, r]): ##java.util.stream.Stream$Builder = 
        let Builder(x1) = x;
        x1

    pub def wrapHH(_: Region[r], prim: ##java.util.stream.Stream$Builder): Builder[a, r] = Builder(prim)


    pub def accept(t: a, b: Builder[a, r]): Result[String, Unit] \ Write(r) with Marshal[a] =
        try {
            import java.util.stream.Stream$Builder.accept(##java.lang.Object): Unit \ r;
            let Builder(b1) = b;
            let t1 = Interop/Flix/Marshal.toJavaObject(t);
            accept(b1, t1) |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def add(t: a, b: Builder[a, r]): Result[String, Builder[a, r]] \ Write(r) with Marshal[a] =
        try {
            import java.util.stream.Stream$Builder.add(##java.lang.Object): ##java.util.stream.Stream$Builder \ r;
            let Builder(b1) = b;
            let t1 = Interop/Flix/Marshal.toJavaObject(t);
            add(b1, t1) |> Builder |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

    pub def build(b: Builder[a, r]): Result[String, Stream[a, r]] \ Write(r) =
        try {
            import java.util.stream.Stream$Builder.build(): ##java.util.stream.Stream \ r;
            let Builder(b1) = b;
            build(b1) |> Stream |> Ok
        } catch {
            case ex: ##java.lang.Exception =>
                import java.lang.Throwable.getMessage(): String \ {};
                Err(getMessage(ex))
        }

}
