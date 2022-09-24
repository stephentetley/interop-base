
setlocal

set JAVA_HOME=C:\Program Files\Zulu\zulu-11

echo %JAVA_HOME%

set PATH=C:\Program Files\Zulu\zulu-11\bin;%PATH%

java --version

ant

rem Checking that jar was compiled with Java 11

rem list contents of the jar

jar -tf .\build\interop-base-java.*.jar

rem pick a class and check major version - should be 55...

javap -cp .\build\interop-base-java.*.jar -verbose flixinterop.nio.file.Pathz



endlocal