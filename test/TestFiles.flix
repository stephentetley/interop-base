namespace TestFiles {

    @test
    def exists01(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {
            let* p1 = Interop/NIO/File/Path.of("e:/coding/flix/interop-base/README.md", List#{});
            let* ans = Interop/NIO/File/Files.exists(p1, List#{Interop/NIO/File/LinkOption.nofollow_links()});
            println("exists: ${Interop/NIO/File/Path.toString(p1)} ${ans}");
            Ok(ans)
        };
        step() |> Result.getWithDefault(false)

    @test
    def exists02(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> {
            let* p1 = Interop/NIO/File/Path.of("e:/coding/flix/interop-base", List#{"README.md"});
            let* ans = Interop/NIO/File/Files.exists(p1, List#{});
            println("exists: ${Interop/NIO/File/Path.toString(p1)} ${ans}");
            Ok(ans)
        };
        step() |> Result.getWithDefault(false)

}