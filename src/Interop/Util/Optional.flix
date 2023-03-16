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
    /// Immutable 
    ///
    /// TODO - remove type param?
    ///
    pub enum Optional[_a: Type](##java.util.Optional)


}


namespace Interop/Util/Optional {
    
    use Interop/Util.Optional;
    use Interop/Util.Optional.{Optional};
    use Interop/Flix.Marshal;

    pub def getHH(o: Optional[a]): ##java.util.Optional = 
        let Optional(o1) = o;
        o1

    /// cast must be Pure
    pub def hhToOption(ocast: ##java.lang.Object -> a, o: ##java.util.Optional): Option[a] = 
        import java.util.Optional.isPresent(): Bool & Pure;
        import java.util.Optional.get(): ##java.lang.Object & Pure;
        if (isPresent(o))
            get(o) |> ocast |> Some
        else 
            None


    pub def toOption(o: Optional[a]): Option[a] with Marshal[a] =
        let Optional(o1) = o;
        o1 |> hhToOption(Interop/Flix/Marshal.fromJavaObject)
    
    pub def fromOption(o: Option[a]): Optional[a] with Marshal[a] =
        import static java.util.Optional.empty(): ##java.util.Optional & Pure;
        import static java.util.Optional.of(##java.lang.Object): ##java.util.Optional & Pure;
        match o { 
            case None    => empty() |> Optional
            case Some(a) => Interop/Flix/Marshal.toJavaObject(a) |> of |> Optional
        }

}
