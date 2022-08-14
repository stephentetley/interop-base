

namespace TestPath {


    @test
    def path01(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> 
            region r {
                let* p1 = Interop/NIO/File/Path.of("/user", [] @ r);
                println("path01: ${Interop/NIO/File/Path.toString(p1)}");
                Ok(true)
            };
        step() |> Result.getWithDefault(false)

    @test
    def path02(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> 
            region r {
                let* p1 = Interop/NIO/File/Path.of("/user", ["local"] @ r);
                println("path02: ${Interop/NIO/File/Path.toString(p1)}");
                Ok(true)
            };
        step() |> Result.getWithDefault(false)

    @test
    def path03(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> 
            region r {
                let rest = List.toArray(r, "local" :: "bin" :: Nil);
                let* p1 = Interop/NIO/File/Path.of("/usr", rest);
                println("path02: ${Interop/NIO/File/Path.toString(p1)}");
                Ok(true)
            };
        step() |> Result.getWithDefault(false)
}