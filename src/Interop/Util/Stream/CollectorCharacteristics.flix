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

mod Interop.Util.Stream {
    
    use Interop.Util.Stream.CollectorCharacteristics
    use Interop.Util.Stream.CollectorCharacteristics.{CollectorCharacteristics}
    use Interop.Lang.Enum
    use Interop.Lang.Enum.{Enum}
    use Interop.Lang.SubEnum

    ///
    /// Represents a Java Stream.Characteristics.
    ///
    /// Enum
    ///
    pub enum CollectorCharacteristics(##java.util.stream.Collector$Characteristics)


    instance Interop.Flix.GoesToJava[CollectorCharacteristics] {
        pub def toJavaObject(x: CollectorCharacteristics): ##java.lang.Object =
            let CollectorCharacteristics(x1) = x;
            checked_cast(x1)
    }


    instance SubEnum[CollectorCharacteristics] {
        pub def toEnum(x: CollectorCharacteristics): Enum = 
            let CollectorCharacteristics(x1) = x;
            Enum(unchecked_cast(x1 as ##java.lang.Enum))

        pub def fromEnum(x: Enum): CollectorCharacteristics = 
            let Enum(x1) = x;
            CollectorCharacteristics(unchecked_cast(x1 as ##java.util.stream.Collector$Characteristics))
    }
}


mod Interop.Util.Stream.CollectorCharacteristics {
    
    use Interop.Util.Stream.CollectorCharacteristics
    use Interop.Util.Stream.CollectorCharacteristics.{CollectorCharacteristics}


    pub def getHH(x: CollectorCharacteristics): ##java.util.stream.Collector$Characteristics = 
        let CollectorCharacteristics(x1) = x;
        x1

    pub def wrapHH(prim: ##java.util.stream.Collector$Characteristics): CollectorCharacteristics = 
        CollectorCharacteristics(prim)

    pub def fromJavaObject(o: ##java.lang.Object): CollectorCharacteristics = 
        CollectorCharacteristics(unchecked_cast(o as ##java.util.stream.Collector$Characteristics))


    pub def toString(t: CollectorCharacteristics): String = 
        import java.util.stream.Collector$Characteristics.toString(): String \ {};
        let CollectorCharacteristics(t1) = t;
        toString(t1)


    pub def equals(x: CollectorCharacteristics, y: CollectorCharacteristics): Bool =
        import java.util.stream.Collector$Characteristics.equals(##java.lang.Object): Bool \ {};
        let CollectorCharacteristics(x1) = x;
        let CollectorCharacteristics(y1) = y;
        equals(x1, checked_cast(y1))

    pub def hashCode(x: CollectorCharacteristics): Int32 =
        import java.util.stream.Collector$Characteristics.hashCode(): Int32 \ {};
        let CollectorCharacteristics(x1) = x;
        hashCode(x1)

    pub def concurrent(): CollectorCharacteristics = 
        import static get java.util.stream.Collector$Characteristics.CONCURRENT: ##java.util.stream.Collector$Characteristics \ {} as get_CONCURRENT;
        CollectorCharacteristics(get_CONCURRENT())

    pub def identity_finish(): CollectorCharacteristics = 
        import static get java.util.stream.Collector$Characteristics.IDENTITY_FINISH: ##java.util.stream.Collector$Characteristics \ {} as get_IDENTITY_FINISH;
        CollectorCharacteristics(get_IDENTITY_FINISH())

    pub def unordered(): CollectorCharacteristics = 
        import static get java.util.stream.Collector$Characteristics.UNORDERED: ##java.util.stream.Collector$Characteristics \ {} as get_UNORDERED;
        CollectorCharacteristics(get_UNORDERED())

}
