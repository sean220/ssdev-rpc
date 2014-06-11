@echo off & setlocal enabledelayedexpansion

set LIB_JARS=""
cd ..\lib
for %%i in (*) do set LIB_JARS=!LIB_JARS!;..\lib\%%i
cd ..\bin

if ""%1"" == ""debug"" goto debug
if ""%1"" == ""jmx"" goto jmx

java -server -Xms64m -Xmx1024m -XX:MaxPermSize=64M -classpath ../conf;%LIB_JARS% ctd.net.rpc.server.MAIN
goto end

:debug
java -server -Xms64m -Xmx1024m -XX:MaxPermSize=64M -Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -classpath ../conf;%LIB_JARS% ctd.net.rpc.server.MAIN
goto end

:jmx
java -server -Xms64m -Xmx1024m -XX:MaxPermSize=64M -Dcom.sun.management.jmxremote.port=1099 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -classpath ../conf;%LIB_JARS% ctd.net.rpc.server.MAIN

:end
pause