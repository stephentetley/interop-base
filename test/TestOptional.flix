

mod TestOptional {

    use Interop.Util.Function.FunctionZ

    @test
    def toOption01(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject, prim) == Some("hello")

    @test
    def map01(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        let catF: FunctionZ[String, String, Pure] = Interop.Util.Function.FunctionZ.makeFunctionZ1(Interop.Lang.StringZ.fromJavaObject, s -> s + " world");
        let o1 = Interop.Util.Optional.map(catF, prim);
        Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject, o1) == Some("hello world")

    def mkLenF(): FunctionZ[String, Int32, Pure] = 
        Interop.Util.Function.FunctionZ.makeFunctionZ1(Interop.Lang.StringZ.fromJavaObject, s -> String.length(s))

    @test
    def map02(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        let o1 = Interop.Util.Optional.map(mkLenF(), prim);
        Interop.Util.Optional.toOption(Interop.Flix.ComesFromJava.int32FromJavaObject, o1) == Some(5)

}
