@ECHO OFF
REM Change CHCP to UTF-8.
@CHCP 65001 > nul

REM Title art
:::  _____                 _            _____                 _           
::: /  ___|               (_)          |_   _|               | |          
::: \ `--.  ___ _ ____   ___  ___ ___    | | ___   __ _  __ _| | ___ _ __ 
:::  `--. \/ _ \ '__\ \ / / |/ __/ _ \   | |/ _ \ / _` |/ _` | |/ _ \ '__|
::: /\__/ /  __/ |   \ V /| | (_|  __/   | | (_) | (_| | (_| | |  __/ |   
::: \____/ \___|_|    \_/ |_|\___\___|   \_/\___/ \__, |\__, |_|\___|_|   
:::                                                __/ | __/ |            
:::                                               |___/ |___/
:::                                                   made by 0xMyeongSeok

for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A


REM Check for admin rights.
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    ECHO [!] You have to run this program as admin.
    goto END
)

REM Set a service you want.
SET service_name=INISAFEClientManager
ECHO Service Name: "%service_name%"
ECHO.

REM Get state of the service and print it.
for /f "tokens=4" %%i in ('SC QUERY %service_name% ^| FIND "STATE"') DO SET state=%%i
if NOT DEFINED state (
    ECHO No services found for %service_name%.
    goto END
)
ECHO Service state: %state%
ECHO If you want to toggle the service on and off, press any key...
@PAUSE >nul

REM Service on/off
if "%state%" == "RUNNING" (
    ECHO [-] Exiting the service...
    SC STOP %service_name% >nul
    ECHO [-] The service has exited successfully.
    goto END
)
if "%state%" == "STOPPED" (
    ECHO [-] Starting the service...
    SC START %service_name% >nul
    ECHO [-] The service has been started.
    goto END
)

:END
@ECHO.
@ECHO.
@PAUSE