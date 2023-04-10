// Run with
// > java -jar ..\bin\flix-master.jar .\temp\ForEach.flix .\interop-base.fpkg .\lib\interop-base-java.1.3.jar

def main(): Int32 \ IO = 
    test01 |> runIt;
    test02 |> runIt;
    test03 |> runIt;
    0

pub def runIt(f: Unit -> Result[String, Unit] \ ef): Unit \ {ef, IO} = match f() {
    case Ok() => ()
    case Err(msg) => println(msg)
}

pub def printStr(s: String): Unit \ IO = println(s)

pub def test01(): Result[String, Unit] \ IO = region r {
    let col1 = Interop.Util.Collection.fromList(r, "Hello" :: "World" :: "!" :: Nil);
    Interop.Util.Collection.forEach(x -> printStr(x), col1)
}    

pub def test02(): Result[String, Unit] \ IO = region r {
    let col1 = Interop.Util.Collection.fromList(r, "AAA" :: "BBB" :: "CCC" :: Nil);
    Interop.Util.Collection.removeIf!(s -> String.contains(substr = "B", s), col1) |> println;
    Interop.Util.Collection.forEach(x -> printStr(x), col1)
}    

pub def test03(): Result[String, Unit] \ IO = region r {
    let map1 = Interop.Util.MapZ.of2(r, "AAA", "aaa", "BB", "bb");
    Interop.Util.MapZ.forEach((k,v) -> printStr("${k} => ${v}"), map1)
} 