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

    pub enum URL(##java.net.URL)


}

mod Interop.Net.URL {

    use Interop.Net.URL
    use Interop.Net.URL.{URL}
    use Interop.Net.URI
    use Interop.Net.URI.{URI}


    pub def getHH(u: URL): ##java.net.URL = 
        let URL(u1) = u;
        u1

    pub def wrapHH(prim: ##java.net.URL): URL = 
        URL(prim)

    pub def new(s: String): Result[String, URL] = 
        Result.tryCatch(_ -> {
            import java_new java.net.URL(String): ##java.net.URL \ {} as new1;
            URL(new1(s))
        })


    pub def equals(x: URL, y: URL): Bool =
        import java.net.URL.equals(##java.lang.Object): Bool \ {};
        let URL(x1) = x;
        let URL(y1) = y;
        equals(x1, checked_cast(y1))

    pub def toString(u: URL): String = 
        import java.net.URL.toString(): String \ {};
        let URL(u1) = u;
        toString(u1)


    pub def toURI(u: URL): Result[String, URI] = 
        Result.tryCatch(_ -> {
            import java.net.URL.toURI(): ##java.net.URI \ {};
            let URL(u1) = u;
            URI(toURI(u1))
        })

}
