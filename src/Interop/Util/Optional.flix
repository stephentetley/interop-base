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

    use Interop.Util.Optional.{Optional} 

    ///
    /// Represents a Java Optional.
    /// Immutable 
    ///
    pub enum Optional[_a: Type](##java.util.Optional)


    instance Interop.Flix.GoesToJava[Optional[a]] with Interop.Flix.GoesToJava[a] {
        pub def toJavaObject(o: Optional[a]): ##java.lang.Object =
            let Optional(o1) = o;
            checked_cast(o1) 
    }

}


mod Interop.Util.Optional {
    
    use Interop.Util.Optional
    use Interop.Util.Optional.{Optional}
    use Interop.Util.Function.ConsumerZ
    use Interop.Util.Function.ConsumerZ.{ConsumerZ}
    use Interop.Util.Function.FunctionZ
    use Interop.Util.Function.FunctionZ.{FunctionZ}
    use Interop.Util.Function.PredicateZ
    use Interop.Util.Function.PredicateZ.{PredicateZ}
    use Interop.Flix.ComesFromJava
    use Interop.Flix.GoesToJava

    pub def getHH(o: Optional[a]): ##java.util.Optional = 
        let Optional(o1) = o;
        o1

    pub def wrapHH(prim: ##java.util.Optional): Optional[a] = 
        Optional(prim)

    pub def fromJavaObject(o: ##java.lang.Object): Optional[a] = 
        Optional(unchecked_cast(o as ##java.util.Optional))


    /// cast must be Pure
    pub def hhToOption(fromObject: ##java.lang.Object -> a, o: ##java.util.Optional): Option[a] = 
        import java.util.Optional.isPresent(): Bool \ {};
        import java.util.Optional.get(): ##java.lang.Object \ {};
        if (isPresent(o))
            get(o) |> fromObject |> Some
        else 
            None


    pub def toString(o: Optional[a]): String  =
        import java.util.Optional.toString(): String \ {};
        let Optional(o1) = o;
        toString(o1)

    pub def equals(x: Optional[a], y: Optional[a]): Bool =
        import java.util.Optional.equals(##java.lang.Object): Bool \ {};
        let Optional(x1) = x;
        let Optional(y1) = y;
        equals(x1, checked_cast(y1))

    pub def empty(): Optional[a] =
        import static java.util.Optional.empty(): ##java.util.Optional \ {};
        Optional(empty())

    pub def of(x: a): Optional[a] with GoesToJava[a] =
        import static java.util.Optional.of(##java.lang.Object): ##java.util.Optional \ {};
        Optional(of(Interop.Flix.GoesToJava.toJavaObject(x)))

    pub def ofNullable(x: a): Optional[a] with GoesToJava[a] =
        import static java.util.Optional.ofNullable(##java.lang.Object): ##java.util.Optional \ {};
        Optional(ofNullable(Interop.Flix.GoesToJava.toJavaObject(x)))


    pub def isPresent(x: Optional[a]): Bool =
        import java.util.Optional.isPresent(): Bool \ {};
        let Optional(x1) = x;
        isPresent(x1)


    pub def map(f: FunctionZ[a, b, ef], x: Optional[a]): Optional[b] \ ef =
        import java.util.Optional.map(##java.util.function.Function): ##java.util.Optional \ ef;
        let Optional(x1) = x;
        let FunctionZ(f1) = f;
        Optional(map(x1, f1))

    pub def flatMap(f: FunctionZ[a, Optional[b], ef], x: Optional[a]): Optional[b] \ ef =
        import java.util.Optional.flatMap(##java.util.function.Function): ##java.util.Optional \ ef;
        let Optional(x1) = x;
        let FunctionZ(f1) = f;
        Optional(flatMap(x1, f1))

    pub def ifPresent(f: ConsumerZ[a, ef], x: Optional[a]): Unit \ ef =
        import java.util.Optional.ifPresent(##java.util.function.Consumer): Unit \ ef;
        let Optional(x1) = x;
        let ConsumerZ(f1) = f;
        ifPresent(x1, f1)

    pub def filter(f: PredicateZ[a, ef], x: Optional[a]): Optional[a] \ ef =
        import java.util.Optional.filter(##java.util.function.Predicate): ##java.util.Optional \ ef;
        let Optional(x1) = x;
        let PredicateZ(f1) = f;
        Optional(filter(x1, f1))

    pub def toOption(fromObject: ##java.lang.Object -> a, o: Optional[a]): Option[a] =
        let Optional(o1) = o;
        o1 |> hhToOption(fromObject)
    
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
