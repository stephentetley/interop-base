

namespace TestPath {


    @test
    def path01(): Bool = 
        use Result.flatMap;
        let step = () -> {
            forM (p1 <- Interop/NIO/File/Path.of("/usr", Nil);
                    depth <- Ok(Interop/NIO/File/Path.getNameCount(p1)))
            yield (depth == 1)
        };
        step() |> Result.getWithDefault(false)

    @test
    def path02(): Bool = 
        use Result.flatMap;
        let step = () -> {            
            forM (p1 <- Interop/NIO/File/Path.of("/usr", "local" :: Nil);
                    depth <- Ok(Interop/NIO/File/Path.getNameCount(p1)))
            yield (depth == 2)
        };
        step() |> Result.getWithDefault(false)

    @test
    def path03(): Bool = 
        use Result.flatMap;
        let step = () -> {
            forM (p1 <- Interop/NIO/File/Path.of("/usr", "local" :: "bin" :: Nil);
                    depth <- Ok(Interop/NIO/File/Path.getNameCount(p1)))
            yield (depth == 3)
        };
        step() |> Result.getWithDefault(false)

}
