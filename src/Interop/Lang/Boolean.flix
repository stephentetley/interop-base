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

mod Interop.Lang {

    use Interop.Lang.Boolean
    use Interop.Lang.Boolean.{Boolean}

    ///
    /// Represents a Java Boolean.
    ///
    pub enum Boolean(##java.lang.Boolean)


    instance Interop.Flix.ComesFromJava[Boolean] {
        pub def fromJavaObject(o: ##java.lang.Object): Boolean = 
            Boolean(unchecked_cast(o as ##java.lang.Boolean))
    }

    instance Interop.Flix.GoesToJava[Boolean] {
        pub def toJavaObject(x: Boolean): ##java.lang.Object = 
            let Boolean(x1) = x;
            checked_cast(x1)
    }

}

mod Interop.Lang.Boolean {


    use Interop.Lang.Boolean
    use Interop.Lang.Boolean.{Boolean}

    pub def getHH(b: Boolean): ##java.lang.Boolean = 
        let Boolean(b1) = b;
        b1

    pub def wrapHH(prim: ##java.lang.Boolean): Boolean = 
        Boolean(prim)


    pub def toString(x: Boolean): String =
        import java.lang.Boolean.toString(): String \ {};
        let Boolean(x1) = x;
        toString(x1)

    pub def equals(x: Boolean, y: Boolean): Bool =
        import java.lang.Boolean.equals(##java.lang.Object): Bool \ {};
        let Boolean(x1) = x;
        let Boolean(y1) = y;
        equals(x1, checked_cast(y1))

    pub def compare(x: Bool, y: Bool): Int32 =
        import static java.lang.Boolean.compare(Bool, Bool): Int32 \ {};
        compare(x, y)

    pub def truez(): Boolean = 
        import static get java.lang.Boolean.TRUE: ##java.lang.Boolean \ {} as get_TRUE;
        get_TRUE() |> Boolean

    pub def falsez(): Boolean = 
        import static get java.lang.Boolean.FALSE: ##java.lang.Boolean \ {} as get_FALSE;
        get_FALSE() |> Boolean

    pub def parseBoolean(s: String): Bool = 
        import static java.lang.Boolean.parseBoolean(String): Bool \ {};
        parseBoolean(s)

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
