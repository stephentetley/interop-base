

namespace TestIntStream {


    @test
    def flatMap01(): Bool \ IO = 
        /// for every i gen 3...
        let f1 = i -> Interop/Util/Stream/IntStream.range(Static, i, i+3);
        let stream0 = Interop/Util/Stream/IntStream.range(Static, 0, 2);
        let stream1 = Interop/Util/Stream/IntStream.flatMap(f1, stream0);
        let ct = Interop/Util/Stream/IntStream.count(stream1);
        ct == 6i64


    @test
    def flatMap02(): Bool \ IO = 
        /// for every i gen 3...
        let f1 = i -> Interop/Util/Stream/IntStream.range(Static, i, i+3);
        let stream0 = Interop/Util/Stream/IntStream.range(Static, 0, 2);
        let stream1 = Interop/Util/Stream/IntStream.flatMap(f1, stream0);
        let arr = Interop/Util/Stream/IntStream.toArray(stream1);
        Array.compare(arr, [0, 1, 2, 1, 2, 3]) == EqualTo

}