@echo off

if "%1" == "" (
	set filepath=firmware.bin
) else (
	set filepath=%1
)

if not exist %filepath% (
	echo Firmware file %filepath% not found
) else (
	echo ...Detecting LPC device
	set lpcpath=
	for /f %%D in ('wmic volume get DriveLetter^, Label ^| find "CRP DISABLD"') do set lpcpath=%%D
	
	if "%lpcpath%" == "" (
		echo LPC device not detected
	) else (
		echo 	Device found at %lpcpath%
		echo ...Removing old firmware
		del %lpcpath%\firmware.bin
		if not exist %lpcpath%\firmware.bin (
			echo 	Removed old firmware
		)
		
		echo ...Copying new firmware
		copy %filepath% %lpcpath%\firmware.bin
		
		echo ...Finished
	)
)