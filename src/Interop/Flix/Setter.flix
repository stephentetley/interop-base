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

    pub enum Setter[t: Type, r: Region](t -> Unit \ Write(r))

}

namespace Interop/Flix/Setter {

    use Interop/Flix.Setter
    use Interop/Flix.Setter.Setter

    pub def andThen(f: Setter[t, r], g: Setter[t, r]): Setter[t, r] = 
        Setter(o -> 
            let Setter(f1) = f;
            let Setter(g1) = g;
            f1(o);
            g1(o)
        )

    pub def apply[r: Region, t:Type](_: Region[r], f: Setter[t, r], o: t): t \ Write(r) = 
        let Setter(f1) = f;
        f1(o);
        o
    
}
