### v0.9.0
   Now depends on the package `charset-locale`, removed `Charset`, `Locale` modules and submodules.

### v0.8.0
   Removed `ComesFromJava` class.
   Removed `ColMarshal` class.
   Collection and Map `get` functions now use a "getter" to coerce the result type.
   Changed `Comparator` and other functional objects that were type aliases to enums.
   Changed type param order of `Collector`.

### v0.7.0
   Removed `Marshal` typeclass, it is replaced by `GoesToJava` and `ComesFromJava` (`ComesFromJava` has problems and and will itself be removed).
   Made `CharSequence` immutable.
   Added `ReadableByteChannel` and `WritableByteChannel`.
   Added `MathContext` and BigDecimal operations using it.
   Changed namespace of `Interop.Util.Stream.Collector.Characteristics` to `Interop.Util.Stream.CollectorCharacteristics`.
   Changed namespace of `Interop.Util.Stream.Stream.Builder` to `Interop.Util.Stream.StreamBuilder`.
   Changed namespace of `Interop.NIO.Channels.Pipe.SinkChannel` to `Interop.NIO.Channels.PipeSinkChannel`.
   Changed namespace of `Interop.NIO.Channels.Pipe.SourceChannel` to `Interop.NIO.Channels.PipeSourceChannel`.

### v0.6.1
   Added `Interop.Lang.IterableZ`.
   Added `StringZ.getBytes`.
   Added `Interop.Net.URI` and `Interop.Net.URL`.
   Added `Interop.Text.Format`.
   
### v0.6.0
   Removed `Read` and `Write` annotations from region signatures. 
   Removed `Builder` helper module and made `LocaleBuilder` mutable.
   Removed `Setter` helper module and added `Mut_` versions of the datatypes that used setters for initialization.

### v0.5.0
   Updated to use new effect naming convention (`Eff` not `Bool`, `+` not `and`).

### v0.4.0
   Experiment with Collator using a new pattern for "immutable after init".
   Renamed `Entry` to `MapEntry` and moved it up a level to the `Interop.Util` namespace.

### v0.3.1
   Removed uses of & in effects signatures.

### v0.3.0
   Changed to use `mod` rather than `namespace`.

### v0.2.0
   First release with new Flix package manager. 

### v0.1.0
   Initial internal release.
