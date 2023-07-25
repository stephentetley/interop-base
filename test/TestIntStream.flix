

mod TestIntStream {


    @test
    def flatMap01(): Bool \ {} = region rc {
        /// for every i gen 3...
        let f1 = Interop.Util.Function.IntFunctionZ.makeIntFunctionZ(i -> Interop.Util.Stream.IntStream.range(rc, i, i+3));
        let stream0 = Interop.Util.Stream.IntStream.range(rc, 0, 2);
        let stream1 = Interop.Util.Stream.IntStream.flatMap(f1, stream0);
        let ct = Interop.Util.Stream.IntStream.count(stream1);
        ct == 6i64
    }

    @test
    def generate01(): Bool \ {} = region rc {
        let rx = ref 0 @ rc;
        let gen = Interop.Util.Function.IntSupplier.makeIntSupplier(() -> {
            let x = deref rx;
            rx := x + 1;
            x
        });
        let stream0 = Interop.Util.Stream.IntStream.generate(rc, gen);
        let stream1 = Interop.Util.Stream.IntStream.limit(10i64, stream0);
        let size = Interop.Util.Stream.IntStream.count(stream1);
        size == 10i64
    }

    @test
    def iterateWithPredicate01(): Bool \ {} = region rc {
        let p1 = Interop.Util.Function.IntPredicateZ.makeIntPredicateZ(i -> i < 10);
        let f1 = Interop.Util.Function.IntUnaryOperatorZ.makeIntUnaryOperatorZ(i -> i+1);
        let stream = Interop.Util.Stream.IntStream.iterateWithPredicate(rc, 0, p1, f1);
        let arr = Interop.Util.Stream.IntStream.toArray(rc, stream);
        Array.compare(arr, Array#{0, 1, 2, 3, 4, 5, 6, 7, 8, 9} @ rc) == Comparison.EqualTo
    }

    @test
    def mapToDouble01(): Bool \ {} = region rc {
        let f1 = Interop.Util.Function.IntToDoubleFunction.makeIntToDoubleFunction(Int32.toFloat64);
        let stream1 = Interop.Util.Stream.IntStream.ofVector(rc, Vector#{0, 1, 2, 3, 4, 5});
        let stream2 = Interop.Util.Stream.IntStream.mapToDouble(rc, f1, stream1);
        let size = Interop.Util.Stream.DoubleStream.count(stream2);
        size == 6i64
    }

    @test
    def mapToLong01(): Bool \ {} = region rc {
        let f1 = Interop.Util.Function.IntToLongFunction.makeIntToLongFunction(Int32.toInt64);
        let stream1 = Interop.Util.Stream.IntStream.ofVector(rc, Vector#{0, 1, 2, 3, 4, 5});
        let stream2 = Interop.Util.Stream.IntStream.mapToLong(rc, f1, stream1);
        let arr = Interop.Util.Stream.LongStream.toArray(rc, stream2);
        Array.compare(arr, Array#{0i64, 1i64, 2i64, 3i64, 4i64, 5i64} @ rc) == Comparison.EqualTo
    }



/*
    @test
    def flatMap02(): Bool \ IO = 
        /// for every i gen 3...
        let f1 = i -> Interop.Util.Stream.IntStream.range(Static, i, i+3);
        let stream0 = Interop.Util.Stream.IntStream.range(Static, 0, 2);
        let stream1 = Interop.Util.Stream.IntStream.flatMap(f1, stream0);
        let arr = Interop.Util.Stream.IntStream.toArray(stream1);
        Array.compare(arr, Array#{0, 1, 2, 1, 2, 3} @ Static) == EqualTo

    @test
    def sorted01(): Bool \ IO = 
        /// for every i gen 3...
        let f1 = i -> Interop.Util.Stream.IntStream.range(Static, i, i+3);
        let stream0 = Interop.Util.Stream.IntStream.range(Static, 0, 2);
        let stream1 = Interop.Util.Stream.IntStream.flatMap(f1, stream0);
        let arr = stream1 |> Interop.Util.Stream.IntStream.sorted |> Interop.Util.Stream.IntStream.toArray;
        Array.compare(arr, Array#{0, 1, 1, 2, 2, 3} @ Static) == EqualTo
*/
}