

namespace TestIntStream {


    @test
    def flatMap01(): Bool \ {} = region rc {
        /// for every i gen 3...
        let f1 = i -> Interop/Util/Stream/IntStream.range(rc, i, i+3);
        let stream0 = Interop/Util/Stream/IntStream.range(rc, 0, 2);
        let stream1 = Interop/Util/Stream/IntStream.flatMap(f1, stream0);
        let ct = Interop/Util/Stream/IntStream.count(stream1);
        ct == 6i64
    }

    @test
    def generate01(): Bool \ {} = region rc {
        let rx = ref 0 @ rc;
        let gen = () -> {
            let x = deref rx;
            rx := x + 1;
            x
        };
        let stream0 = Interop/Util/Stream/IntStream.generate(rc, gen);
        let stream1 = Interop/Util/Stream/IntStream.limit(10i64, stream0);
        let ct = Interop/Util/Stream/IntStream.count(stream1);
        ct == 10i64
    }
/*
    @test
    def flatMap02(): Bool \ IO = 
        /// for every i gen 3...
        let f1 = i -> Interop/Util/Stream/IntStream.range(Static, i, i+3);
        let stream0 = Interop/Util/Stream/IntStream.range(Static, 0, 2);
        let stream1 = Interop/Util/Stream/IntStream.flatMap(f1, stream0);
        let arr = Interop/Util/Stream/IntStream.toArray(stream1);
        Array.compare(arr, Array#{0, 1, 2, 1, 2, 3} @ Static) == EqualTo

    @test
    def sorted01(): Bool \ IO = 
        /// for every i gen 3...
        let f1 = i -> Interop/Util/Stream/IntStream.range(Static, i, i+3);
        let stream0 = Interop/Util/Stream/IntStream.range(Static, 0, 2);
        let stream1 = Interop/Util/Stream/IntStream.flatMap(f1, stream0);
        let arr = stream1 |> Interop/Util/Stream/IntStream.sorted |> Interop/Util/Stream/IntStream.toArray;
        Array.compare(arr, Array#{0, 1, 1, 2, 2, 3} @ Static) == EqualTo
*/
}