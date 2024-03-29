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

mod Interop.Math {

    use Interop.Math.RoundingMode
    use Interop.Math.RoundingMode.{RoundingMode}
    use Interop.Lang.Enum
    use Interop.Lang.Enum.{Enum}
    use Interop.Lang.SubEnum

    pub enum RoundingMode(##java.math.RoundingMode)

    instance SubEnum[RoundingMode] {
        pub def toEnum(x: RoundingMode): Enum = 
            let RoundingMode(x1) = x;
            Enum(unchecked_cast(x1 as ##java.lang.Enum))

        pub def fromEnum(x: Enum): RoundingMode = 
            let Enum(x1) = x;
            RoundingMode(unchecked_cast(x1 as ##java.math.RoundingMode))
    }

}

mod Interop.Math.RoundingMode {

    use Interop.Math.RoundingMode
    use Interop.Math.RoundingMode.{RoundingMode}

    pub def getHH(x: RoundingMode): ##java.math.RoundingMode = 
        let RoundingMode(x1) = x;
        x1

    pub def toString(t: RoundingMode): String = 
        import java.math.RoundingMode.toString(): String \ {};
        let RoundingMode(t1) = t;
        toString(t1)


    pub def equals(x: RoundingMode, y: RoundingMode): Bool =
        import java.math.RoundingMode.equals(##java.lang.Object): Bool \ {};
        let RoundingMode(x1) = x;
        let RoundingMode(y1) = y;
        equals(x1, checked_cast(y1))

    pub def ceiling(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.CEILING: ##java.math.RoundingMode \ {} as get_CEILING;
        get_CEILING() |> RoundingMode

    pub def down(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.DOWN: ##java.math.RoundingMode \ {} as get_DOWN;
        get_DOWN() |> RoundingMode

    pub def floor(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.FLOOR: ##java.math.RoundingMode \ {} as get_FLOOR;
        get_FLOOR() |> RoundingMode

    pub def half_down(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.HALF_DOWN: ##java.math.RoundingMode \ {} as get_HALF_DOWN;
        get_HALF_DOWN() |> RoundingMode

    pub def half_even(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.HALF_EVEN: ##java.math.RoundingMode \ {} as get_HALF_EVEN;
        get_HALF_EVEN() |> RoundingMode

    pub def half_up(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.HALF_UP: ##java.math.RoundingMode \ {} as get_HALF_UP;
        get_HALF_UP() |> RoundingMode

    pub def unnecessary(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.UNNECESSARY: ##java.math.RoundingMode \ {} as get_UNNECESSARY;
        get_UNNECESSARY() |> RoundingMode

    pub def up(): RoundingMode = 
        import static java_get_field java.math.RoundingMode.UP: ##java.math.RoundingMode \ {} as get_UP;
        get_UP() |> RoundingMode

}
