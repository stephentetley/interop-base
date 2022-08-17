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
namespace Interop/Math {

    use Interop/Lang.Enum;
    use Interop/Lang.Enum.{Enum};
    use Interop/Lang.SubEnum;

    // Design note - Basis libraries should define enums so that constructors
    // are in the Basis namespace.

    pub enum RoundingMode(##java.math.RoundingMode)

    instance SubEnum[RoundingMode] {
        pub def toEnum(x: RoundingMode): Enum[a] = 
            let RoundingMode(x1) = x;
            Enum(x1 as ##java.lang.Enum)

        pub def fromEnum(x: Enum[a]): RoundingMode = 
            let Enum(x1) = x;
            RoundingMode(x1 as ##java.math.RoundingMode) 
    }

}

namespace Interop/Math/RoundingMode {

    use Interop/Math.RoundingMode;
    use Interop/Math.RoundingMode.{RoundingMode};

    pub def getHH(x: RoundingMode): ##java.math.RoundingMode = 
        let RoundingMode(x1) = x;
        x1

    pub def ceiling(): RoundingMode = 
        import static get java.math.RoundingMode.CEILING: ##java.math.RoundingMode \ {} as get_CEILING;
        get_CEILING() |> RoundingMode

    pub def down(): RoundingMode = 
        import static get java.math.RoundingMode.DOWN: ##java.math.RoundingMode \ {} as get_DOWN;
        get_DOWN() |> RoundingMode

    pub def floor(): RoundingMode = 
        import static get java.math.RoundingMode.FLOOR: ##java.math.RoundingMode \ {} as get_FLOOR;
        get_FLOOR() |> RoundingMode

    pub def half_down(): RoundingMode = 
        import static get java.math.RoundingMode.HALF_DOWN: ##java.math.RoundingMode \ {} as get_HALF_DOWN;
        get_HALF_DOWN() |> RoundingMode

    pub def half_even(): RoundingMode = 
        import static get java.math.RoundingMode.HALF_EVEN: ##java.math.RoundingMode \ {} as get_HALF_EVEN;
        get_HALF_EVEN() |> RoundingMode

    pub def half_up(): RoundingMode = 
        import static get java.math.RoundingMode.HALF_UP: ##java.math.RoundingMode \ {} as get_HALF_UP;
        get_HALF_UP() |> RoundingMode

    pub def unnecessary(): RoundingMode = 
        import static get java.math.RoundingMode.UNNECESSARY: ##java.math.RoundingMode \ {} as get_UNNECESSARY;
        get_UNNECESSARY() |> RoundingMode

    pub def up(): RoundingMode = 
        import static get java.math.RoundingMode.UP: ##java.math.RoundingMode \ {} as get_UP;
        get_UP() |> RoundingMode

}
