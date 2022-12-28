// Run with
// > java -jar ..\bin\flix-master.jar .\temp\Comparator.flix .\interop-base.fpkg .\lib\interop-base-java.1.3.jar

def main(): Int32 \ IO = 
    test01 |> runIt;
    test02 |> runIt;
    0

pub def runIt(f: Unit -> Result[String, Unit] \ ef): Unit \ {ef, IO} = match f() {
    case Ok() => ()
    case Err(msg) => println(msg)
}


pub def test01(): Result[String, Unit] \ IO = 
    use Result.flatMap;
    region r {
        let* xs = Interop/Util/ArrayList.newWithCollection(r, Interop/Util/ListZ.of5(r, "dddd", "aaa", "BBB", "EE", "c") |> Interop/Util/ImpCollection.toCollection);
        let compareLength = (s1, s2) -> Order.compare(String.length(s1), String.length(s2)) |> Comparison.toInt;
        let* _  = Interop/Util/ArrayList.sort!(compareLength, xs);
        let* _  = Interop/Util/ArrayList.forEach(println, xs);
        Ok()
    }    


pub def test02(): Result[String, Unit] \ IO = 
    use Result.flatMap;
    use Interop/Util.Comparator;
    region r {
        let* xs = Interop/Util/ArrayList.newWithCollection(r, Interop/Util/ListZ.of5(r, "ddd", "aaa", "ccc", "bbb", "eee") |> Interop/Util/ImpCollection.toCollection);
        let* _  = Interop/Util/ArrayList.sortWithComparator!(Interop/Util/Comparator.naturalOrder(), xs);
        let* _  = Interop/Util/ArrayList.forEach(println, xs);
        let* _  = Interop/Util/ArrayList.sortWithComparator!(Interop/Util/Comparator.reverseOrder(), xs);
        let* _  = Interop/Util/ArrayList.forEach(println, xs);
        Ok()
    }    
