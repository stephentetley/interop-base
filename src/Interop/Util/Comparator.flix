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
    /// Represents a Java Comparator.
    ///
    /// Functional interface
    ///
    /// TODO should comparator have an effect type param? Probably then it can handle comparing mutable objects
    pub enum Comparator[_: Type, _: Eff](##java.util.Comparator)


}


mod Interop.Util.Comparator {
    
    use Interop.Util.Comparator
    use Interop.Util.Comparator.{Comparator}


    pub def makeComparator(fromJava: ##java.lang.Object -> a, f: (a, a) -> Int32 \ ef): Comparator[a, ef] = 
        let f1 = (o1, o2) -> {
            let a = fromJava(o1); 
            let b = fromJava(o2); 
            f(a, b)
        };
        Comparator(unchecked_cast((new ##java.util.Comparator {
            def compare(_this: ##java.util.Comparator, t: ##java.lang.Object, u: ##java.lang.Object): Int32 = 
                f1(t, u)
        }) as _ \ {}))

    pub def naturalOrder(): Comparator[a, Pure] = 
        import static java.util.Comparator.naturalOrder(): ##java.util.Comparator \ {}; 
        Comparator(naturalOrder())

    
    pub def reverseOrder(): Comparator[a, Pure] = 
        import static java.util.Comparator.reverseOrder(): ##java.util.Comparator \ {}; 
        Comparator(reverseOrder())


}
