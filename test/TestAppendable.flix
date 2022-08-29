

namespace TestAppendable {


    @test
    def test01(): Bool \ IO = 
        use Result.flatMap;
        let step = () -> 
            region r1 {
                let sb = StringBuilder.new(r1);
                let* _ = Interop/Lang/Appendable.appendCharSequence!(Interop/Flix/WrappedRegion.wrapStringWithRegion(r1, "Hello world"), sb);
                let* _ = Interop/Lang/Appendable.appendChar!('!', sb);
                println("test01: " + StringBuilder.toString(sb));
                Ok(StringBuilder.toString(sb) == "Hello world!")
            };
        step() |> Result.getWithDefault(false)



}