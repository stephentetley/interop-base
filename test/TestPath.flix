

namespace TestPath {


    @test
    def path01(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {
            let* p1 = Interop/NIO/File/Path.of("/user", Nil);
            println("path01: ${Interop/NIO/File/Path.toString(p1)}");
            Ok(true)
        };
        step() |> Result.getWithDefault(false)

    @test
    def path02(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {            
            let* p1 = Interop/NIO/File/Path.of("/user", "local" :: Nil);
            println("path02: ${Interop/NIO/File/Path.toString(p1)}");
            Ok(true)
        };
        step() |> Result.getWithDefault(false)

    @test
    def path03(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {
            let* p1 = Interop/NIO/File/Path.of("/usr", "local" :: "bin" :: Nil);
            println("path02: ${Interop/NIO/File/Path.toString(p1)}");
            Ok(true)
        };
        step() |> Result.getWithDefault(false)
}