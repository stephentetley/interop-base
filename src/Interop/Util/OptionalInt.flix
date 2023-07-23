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
    /// Represents a Java OptionalInt.
    /// Immutable 
    pub enum OptionalInt(##java.util.OptionalInt)


}


mod Interop.Util.OptionalInt {
    
    use Interop.Util.OptionalInt
    use Interop.Util.OptionalInt.{OptionalInt}

    pub def getHH(o: OptionalInt): ##java.util.OptionalInt = 
        let OptionalInt(o1) = o;
        o1

    pub def fromJavaObject(o: ##java.lang.Object): OptionalInt = 
        OptionalInt(unchecked_cast(o as ##java.util.OptionalInt))


    pub def hhToOption(o: ##java.util.OptionalInt): Option[Int32] = 
        OptionalInt(o) |> toOption

    pub def toOption(o: OptionalInt): Option[Int32] =
        getAsInt(o) |> Result.toOption
    
    pub def fromOption(o: Option[Int32]): OptionalInt =
        match o { 
            case None    => empty()
            case Some(i) => of(i)
        }


    pub def empty(): OptionalInt =
        import static java.util.OptionalInt.empty(): ##java.util.OptionalInt \ {};
        empty() |> OptionalInt

    pub def of(i: Int32): OptionalInt =
        import static java.util.OptionalInt.of(Int32): ##java.util.OptionalInt \ {};
        of(i) |> OptionalInt

    pub def getAsInt(o: OptionalInt): Result[String, Int32] = 
        Result.tryCatch(_ -> {
            import java.util.OptionalInt.getAsInt(): Int32 \ {};
            let OptionalInt(o1) = o;
            getAsInt(o1)
        })


    pub def isPresent(o: OptionalInt): Bool = 
        import java.util.OptionalInt.isPresent(): Bool \ {};
        let OptionalInt(o1) = o;
        isPresent(o1)
        
}
