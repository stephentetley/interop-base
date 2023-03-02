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


    pub def apply[r: Region, t:Type](_: Region[r], fs: List[Setter[t, r]], o: t): t \ Write(r) = 
        List.forEach(f -> {
            let Setter(f1) = f;
            f1(o)
        }, fs);
        o
    
}
