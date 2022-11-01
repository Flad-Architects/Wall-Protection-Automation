@ECHO off
SETLOCAL ENABLEEXTENSIONS
SET ME=%~n0
SET PARENT=%~dp0

:SERVARIABLES
SET BATCHFILENAME=Dynamo Package and Node Deployment
SET PROCESSDESCRIPTION=INSTALL FLAD STANDARD DYNAMO COMPONENTS

SET VERSION=1.0
SET REVISION=
SET YEAR=2022
SET FILENAME=

:GETGATEWAY
set "ip="
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "Default"') do if not defined ip set ip=%%b

set ip=%ip: =%

:SETFILESERVER
IF %IP%==10.1.10.1 SET SERVER=\\tank02-msn
IF %IP%==10.1.20.1 SET SERVER=\\tank02-msn
IF %IP%==10.1.30.1 SET SERVER=\\tank02-msn
IF %IP%==10.2.0.1 SET SERVER=\\fs01-rdu
IF %IP%==10.3.0.1 SET SERVER=\\fs01-sfo
IF %IP%==10.4.0.1 SET SERVER=\\fs01-nyc
IF %IP%==10.5.0.1 SET SERVER=\\fs01-gnv
IF %IP%==10.6.0.1 SET SERVER=\\fs01-atl
IF %IP%==10.7.0.1 SET SERVER=\\fs01-tpa
IF %IP%==10.9.0.1 SET SERVER=\\fs01-sea
IF %IP%==192.168.54.1 SET SERVER=\\fs00-222
IF %IP%==192.168.55.1 SET SERVER=\\fs00-222
IF %IP%==10.22.100.1 SET SERVER=\\tank02-msn
IF %IP%==10.22.101.1 SET SERVER=\\tank02-msn
IF %IP%==10.1.3.1 SET SERVER=\\tank02-msn
IF %IP%==0.0.0.0 SET SERVER=\\fs00-222
IF %IP%==NEWSERVER1 SET SERVER\\fs01-xxx
IF %IP%==NEWSERVER2 SET SERVER\\fs01-xxx
IF %IP%==NEWSERVER3 SET SERVER\\fs01-xxx
IF %IP%==NEWSERVER4 SET SERVER\\fs01-xxx
IF %IP%==NEWSERVER5 SET SERVER\\fs01-xxx
SETx FILESERVER %SERVER% 
SETx /m FILESERVER %SERVER%
SET SOFTWARE=%SERVER%\programs\apps
ECHO COPY
goto:DISPLAY

:DISPLAY
ECHO ***************************************
ECHO File Name: %FILENAME%
ECHO Process: %PROCESSDESCRIPTION%
ECHO Parent Directory: %PARENT%
ECHO IP Address:  %IP%
ECHO Local Server: %SERVER%
ECHO Fileserver Variable now set as: %FILESERVER%
ECHO Software Path:  %SOFTWARE%
ECHO ***************************************
:COPY PLAYER FILES
:2022
if exist "C:\ProgramData\Autodesk\RVT 2022\Dynamo\samples\en-US\Revit\DynamoPlayer-4\Samples.zip" (
    del "C:\ProgramData\Autodesk\RVT 2022\Dynamo\samples\en-US\Revit\DynamoPlayer-4\Samples.zip" /f /q
    robocopy "%FILESERVER%\programs\local\deploy\Dynamo\dyn\2022\*" "C:\ProgramData\Autodesk\RVT 2022\Dynamo\samples\en-US\Revit\DynamoPlayer-4"
) else (
	robocopy "%FILESERVER%\programs\local\deploy\Dynamo\dyn\2022\*" "C:\ProgramData\Autodesk\RVT 2022\Dynamo\samples\en-US\Revit\DynamoPlayer-4"
)
:2023
if exist "C:\ProgramData\Autodesk\RVT 2023\Dynamo\samples\en-US\Revit\DynamoPlayer-5\Samples.zip" (
    del "C:\ProgramData\Autodesk\RVT 2023\Dynamo\samples\en-US\Revit\DynamoPlayer-5\Samples.zip" /f /q
    robocopy "%FILESERVER%\programs\local\deploy\Dynamo\dyn\2023" "C:\ProgramData\Autodesk\RVT 2023\Dynamo\samples\en-US\Revit\DynamoPlayer-5"
) else (
	robocopy "%FILESERVER%\programs\local\deploy\Dynamo\dyn\2023" "C:\ProgramData\Autodesk\RVT 2023\Dynamo\samples\en-US\Revit\DynamoPlayer-5"
)
:COPY PACKAGES
:2021
robocopy /e "\\tank02-msn\programs\local\deploy\Dynamo\packages\2.06_2021" "C:\Users\%USERNAME%\AppData\Roaming\Dynamo\Dynamo Revit\2.06\packages"
:2022
robocopy /e "\\tank02-msn\programs\local\deploy\Dynamo\packages\2.12_2022" "C:\Users\%USERNAME%\AppData\Roaming\Dynamo\Dynamo Revit\2.12\packages" 
:2023
robocopy /e "\\tank02-msn\programs\local\deploy\Dynamo\packages\2.3_2023" "C:\Users\%USERNAME%\AppData\Roaming\Dynamo\Dynamo Revit\2.3\packages" > nul