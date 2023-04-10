
/// WARNING - Hard coded paths

mod TestFiles {

    @test
    def exists01(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {
            forM (p1 <- Interop.NIO.File.Path.of("e:/coding/flix/interop-base/README.md", List#{});
                    ans <- Interop.NIO.File.Files.exists(p1, List#{Interop.NIO.File.LinkOption.nofollow_links()}))
            yield ans
        };
        step() |> Result.getWithDefault(false)

    @test
    def exists02(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {
            forM (p1 <- Interop.NIO.File.Path.of("e:/coding/flix/interop-base", List#{"README.md"});
                    ans <- Interop.NIO.File.Files.exists(p1, List#{}))
            yield ans
        };
        step() |> Result.getWithDefault(false)

}