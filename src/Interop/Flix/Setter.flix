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


    /// A `Setter` with error reporting.
    pub enum Setter[t: Type, r: Region](t -> Result[String, Unit] \ Write(r))

}

namespace Interop/Flix/Setter {

    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter


    pub def apply[r: Region, t:Type](_: Region[r], f: Setter[t, r], o: t): Result[String, t] \ Write(r) = 
        let Setter(f1) = f;
        match f1(o) { 
            case Ok()   => Ok(o)
            case Err(s) => Err(s)
        }

    /// 
    pub def lift(f: t -> Unit \ Write(r)): Setter[t, r] =
        Setter(o -> 
            Interop/Flix/Util.try(_ -> f(o))            
        )

    pub def empty(): Setter[t, r] =
        Setter(_ -> unsafe_cast Ok() as _ \ r)


    pub def combine(a: Setter[t, r], b: Setter[t, r]): Setter[t, r] =
        Setter(o -> 
            let Setter(f1) = a;
            let Setter(f2) = b;
            match f1(o) { 
                case Ok()     => f2(o)
                case Err(msg) => Err(msg)
            }
            
        )

    pub def makeSetter(_: Region[r], f: prop -> Setter[t, r], xs: List[prop]): Setter[t, r] = 
        List.foldLeft((ac, prop) -> combine(ac, f(prop)), empty(), xs)

    pub def castSetter[r: Region, t:Type, t1: Type](f: t1 -> t, setter: Setter[t, r]): Setter[t1, r] = 
        Setter(o -> 
            let Setter(f1) = setter;
            f1(f(o))
        )

}
