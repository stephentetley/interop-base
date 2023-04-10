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
    /// Represents a Java OptionalDouble.
    /// Immutable 
    pub enum OptionalDouble(##java.util.OptionalDouble)


}


mod Interop.Util.OptionalDouble {
    
    use Interop.Util.OptionalDouble;
    use Interop.Util.OptionalDouble.{OptionalDouble};
    use Interop.Flix.Marshal;

    pub def getHH(o: OptionalDouble): ##java.util.OptionalDouble = 
        let OptionalDouble(o1) = o;
        o1

    pub def hhToOption(o: ##java.util.OptionalDouble): Option[Float64] = 
        OptionalDouble(o) |> toOption

    pub def toOption(o: OptionalDouble): Option[Float64] =
        getAsDouble(o) |> Result.toOption
    
    pub def fromOption(o: Option[Float64]): OptionalDouble =
        match o { 
            case None    => empty()
            case Some(d) => of(d)
        }


    pub def empty(): OptionalDouble =
        import static java.util.OptionalDouble.empty(): ##java.util.OptionalDouble \ {};
        empty() |> OptionalDouble

    pub def of(d: Float64): OptionalDouble =
        import static java.util.OptionalDouble.of(Float64): ##java.util.OptionalDouble \ {};
        of(d) |> OptionalDouble

    pub def getAsDouble(o: OptionalDouble): Result[String, Float64] = 
        Result.tryCatch(_ -> {
            import java.util.OptionalDouble.getAsDouble(): Float64 \ {};
            let OptionalDouble(o1) = o;
            getAsDouble(o1)
        })



}
