@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

REM :: Recursively remove files/folders generated by compiler
REM :: Written by Travis Robinson - 12/20/2010
REM ::
SET RM_FILES=!RM_FILES! "*.err" "*.o" "*.ncb" "*.user" "*.resharper" "*.suo" "build*.log"
SET RM_DIRS=!RM_DIRS! "_ReSharper*" "objfre_*" "objchk_*" "bin*" "Debug*" "Release*"

CALL :RemoveFiles !RM_FILES!
CALL :RemoveDirs !RM_DIRS!

GOTO :EOF

:RemoveDirs
	SET _DirList=%*
	FOR /F "usebackq eol=; tokens=* delims=" %%A IN (`DIR /AD /S /B !_DirList!`) DO	(
		IF EXIST "%%~A" (
			ECHO Removing dir %%~nA
			RMDIR /S /Q "%%~A" 2>NUL>NUL
			IF "!ERRORLEVEL!" NEQ "0" ECHO Failed removing dir %%~A
		)
	)
GOTO :EOF

:RemoveFiles
	SET _FileList=%*
	FOR /F "usebackq eol=; tokens=* delims=" %%A IN (`DIR /A-D /S /B !_FileList!`) DO (
		IF EXIST "%%~A" (
			ECHO Removing file %%~nxA
			ATTRIB -S -H -R /S "%%~A" 2>NUL>NUL
			DEL /Q "%%~A" 2>NUL>NUL
			IF "!ERRORLEVEL!" NEQ "0" ECHO Failed removing file %%~A
		)
	)
GOTO :EOF
