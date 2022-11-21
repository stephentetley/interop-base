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

namespace Interop/Lang {

    ///
    /// Represents a Java Boolean.
    ///
    pub enum Boolean(##java.lang.Boolean)


}

namespace Interop/Lang/Boolean {


    use Interop/Lang.Boolean
    use Interop/Lang.Boolean.{Boolean}


    pub def toString(x: Boolean): String =
        import java.lang.Boolean.toString(): String \ {};
        let Boolean(x1) = x;
        toString(x1)

    pub def equals(x: Boolean, y: Boolean): Bool =
        import java.lang.Boolean.equals(##java.lang.Object): Bool \ {};
        let Boolean(x1) = x;
        let Boolean(y1) = y;
        equals(x1, y1 as ##java.lang.Object)

    pub def compare(x: Bool, y: Bool): Int32 =
        import static java.lang.Boolean.compare(Bool, Bool): Int32 \ {};
        compare(x, y)

    pub def booleanValue(x: Boolean): Bool =
        import java.lang.Boolean.booleanValue(): Bool \ {};
        let Boolean(x1) = x;
        booleanValue(x1)

    pub def hashCode(x: Boolean): Int32 =
        import java.lang.Boolean.hashCode(): Int32 \ {};
        let Boolean(x1) = x;
        hashCode(x1)

    pub def valueOf(x: Bool): Boolean =
        import static java.lang.Boolean.valueOf(Bool): ##java.lang.Boolean \ {};
        valueOf(x) |> Boolean

    pub def logicalAnd(x: Bool, y: Bool): Bool =
        import static java.lang.Boolean.logicalAnd(Bool, Bool): Bool \ {};
        logicalAnd(x, y)

    pub def logicalOr(x: Bool, y: Bool): Bool =
        import static java.lang.Boolean.logicalOr(Bool, Bool): Bool \ {};
        logicalOr(x, y)

    pub def logicalXor(x: Bool, y: Bool): Bool =
        import static java.lang.Boolean.logicalXor(Bool, Bool): Bool \ {};
        logicalXor(x, y)

}
