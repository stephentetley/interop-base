// Run with
// > java -jar ..\bin\flix-master.jar .\temp\Comparator.flix .\interop-base.fpkg .\lib\interop-base-java.1.3.jar

def main(): Int32 \ IO = 
    test01 |> runIt;
    0

pub def runIt(f: Unit -> Result[Unit, String] \ ef): Unit \ {ef, IO} = match f() {
    case Ok() => ()
    case Err(msg) => println(msg)
}

pub def printStr(s: String): Unit \ IO = println(s)

pub def test01(): Result[Unit, String] \ IO = 
    use Result.flatMap;
    region r {
        let* xs = Interop/Util/ArrayList.newWithCollection(r, Interop/Util/ListZ.of5(r, "ddd", "aaa", "BBB", "EE", "c") |> Interop/Util/ImpCollection.toCollection);
        let compareLength = Interop/Util/Comparator.makeComparator(
            (s1, s2) -> Order.compare(String.length(s1), String.length(s2)) |> Comparison.toInt);
        let* _  = Interop/Util/ArrayList.sort!(compareLength, xs);
        let* _  = Interop/Util/ArrayList.forEach(x -> printStr(x), xs);
        Ok()
    }    

