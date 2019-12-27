@echo off
setlocal EnableDelayedExpansion
set index=0
set delete=0
for %%a in (%*) do (
	if "%%a" == "-d" ( 
		set /a delete=1 
	) else (
		echo %%a
		set add=%%a
	)
	set /a index+=1
)

set index=0
for /F "tokens=*" %%b in ('"reg query HKEY_CURRENT_USER\Environment /v Path"') do (
	set /a index+=1
	set env=%%b
	set env=!env:Path    REG_SZ    =!
)

if %index% gtr 2 (
	echo Too many arguments were entered.
) else if %index% lss 1 (
	echo Please enter a path.
) else (
	if %delete% == 1 (
		set update=!env:%add%;=!
		if !env! == !update! (
			echo That path is not in the environment variable path.
		) else (
			echo Deleting the path from the environment variable path.
			reg add HKEY_CURRENT_USER\Environment /v Path /t REG_SZ /d "!update!" /f
		)
	) else (
		set update=!env:%add%;=!
		if !env! == !update! (
			echo Adding path to the environment variable path.
			set update=!env!%add%;
			reg add HKEY_CURRENT_USER\Environment /v Path /t REG_SZ /d "!update!" /f
		) else (
			echo That path already exists in the environment variable path.
		)
	)
)
