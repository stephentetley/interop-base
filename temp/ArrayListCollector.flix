// Run with
// > java -jar ..\bin\flix-master.jar .\temp\ArrayListCollector.flix .\interop-base.fpkg .\lib\interop-base-java.1.3.jar

use Interop/Util/Function.Function
use Interop/Util/Stream.Collector
use Interop/Util.ArrayList
use Interop/Util.ArrayList.ArrayList

def main(): Int32 \ IO = 
    test01 |> runIt;
    0

pub def runIt(f: Unit -> Result[Unit, String] \ ef): Unit \ {ef, IO} = match f() {
    case Ok() => ()
    case Err(msg) => println(msg)
}

pub def castObjectToArrayList(r: Region[r], o: ##java.lang.Object): ArrayList[a, r] = 
    Interop/Util/ArrayList.wrapHH(r, o as ##java.util.ArrayList)

pub def castArrayListToObject(l: ArrayList[a, r]): ##java.lang.Object = 
    let ArrayList(l1) = l;
    l1 as ##java.lang.Object 


pub def arrayListCollector(r: Region[r]): Collector[String, a, ArrayList[String, r]] \ IO = 
    let supplier = Interop/Util/Function/Supplier.makeInitialSupplier(r, _ -> Interop/Util/ArrayList.new(r));
    let accumulator = Interop/Util/Function/BiConsumer.makeAccumulator(r, (l, e: String) -> discard Interop/Util/ArrayList.add!(e, l));
    let combiner = Interop/Util/Function/BinaryOperator.makeCombiner(r, (l1, l2) -> {discard Interop/Util/ArrayList.addAll!(Interop/Util/ImpCollection.toCollection(l2), l1); l1});
    let finisher = Interop/Util/Function/Function.makeCollectionFinisher(r, (l: ArrayList[String, r]) -> l);
    Interop/Util/Stream/Collector.of5(supplier, accumulator, combiner, finisher, [])


pub def test01(): Result[Unit, String] \ IO = 
    use Result.flatMap;
    region r {
        let strm    = Interop/Util/Stream/Stream.ofArray(r, ["Hello", "World", "!"] @ r);
        let coll    = arrayListCollector(r);
        let ans     = Interop/Util/Stream/Stream.collectWith(coll, strm, castObjectToArrayList(r));
        println(Interop/Util/ArrayList.toString(ans));
        Ok()
    }    
