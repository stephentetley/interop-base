

mod TestChoiceFormat {


    @test
    def makeWithChoices01(): Bool = 
        match Interop.Text.ChoiceFormat.makeWithChoices(List#{0.0f64, 1.0f64}, List#{"zero to one", "one or more"}) {
            case Ok(_)  => true
            case Err(_) => false
        }

    // should error
    @test
    def makeWithChoices02(): Bool = 
        match Interop.Text.ChoiceFormat.makeWithChoices(List#{0.0f64, 1.0f64}, List#{"zero to one", "one or more", "two or more"}) {
            case Ok(_)  => false
            case Err(_) => true
        }

}