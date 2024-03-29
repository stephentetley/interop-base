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

// No wrapped type.

mod Interop.Lang.StringZ {

    use Charset.{Charset}
    use Interop.Util.Stream.IntStream
    use Interop.Util.Stream.IntStream.{IntStream}


    pub def fromJavaObject(o: ##java.lang.Object): String = 
        unchecked_cast(o as ##java.lang.String)


    pub def fromArray(arr: Array[Int8, r]): String \ r = 
        import java_new java.lang.String(Array[Int8, r]): String \ r as newString;
        newString(arr)

    pub def fromSubarray(offset: {offset = Int32}, len: {len = Int32}, arr: Array[Int8, r]): Result[String, String] \ r = 
        Result.tryCatch(_ -> {
            import java_new java.lang.String(Array[Int8, r], Int32, Int32): String \ r as newString;
            newString(arr, offset.offset, len.len)
        })

    pub def fromSubarrayWithCharsetName(offset: {offset = Int32}, len: {len = Int32}, charsetName: String, arr: Array[Int8, r]): Result[String, String] \ r = 
        Result.tryCatch(_ -> {
            import java_new java.lang.String(Array[Int8, r], Int32, Int32, String): String \ r as newString;
            newString(arr, offset.offset, len.len, charsetName)
        })

    pub def fromSubarrayWithCharset(offset: {offset = Int32}, len: {len = Int32}, cs: Charset, arr: Array[Int8, r]): Result[String, String] \ r = 
        Result.tryCatch(_ -> {
            import java_new java.lang.String(Array[Int8, r], Int32, Int32, ##java.nio.charset.Charset): String \ r as newString;
            let Charset(cs1) = cs;
            newString(arr, offset.offset, len.len, cs1)
        })


    pub def fromArrayWithCharsetName(charsetName: String, arr: Array[Int8, r]): Result[String, String] \ r = 
        Result.tryCatch(_ -> {
            import java_new java.lang.String(Array[Int8, r], String): String \ r as newString;
            newString(arr, charsetName)
        })

    pub def fromArrayWithCharset(cs: Charset, arr: Array[Int8, r]): String \ r = 
        import java_new java.lang.String(Array[Int8, r], ##java.nio.charset.Charset): String \ r as newString;
        let Charset(cs1) = cs;
        newString(arr, cs1)

    pub def fromCharArray(arr: Array[Char, r]): String \ r = 
        import java_new java.lang.String(Array[Char, r]): String \ r as newString;
        newString(arr)

    pub def fromCharSubarray(offset: {offset = Int32}, len: {len = Int32}, arr: Array[Char, r]): Result[String, String] \ r =
        Result.tryCatch(_ -> {
            import java_new java.lang.String(Array[Char, r], Int32, Int32): String \ r as newString;
            newString(arr, offset.offset, len.len)
        })

    pub def fromCodePointSubarray(offset: {offset = Int32}, len: {len = Int32}, arr: Array[Int32, r]): Result[String, String] \ r = 
        Result.tryCatch(_ -> {
            import java_new java.lang.String(Array[Int32, r], Int32, Int32): String \ r as newString;
            newString(arr, offset.offset, len.len)
        })

    pub def chars(rc: Region[r], s: String): IntStream[ef, r] \ r = 
        import java.lang.String.chars(): ##java.util.stream.IntStream \ r ;
        IntStream(rc, chars(s))

    pub def codePoints(rc: Region[r], s: String): IntStream[ef, r] \ r = 
        import java.lang.String.codePoints(): ##java.util.stream.IntStream \ r ;
        IntStream(rc, codePoints(s))


    pub def getBytes(_: Region[r], s: String): Array[Int8, r] \ r = 
        import java.lang.String.getBytes(): Array[Int8, r] \ r ;
        getBytes(s)

    pub def getBytesWithCharset(_: Region[r], cs: Charset, s: String): Array[Int8, r] \ r = 
        import java.lang.String.getBytes(##java.nio.charset.Charset): Array[Int8, r] \ r ;
        let Charset(cs1) = cs;
        getBytes(s, cs1)


}
