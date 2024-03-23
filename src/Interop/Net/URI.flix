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

mod Interop.Net {

    
    /// Immutable?

    pub enum URI(##java.net.URI)


}

mod Interop.Net.URI {

    use Interop.Net.URI
    use Interop.Net.URI.{URI}
    use Interop.Net.URL
    use Interop.Net.URL.{URL}


    pub def getHH(u: URI): ##java.net.URI = 
        let URI(u1) = u;
        u1

    pub def wrapHH(prim: ##java.net.URI): URI = 
        URI(prim)

    pub def make(s: String): Result[String, URI] = 
        Result.tryCatch(_ -> {
            import java_new java.net.URI(String): ##java.net.URI \ {} as new1;
            URI(new1(s))
        })

    pub def create(s: String): Result[String, URI] = 
        Result.tryCatch(_ -> {
            import static java.net.URI.create(String): ##java.net.URI \ {};
            URI(create(s))
        })

    pub def equals(x: URI, y: URI): Bool =
        import java.net.URI.equals(##java.lang.Object): Bool \ {};
        let URI(x1) = x;
        let URI(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compareTo(x: URI, y: URI): Int32 =
        import java.net.URI.compareTo(##java.net.URI): Int32 \ {};
        let URI(x1) = x;
        let URI(y1) = y;
        compareTo(x1, y1)


    pub def toString(u: URI): String = 
        import java.net.URI.toString(): String \ {};
        let URI(u1) = u;
        toString(u1)


    pub def toASCIIString(u: URI): String = 
        import java.net.URI.toASCIIString(): String \ {};
        let URI(u1) = u;
        toASCIIString(u1)

    pub def toURI(u: URI): Result[String, URL] = 
        Result.tryCatch(_ -> {
            import java.net.URI.toURL(): ##java.net.URL \ {};
            let URI(u1) = u;
            URL(toURL(u1))
        })

}
