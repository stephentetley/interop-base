/*
 * Copyright 2023 Stephen Tetley
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


mod Interop.Util.Stream.Collectors {
    
    use Interop.Util.Stream.Collector
    use Interop.Util.Stream.Collector.{Collector}

    pub def counting(): Collector[a, t, Int64] = 
        import static java.util.stream.Collectors.counting(): ##java.util.stream.Collector \ {};
        Collector(counting())


    pub def joining(): Collector[String, t, String] = 
        import static java.util.stream.Collectors.joining(): ##java.util.stream.Collector \ {};
        Collector(joining())

    pub def joiningWithDelimiter(delim: String): Collector[String, t, String] = 
        import static java.util.stream.Collectors.joining(##java.lang.CharSequence): ##java.util.stream.Collector \ {};
        let cs = checked_cast(delim);
        Collector(joining(cs))

}
