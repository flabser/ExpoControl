@echo off
REM Author Medet
REM Теперь не нужно при изменениях в директории libs версий или названий исходников прописывать classpath
REM Не устанавливать setlocal, требовательно для запуска в качестве службы
REM
set NB_HOME=%~dp0
set NB_LIBS=%NB_HOME%libs/
set NBCLASSPATH=.
set JAVA_START_OPTS=-Xms128m -Xmx256m
REM Оставить пустым MAIN_JAR (MAIN_JAR=) если классы не запакованы в jar.
set MAIN_JAR=
set MAIN_CLASS=kz.pchelka.server.Server

set _JAVACMD="java.exe"

set TITLE=NB 4ms workflow
TITLE %TITLE%

cd %NB_HOME%
if not exist "%NB_HOME%cfg.xml" (
	echo Not found config file cfg.xml
	pause
	goto :eof
)
if not "%MAIN_JAR%"=="" (
	if not exist "%NB_LIBS%%MAIN_JAR%" (
		echo Start error.
		echo Not found file %MAIN_JAR% in path %NB_LIBS%
		pause
		goto :eof
	)
)


REM set SRVANY_PATH=%NB_HOME%servicerunner/srvany/
REM Сохранение процесс id в файле nbtaskpid.txt
REM if exist "%SRVANY_PATH%ini-srv-NT.bat" (

	REM CALL "%SRVANY_PATH%ini-srv-NT.bat" %*

	REM echo NBWTITLE=%TITLE%> %SRVANY_PATH%nbtaskpid.txt
	REM for /f "tokens=2 delims=," %%a in ('TaskList /NH /FO CSV /FI "WINDOWTITLE eq %TITLE%"') do (
		REM for /f "skip=1" %%b in ('WMIC PROCESS WHERE "ProcessId=%%~a AND Name='%%CMDPNAME%%'" Get ProcessId^,SessionID') do (
			REM echo NBPID=%%b>> %SRVANY_PATH%nbtaskpid.txt
		REM )
	REM )
REM )

cd %NB_HOME%

REM Собираем NBCLASSPATH. Инфо по работе for http://ss64.com/nt/for_r.html
FOR /R %NB_LIBS% %%G IN (*.jar) DO (call :list_classpath %%G)
set NBCLASSPATH=%NBCLASSPATH:\=/%
goto getStart
:list_classpath
	set NBCLASSPATH=%NBCLASSPATH%;%1
	exit /b

:getStart
if "%JAVA_HOME%" == "" goto startJava
if not exist "%JAVA_HOME%/java.exe" (
	if exist "%JAVA_HOME%/bin/java.exe" (
		set _JAVACMD="%JAVA_HOME%/bin/java.exe"
	)
) else (
	set _JAVACMD="%JAVA_HOME%/java.exe"
)

:startJava
echo %_JAVACMD% %JAVA_START_OPTS% -classpath %NBCLASSPATH% %MAIN_CLASS%
%_JAVACMD% %JAVA_START_OPTS% -classpath %NBCLASSPATH% %MAIN_CLASS%

if errorlevel 1 pause
goto :eof

