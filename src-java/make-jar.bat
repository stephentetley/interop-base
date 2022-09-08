
setlocal

set JAVA_HOME=C:\Program Files\Zulu\zulu-11

echo %JAVA_HOME%

set PATH=C:\Program Files\Zulu\zulu-11\bin;%PATH%

java --version

ant

rem check major version - should be 55...

javap -cp .\build\interop-base-java.*.jar -verbose flixinterop.nio.file.Pathz



endlocal