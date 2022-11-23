// Run with
// > java -jar ..\bin\flix-master.jar .\temp\ForEach.flix .\interop-base.fpkg .\lib\interop-base-java.1.3.jar

def main(): Int32 \ IO = 
    match test01() {
        case Ok() => ()
        case Err(msg) => println(msg)
    };
    match test02() {
        case Ok() => ()
        case Err(msg) => println(msg)
    };
    0

pub def printStr(s: String): Unit \ IO = println(s)

pub def test01(): Result[Unit, String] \ IO = region r {
    let col1 = Interop/Util/Collection.fromList(r, "Hello" :: "World" :: "!" :: Nil);
    Interop/Util/Collection.forEach(x -> printStr(x), col1)
}    

pub def test02(): Result[Unit, String] \ IO = region r {
    let col1 = Interop/Util/Collection.fromList(r, "AAA" :: "BBB" :: "CCC" :: Nil);
    Interop/Util/Collection.removeIf!(s -> String.contains(substr = "B", s), col1) |> println;
    Interop/Util/Collection.forEach(x -> printStr(x), col1)
}    
