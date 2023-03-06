/*
 * Copyright 2023 Stephen Tetley
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

namespace Interop/Flix {


    /// Version of `Setter` with error reporting.
    pub enum ResultSetter[t: Type, r: Region](t -> Result[String, Unit] \ Write(r))

}

namespace Interop/Flix/ResultSetter {

    use Interop/Flix.ResultSetter
    use Interop/Flix.ResultSetter.ResultSetter


    pub def apply[r: Region, t:Type](_: Region[r], f: ResultSetter[t, r], o: t): Result[String, t] \ Write(r) = 
        let ResultSetter(f1) = f;
        match f1(o) { 
            case Ok()   => Ok(o)
            case Err(s) => Err(s)
        }

    /// 
    pub def lift(f: t -> Unit \ Write(r)): ResultSetter[t, r] =
        ResultSetter(o -> 
            try {
                Ok(f(o))
            } catch {
                case e: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(e))
            }
        )

    pub def empty(): ResultSetter[t, r] =
        ResultSetter(_ -> unsafe_cast Ok() as _ \ r)


    pub def combine(a: ResultSetter[t, r], b: ResultSetter[t, r]): ResultSetter[t, r] =
        ResultSetter(o -> 
            let ResultSetter(f1) = a;
            let ResultSetter(f2) = b;
            match f1(o) { 
                case Ok()     => f2(o)
                case Err(msg) => Err(msg)
            }
            
        )

    pub def makeResultSetter(_: Region[r], f: prop -> ResultSetter[t, r], xs: List[prop]): ResultSetter[t, r] = 
        List.foldLeft((ac, prop) -> combine(ac, f(prop)), empty(), xs)

    pub def castSetter[r: Region, t:Type, t1: Type](f: t1 -> t, setter: ResultSetter[t, r]): ResultSetter[t1, r] = 
        ResultSetter(o -> 
            let ResultSetter(f1) = setter;
            f1(f(o))
        )

}
