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
    /// Represents a Java OptionalLong.
    /// Immutable 
    pub enum OptionalLong(##java.util.OptionalLong)


}


mod Interop.Util.OptionalLong {
    
    use Interop.Util.OptionalLong
    use Interop.Util.OptionalLong.{OptionalLong}

    pub def getHH(o: OptionalLong): ##java.util.OptionalLong = 
        let OptionalLong(o1) = o;
        o1

    pub def fromJavaObject(o: ##java.lang.Object): OptionalLong = 
        OptionalLong(unchecked_cast(o as ##java.util.OptionalLong))

    pub def toString(x: OptionalLong): String =
        import java.util.OptionalLong.toString(): String \ {};
        let OptionalLong(x1) = x;
        toString(x1)

    pub def equals(x: OptionalLong, y: OptionalLong): Bool =
        import java.util.OptionalLong.equals(##java.lang.Object): Bool \ {};
        let OptionalLong(x1) = x;
        let OptionalLong(y1) = y;
        equals(x1, checked_cast(y1))


    pub def hhToOption(o: ##java.util.OptionalLong): Option[Int64] = 
        OptionalLong(o) |> toOption

    pub def toOption(o: OptionalLong): Option[Int64] =
        getAsLong(o) |> Result.toOption
    
    pub def fromOption(o: Option[Int64]): OptionalLong =
        match o { 
            case None    => empty()
            case Some(i) => of(i)
        }


    pub def empty(): OptionalLong =
        import static java.util.OptionalLong.empty(): ##java.util.OptionalLong \ {};
        empty() |> OptionalLong

    pub def of(i: Int64): OptionalLong =
        import static java.util.OptionalLong.of(Int64): ##java.util.OptionalLong \ {};
        of(i) |> OptionalLong

    pub def getAsLong(o: OptionalLong): Result[String, Int64] = 
        Result.tryCatch(_ -> {
            import java.util.OptionalLong.getAsLong(): Int64 \ {};
            let OptionalLong(o1) = o;
            getAsLong(o1)
        })


    pub def isPresent(o: OptionalLong): Bool = 
        import java.util.OptionalLong.isPresent(): Bool \ {};
        let OptionalLong(o1) = o;
        isPresent(o1)
        
}
