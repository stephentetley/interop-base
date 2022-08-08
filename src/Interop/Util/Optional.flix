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
    /// Represents a Java Optional.
    ///
    pub enum Optional[_a: Type, _r: Region](##java.util.Optional)


    instance Scoped[Optional[a]] {
        pub def regionOf(_: Optional[a, r]): Region[r] = () as Region[r]
    }

}


namespace Interop/Util/Optional {
    
    use Interop/Util.Optional;
    use Interop/Util.Optional.{Optional};
    use Interop/Flix.Marshal;

    pub def getHH(o: Optional[a, r]): ##java.util.Optional = 
        let Optional(o1) = o;
        o1


    pub def new(_: Region[r], prim: ##java.util.Optional): Optional[a, r] = Optional(prim)


    pub def toOption(_: Region[r], o: Optional[a, r]): Option[a] \ Read(r) with Marshal[a] =
        import java.util.Optional.isPresent(): Bool & r;
        import java.util.Optional.get(): ##java.lang.Object & r;
        let Optional(o1) = o;
        if (isPresent(o1))
            get(o1) |> Interop/Flix/Marshal.fromJavaObject |> Some
        else 
            None
    
    pub def fromOption(_: Region[r], o: Option[a]): Optional[a, r] \ Write(r) with Marshal[a] =
        import static java.util.Optional.empty(): ##java.util.Optional & r;
        import static java.util.Optional.of(##java.lang.Object): ##java.util.Optional & r;
        match o { 
            case None    => empty() |> Optional
            case Some(a) => Interop/Flix/Marshal.toJavaObject(a) |> of |> Optional
        }

}
