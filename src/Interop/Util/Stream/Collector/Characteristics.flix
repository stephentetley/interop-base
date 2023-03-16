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

namespace Interop/Util/Stream/Collector {
    
    use Interop/Util/Stream/Collector.Characteristics
    use Interop/Util/Stream/Collector.Characteristics.{Characteristics}
    use Interop/Lang.Enum
    use Interop/Lang.Enum.{Enum}
    use Interop/Lang.SubEnum

    ///
    /// Represents a Java Stream.Characteristics.
    ///
    /// Enum
    ///
    pub enum Characteristics(##java.util.stream.Collector$Characteristics)

    instance Interop/Flix.Marshal[Characteristics] {
        pub def toJavaObject(x: Characteristics): ##java.lang.Object =
            let Characteristics(x1) = x;
            checked_cast(x1)

        pub def fromJavaObject(o: ##java.lang.Object): Characteristics = 
            Characteristics(unchecked_cast(o as ##java.util.stream.Collector$Characteristics))
    }

    instance SubEnum[Characteristics] {
        pub def toEnum(x: Characteristics): Enum = 
            let Characteristics(x1) = x;
            Enum(unchecked_cast(x1 as ##java.lang.Enum))

        pub def fromEnum(x: Enum): Characteristics = 
            let Enum(x1) = x;
            Characteristics(unchecked_cast(x1 as ##java.util.stream.Collector$Characteristics))
    }
}


namespace Interop/Util/Stream/Collector/Characteristics {
    
    use Interop/Util/Stream/Collector.Characteristics
    use Interop/Util/Stream/Collector.Characteristics.{Characteristics}


    pub def concurrent(): Characteristics = 
        import static get java.util.stream.Collector$Characteristics.CONCURRENT: ##java.util.stream.Collector$Characteristics \ {} as get_CONCURRENT;
        get_CONCURRENT() |> Characteristics


    pub def identity_finish(): Characteristics = 
        import static get java.util.stream.Collector$Characteristics.IDENTITY_FINISH: ##java.util.stream.Collector$Characteristics \ {} as get_IDENTITY_FINISH;
        get_IDENTITY_FINISH() |> Characteristics

    pub def unordered(): Characteristics = 
        import static get java.util.stream.Collector$Characteristics.UNORDERED: ##java.util.stream.Collector$Characteristics \ {} as get_UNORDERED;
        get_UNORDERED() |> Characteristics        
}
