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

namespace Interop/Util {

    ///
    /// Represents a Java Comparator.
    ///
    /// Functional interface
    ///
    pub type alias Comparator[_: Type] = ##java.util.Comparator


}


namespace Interop/Util/Comparator {
    
    use Interop/Util.Comparator;
    use Interop/Flix.Marshal


    pub def makeComparator(f: (a, a) -> Int32 \ ef): Comparator[a] \ ef with Marshal[a] = 
        let f1 = (o1, o2) -> {
            let a = Interop/Flix/Marshal.fromJavaObject(o1); 
            let b = Interop/Flix/Marshal.fromJavaObject(o2); 
            f(a, b)
        };
        new ##java.util.Comparator {
            def compare(_this: ##java.util.Comparator, t: ##java.lang.Object, u: ##java.lang.Object): Int32 = 
                f1(t, u)
        } as \ ef

    pub def naturalOrder(): Comparator[a] = 
        import static java.util.Comparator.naturalOrder(): ##java.util.Comparator \ {}; 
        naturalOrder()

    
    pub def reverseOrder(): Comparator[a] = 
        import static java.util.Comparator.reverseOrder(): ##java.util.Comparator \ {}; 
        reverseOrder()


}
