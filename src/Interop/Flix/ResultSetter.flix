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


    pub def apply[r: Region, t:Type](_: Region[r], fs: List[ResultSetter[t, r]], o: t): Result[String, t] \ Write(r) = 
        def loop(ll) = match ll {
            case Nil     => Ok(o)
            case ResultSetter(f) :: rs => match f(o) { 
                case Ok()   => loop(rs)
                case Err(s) => Err(s)
            }
        };
        loop(fs)

    /// Are we happy is the only effect is mutation? 
    pub def try(f: t -> Unit \ Write(r)): ResultSetter[t, r] =
        ResultSetter(o -> 
            try {
                Ok(f(o))
            } catch {
                case e: ##java.lang.Exception =>
                    import java.lang.Throwable.getMessage(): String \ {};
                    Err(getMessage(e))
            }
        )

}
