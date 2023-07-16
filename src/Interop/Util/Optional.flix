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

mod Interop.Util {

    ///
    /// Represents a Java Optional.
    /// Immutable 
    ///
    pub enum Optional[_a: Type](##java.util.Optional)


}


mod Interop.Util.Optional {
    
    use Interop.Util.Optional
    use Interop.Util.Optional.{Optional}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava

    pub def getHH(o: Optional[a]): ##java.util.Optional = 
        let Optional(o1) = o;
        o1

    pub def wrapHH(prim: ##java.util.Optional): Optional[a] = 
        Optional(prim)

    /// cast must be Pure
    pub def hhToOption(ocast: ##java.lang.Object -> a, o: ##java.util.Optional): Option[a] = 
        import java.util.Optional.isPresent(): Bool \ {};
        import java.util.Optional.get(): ##java.lang.Object \ {};
        if (isPresent(o))
            get(o) |> ocast |> Some
        else 
            None


    pub def toString(o: Optional[a]): String  =
        import java.util.Optional.toString(): String \ {};
        let Optional(o1) = o;
        toString(o1)

        

    pub def toOption(o: Optional[a]): Option[a] with ComesFromJava[a] =
        let Optional(o1) = o;
        o1 |> hhToOption(Interop.Flix.ComesFromJava.fromJavaObject)
    
    pub def fromOption(o: Option[a]): Optional[a] with GoesToJava[a] =
        import static java.util.Optional.empty(): ##java.util.Optional \ {};
        import static java.util.Optional.of(##java.lang.Object): ##java.util.Optional \ {};
        match o { 
            case None    => empty() |> Optional
            case Some(a) => Interop.Flix.GoesToJava.toJavaObject(a) |> of |> Optional
        }
    
    pub def fromOption1(o: Option[a]): Optional[a] with GoesToJava[a] =
        import static java.util.Optional.empty(): ##java.util.Optional \ {};
        import static java.util.Optional.of(##java.lang.Object): ##java.util.Optional \ {};
        match o { 
            case None    => empty() |> Optional
            case Some(a) => Interop.Flix.GoesToJava.toJavaObject(a) |> of |> Optional
        }
}
