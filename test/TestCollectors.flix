

mod TestCollectors {


    @test
    def counting01(): Unit \ IO = region rc {
        let arr = Array#{"Hello", "world", "!"} @ rc;
        let strm = Interop.Util.Stream.Stream.ofArray(rc, arr);
        let n = Interop.Util.Stream.Stream.collect(Interop.Flix.ComesFromJava.int64FromJavaObject, Interop.Util.Stream.Collectors.counting(), strm);
        println("counting01 (should be 3): ${n}")
    }

    @test
    def joining01(): Unit \ IO = region rc {
        let arr = Array#{"Hello", "world", "!"} @ rc;
        let strm = Interop.Util.Stream.Stream.ofArray(rc, arr);
        let s = Interop.Util.Stream.Stream.collect(Interop.Flix.ComesFromJava.stringFromJavaObject, Interop.Util.Stream.Collectors.joining(), strm);
        println("joining01: ${s}")
    }

    // @test
    // def joiningWithDelimiter01(): Unit \ IO = region rc {
    //     let arr = Array#{"Hello", "world", "!"} @ rc;
    //     let strm = Interop.Util.Stream.Stream.ofArray(rc, arr);
    //     let s = Interop.Util.Stream.Stream.collect(Interop.Util.Stream.Collectors.joiningWithDelimiter("__"), strm);
    //     println("joiningWithDelimiter01: ${s}")
    // }

    // @test
    // def averagingDouble01(): Unit \ IO = region rc {
    //     let arr = Array#{1, 2, 3, 4, 5, 6} @ rc;
    //     let strm = Interop.Util.Stream.Stream.ofArray(rc, arr);
    //     let ave = Interop.Util.Stream.Stream.collect(Interop.Util.Stream.Collectors.averagingDouble(Int32.toFloat64), strm);
    //     println("averagingDouble01: ${ave}")
    // }

    // @test
    // def toSet01(): Unit \ IO = region rc {
    //     let arr = Array#{1, 2, 3, 4, 5, 6} @ rc;
    //     let strm = Interop.Util.Stream.Stream.ofArray(rc, arr);
    //     let set1: Set[Int32] = Interop.Util.Stream.Stream.collectWith(Interop.Util.Stream.Collectors.toSet(), strm, obj -> unchecked_cast(obj as Set[Int32]));
    //     println("toSet01: ${set1}")
    // }

}
