

mod TestOptional {

    use Interop.Util.Optional
    use Interop.Util.Function.FunctionZ

    @test
    def toOption01(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject, prim) == Some("hello")

    @test
    def map01(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        let catF: FunctionZ[String, String, Pure] = Interop.Util.Function.FunctionZ.makeFunctionZ(Interop.Lang.StringZ.fromJavaObject, s -> s + " world");
        let o1 = Interop.Util.Optional.map(catF, prim);
        Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject, o1) == Some("hello world")

    def mkLenF(): FunctionZ[String, Int32, Pure] = 
        Interop.Util.Function.FunctionZ.makeFunctionZ(Interop.Lang.StringZ.fromJavaObject, s -> String.length(s))

    @test
    def map02(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        let o1 = Interop.Util.Optional.map(mkLenF(), prim);
        Interop.Util.Optional.toOption(Interop.Flix.ComesFromJava.int32FromJavaObject, o1) == Some(5)

    @test
    def flatMap01(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        let fn = Interop.Util.Function.FunctionZ.makeFunctionZ(Interop.Lang.StringZ.fromJavaObject, s -> Interop.Util.Optional.of(s + "!"));
        let o1 = Interop.Util.Optional.flatMap(fn, prim);
        Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject, o1) == Some("hello!")


    @test
    def ifPresent01(): Unit \ IO = 
        let prim = Interop.Util.Optional.of("hello");
        let fn = Interop.Util.Function.ConsumerZ.makeConsumerZ(Interop.Lang.StringZ.fromJavaObject, s -> println("ifPresent01: ${s}"));
        Interop.Util.Optional.ifPresent(fn, prim)

    @test
    def ifPresent02(): Unit \ IO = 
        let prim: Optional[String] = Interop.Util.Optional.empty();
        let fn = Interop.Util.Function.ConsumerZ.makeConsumerZ(Interop.Lang.StringZ.fromJavaObject, s -> println("ifPresent01: ${s}"));
        Interop.Util.Optional.ifPresent(fn, prim)
    
    @test
    def filter01(): Bool \ {} = 
        let prim = Interop.Util.Optional.of("hello");
        let fn = Interop.Util.Function.PredicateZ.makePredicateZ(Interop.Lang.StringZ.fromJavaObject, s -> not String.isEmpty(s));
        let o1 = Interop.Util.Optional.filter(fn, prim);
        Interop.Util.Optional.toOption(Interop.Lang.StringZ.fromJavaObject, o1) == Some("hello")



}
