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

    /// Should Setter include `ef` type param? - (ideally) no.
    /// Can we mange if the only effect is mutation? (ideally) yes.
    /// If we need other effects we won't be able to store Setters
    /// in a list as we will need something like Graded.flatMap to
    /// sequence and lift effect types to the same thing.`

    pub enum Setter[t: Type, r: Region](t -> Unit \ Write(r))

}

namespace Interop/Flix/Setter {

    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter


    pub def apply[r: Region, t:Type](_: Region[r], setter: Setter[t, r], o: t): t \ Write(r) = 
        let Setter(f1) = setter;
        f1(o);
        o

    pub def empty(): Setter[t, r] =
        Setter(_ -> unsafe_cast () as _ \ r)


    pub def combine(a: Setter[t, r], b: Setter[t, r]): Setter[t, r] =
        Setter(o -> 
            let Setter(f1) = a;
            let Setter(f2) = b;
            f1(o);
            f2(o)
        )

    pub def makeSetter(_: Region[r], f: prop -> Setter[t, r], xs: List[prop]): Setter[t, r] = 
        List.foldLeft((ac, prop) -> combine(ac, f(prop)), empty(), xs)

    pub def castSetter[r: Region, t:Type, t1: Type](f: t1 -> t, setter: Setter[t, r]): Setter[t1, r] = 
        Setter(o -> 
            let Setter(f1) = setter;
            f1(f(o))
        )

}
