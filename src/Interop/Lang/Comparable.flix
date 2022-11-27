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

    /// Interface...
    /// Probably not useful in practice


    pub enum Comparable(##java.lang.Comparable)

    pub class ImpComparable[t: Type] {
        pub def toComparable(s: t): Comparable
        pub def fromComparable(s: Comparable): t
    }


}

namespace Interop/Lang/Comparable {
    
    use Interop/Lang.Comparable
    use Interop/Lang.Comparable.{Comparable}


    pub def getHH(c: Comparable): ##java.lang.Comparable = 
        let Comparable(c1) = c;
        c1


    pub def compareTo(c1: Comparable, c2: Comparable): Int32 = 
        import java.lang.Comparable.compareTo(##java.lang.Object): Int32 \ {};
        let Comparable(jc1) = c1;
        let Comparable(jc2) = c2;
        compareTo(jc1, jc2 as ##java.lang.Object)

}
