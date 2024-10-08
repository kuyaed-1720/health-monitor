@echo off
setlocal

:: Setting variables
set "MYSQL_HOME=D:/CodeHaven/MySQL"
set "PHP_HOME=D:/CodeHaven/php"
set "APACHE_HOME=D:/CodeHaven/Apache24"
set "COLORIZE_HOME=D:/Codehaven/colorize.bat"
set "COLORIZE=call %COLORIZE_HOME%"

:: Check for arguments
if "%1" == "" goto :about
if "%1" == "start" goto :start
if "%1" == "stop" goto :stop
if "%1" == "status" goto :status
if "%1" == "help" goto :help

:: Print error if command is not found
%COLORIZE% :error "Invalid command."
echo.
goto :help

:: Starts the services
:start
if "%2" == "" (
	%COLORIZE% :error "Command incomplete. Must specify which service to start."
	echo.
	%COLORIZE% :yellow "Available commands:"
	%COLORIZE% :blue "start all	- Start all services"
	%COLORIZE% :blue "start apache	- Start Apache service"
	%COLORIZE% :blue "start mysql	- Start MySQL service"
	goto :eof
)

if "%2" == "apache" goto :start_apache
if "%2" == "mysql" goto :start_mysql
if "%2" == "all" goto :start_apache

if not "%2" == "mysql" (
	if not "%2" == "apache" (
		if not "%2" == "all" (
			%COLORIZE% :error "Command not found."
			%COLORIZE% :yellow "Choose from the following:"
			%COLORIZE% :blue "start all	- Start all services"
			%COLORIZE% :blue "start apache	- Start Apache service"
			%COLORIZE% :blue "start mysql	- Start MySQL service"
			goto :eof
		)
	)
)
goto :eof

:start_apache
%COLORIZE% :cyan "Starting Apache..."
tasklist /FI "IMAGENAME eq httpd.exe" | find /I "httpd.exe" >nul
if "%ERRORLEVEL%"=="0" (
	%COLORIZE% :blue "[Apache]	- Apache is already running."
	if "%2" == "apache" goto :eof
	goto :start_mysql
)
start "" "%APACHE_HOME%/bin/httpd"
%COLORIZE% :green "[Apache]	- Apache has started."
if "%2" == "apache" goto :eof

:start_mysql
%COLORIZE% :cyan "Starting MySQL..."
tasklist /FI "IMAGENAME eq mysqld.exe" | find /I "mysqld.exe" >nul
if "%ERRORLEVEL%"=="0" (
	%COLORIZE% :blue "[MySQL]		- MySQL is already running."
	goto :eof
)
start "" "%MYSQL_HOME%/bin/mysqld.exe" --console
%COLORIZE% :green "[MySQL]		- MySQL has started."
goto :eof

:: Stops the service
:stop
if "%2" == "apache" goto :stop_apache
if "%2" == "mysql" goto :stop_mysql
if not "%2" == "" (
	%COLORIZE% :error "Command argument is invalid. Choose from the ff:"
	%COLORIZE% :blue "'stop'		- Stop all runnning services"
	%COLORIZE% :blue "'stop apache'	- Stop Apache service"
	%COLORIZE% :blue "'stop mysql'	- Stop MySQL service"
	goto :eof
)

%COLORIZE% :cyan "Stopping MySQL and Apache..."

:stop_apache
%COLORIZE% :yellow "Stopping Apache..."
tasklist /FI "IMAGENAME eq httpd.exe" | find /I "httpd.exe" >nul
if "%ERRORLEVEL%"=="1" (
	%COLORIZE% :blue "[Apache]	- Apache is not running."
	if "%2" == "apache" goto :eof
	goto :stop_mysql
)
taskkill /F /IM httpd.exe
%COLORIZE% :green "[Apache]	- Apache has stopped."
if "%2" == "apache" goto :eof

:stop_mysql
%COLORIZE% :yellow "Stopping MySQL..."
tasklist /FI "IMAGENAME eq mysqld.exe" | find /I "mysqld.exe" >nul
if "%ERRORLEVEL%"=="1" (
	%COLORIZE% :blue "[MySQL]		- MySQL is not running."
	goto :eof
)
taskkill /F /IM mysqld.exe
%COLORIZE% :green "[MySQL]		- MySQL has stopped."
goto :eof

:status
%COLORIZE% :cyan "Checking status of services..."
tasklist /FI "IMAGENAME eq mysqld.exe" | find /I "mysqld.exe" >nul && %COLORIZE% :yellow "[MySQL]		- MySQL is running." || %COLORIZE% :blue "[MySQL]		- MySQL is not running."
tasklist /FI "IMAGENAME eq httpd.exe" | find /I "httpd.exe" >nul && %COLORIZE% :yellow "[Apache]		- Apache is running." || %COLORIZE% :blue "[Apache]		- Apache is not running."
goto :eof

:about
%COLORIZE% :blue "CodeHaven is a repository for kuyaed's coding environment currently with MySQL, PHP, and Apache installed to serve all his programming needs.."
echo.
goto :help

:help
%COLORIZE% :yellow "Available commands:"
%COLORIZE% :blue "start [mysql, apache]	- Start MySQL and/or Apache services"
%COLORIZE% :blue "stop [mysql, apache]	- Stop MySQL and/or Apache services"
%COLORIZE% :blue "status 			- Check the status of MySQL and Apache services"
%COLORIZE% :blue "help			- Display this help message"
goto :eof

endlocal