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

mod Interop.Flix {


    /// A `Builder` with error reporting.
    pub enum Builder[t: Type, r: Region](t -> Result[String, t] \ Write(r))

}

mod Interop.Flix.Builder {

    use Interop.Flix.Builder
    use Interop.Flix.Builder.Builder


    pub def apply[r: Region, t:Type](_: Region[r], f: Builder[t, r], o: t): Result[String, t] \ Write(r) = 
        let Builder(f1) = f;
        f1(o)

    /// 
    pub def lift(f: t -> t \ Write(r)): Builder[t, r] =
        Builder(o -> 
            Result.tryCatch(_ -> f(o))
        )

    pub def empty(): Builder[t, r] =
        Builder(o -> unchecked_cast(Ok(o) as _ \ r))


    pub def combine(a: Builder[t, r], b: Builder[t, r]): Builder[t, r] =
        Builder(o -> 
            let Builder(f1) = a;
            let Builder(f2) = b;
            match f1(o) { 
                case Ok(o1)   => f2(o1)
                case Err(msg) => Err(msg)
            }
            
        )

    pub def makeBuilder(_: Region[r], f: prop -> Builder[t, r], xs: List[prop]): Builder[t, r] = 
        List.foldLeft((ac, prop) -> combine(ac, f(prop)), empty(), xs)

    pub def castBuilder[r: Region, t:Type, t1: Type](upc: t1 -> t, downc: t -> t1, builder: Builder[t, r]): Builder[t1, r] = 
        Builder(o -> 
            let Builder(f1) = builder;
            f1(upc(o)) |> Result.map(downc)
        )


}
