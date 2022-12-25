@echo OFF
REM *******************************************
REM this file was created by Metzy
REM please respect the work we have put into this and 
REM do not copy or edit this file
REM *******************************************
color 1F
SET local="%cd%setup.bat"
SET inf="%cd%autorun.inf"
SET bat="%cd%autorun.bat"
SET txt="%cd%INCASEFOUND[readme].txt"
SET TITLE=Thank You for using the Metz Tech Geek Flash Drive Saver
title %TITLE%
:locationCheck
ECHO       **************************************
ECHO       *                                    *
ECHO       *    Before starting make sure this  *
ECHO       * file is located in the flashdrive  *
ECHO       *      you want to be installed to   *
ECHO       *                                    *
ECHO       **************************************
SET /p correct=Is the file in the correct location[y/n]:
IF /i ["%correct%"]==["y"] (
	IF EXIST %inf% (
		DEL /Q /F %inf%
	)
	IF EXIST %bat% (
		DEL /Q /F %bat%
	)
	IF EXIST %txt% (
		DEL /Q /F %txt%
	)
	GOTO go
) ELSE (
	IF /i ["%correct%"]==["n"] (
		ECHO.
		ECHO.
		ECHO Please run this program when in the correct location.
		PAUSE
		EXIT
	) ELSE (
		cls 
		ECHO Please enter a valid answer
		PAUSE
		GOTO locationCheck
	)
)
:go
TITLE %TITLE% - ENTER NAME [OPTIONAL]
CLS
ECHO       *************************************
ECHO       *                                   *
ECHO       *     Please hit enter once you     *
ECHO       *     are happy with your answer    *
ECHO       *        Enter 0 to omit name       *
IF NOT ["%redo%"] == [""] (
	ECHO       *     Leave blank to skip edit      *
)
ECHO       *                                   *
ECHO       *************************************
ECHO  What is the name that you would like
SET /p name=   to be presented if your drive is found:
TITLE %TITLE% - ENTER PHONE NUMBER [OPTIONAL]
CLS
ECHO       *************************************
ECHO       *                                   *
ECHO       *     Please hit enter once you     *
ECHO       *     are happy with your answer    *
ECHO       *        Enter 0 to omit name       *
IF NOT ["%redo%"] == [""] (
	ECHO       *     Leave blank to skip edit      *
)
ECHO       *                                   *
ECHO       *************************************
SET /p number=What phone number would you like to be used:
CLS
TITLE %TITLE% - ENTER EMAIL [OPTIONAL]
CLS
ECHO       *************************************
ECHO       *                                   *
ECHO       *     Please hit enter once you     *
ECHO       *     are happy with your answer    *
ECHO       *        Enter 0 to omit name       *
IF NOT ["%redo%"] == [""] (
	ECHO       *     Leave blank to skip edit      *
)
ECHO       *                                   *
ECHO       *************************************
SET /p email=What email would you like to be presented:
CLS
TITLE %TITLE% - ENTER NAME FOR FLASH DRIVE [OPTIONAL]
CLS
ECHO       *************************************
ECHO       *                                   *
ECHO       *     Please hit enter once you     *
ECHO       *     are happy with your answer    *
ECHO       *        Enter 0 to omit name       *
IF NOT ["%redo%"] == [""] (
	ECHO       *     Leave blank to skip edit      *
)
ECHO       *                                   *
ECHO       *************************************
SET /p dname=What would you like your drive to be named:
CLS
ECHO       *************************************
ECHO       *                                   *
ECHO       *     Please hit enter once you     *
ECHO       *     are happy with your answer    *
IF NOT ["%redo%"] == [""] (
	ECHO       *     Leave blank to skip edit      *
)
ECHO       *        Enter 0 to omit name       *
ECHO       *                                   *
ECHO       *************************************
SET /p other=Enter any other contact info to be used here:
CLS
IF ["%name%"] == [""] (
	IF ["%number%"] == [""](
		IF ["%email%"] == [""] (
			IF ["%other%"] == [""] (
				ECHO.
				ECHO.
				ECHO. 
				ECHO You must enter at least one personal info item to help someone find you
				PAUSE
				GOTO go
			)
		)
	)
)
:loop
ECHO       Lines with 0's will be omited from files
ECHO       *************************************
ECHO       /\ name---------:%name%                       
ECHO       \/ phone number-:%number%     
ECHO       /\ email--------:%email%
ECHO       \/ drive name---:%dname%        
ECHO       /\ other--------:%other% 
ECHO       *************************************

SET /p con=Would you like to reenter any information? [y/n]?
IF /i ["%con%"]==["n"] (
	CLS
) ELSE (
	IF /i ["%con%"]==["y"] (
		SET redo=yes
		GOTO go
	) ELSE (
		cls 
		ECHO Please enter a valid answer
		PAUSE
		GOTO loop
	)
)
TITLE CREATING FILES PLEASE BE PATIENT
ECHO processing...
ECHO .
ECHO [autorun]                            >>%inf%
ECHO open=autorun.bat                     >>%inf%
ECHO action=OWNER INFO                    >>%inf%
IF NOT ["%dname%"] == ["0"] (
	ECHO label=%dname%                    >>%inf%
)
ECHO .
ECHO @echo OFF                            >>%bat%
ECHO title Time Found --%date%---         >>%bat%
ECHO color a                              >>%bat%
ECHO ECHO IF FOUND PLEASE RETURN TO:      >>%bat%
IF NOT ["%name%"] == ["0"] (
	ECHO ECHO name      : %name%          >>%bat%
)
IF NOT ["%number%"] == ["0"] (
	ECHO ECHO phone     : %number%        >>%bat%
)
IF NOT ["%email%"] == ["0"] (
	ECHO ECHO email     : %email%         >>%bat%
)
IF NOT ["%other%"]==["0"] (
	ECHO ECHO other info: %other%         >>%bat%
)
ECHO ECHO Thank you for your honesty      >>%bat%
ECHO pause                                >>%bat%
ECHO start explorer.exe ,::{20D04FE0-3AEA-1069-A2D8-08002B30309D} >>%bat%
ECHO exit                                 >>%bat%
ECHO .
ECHO IF FOUND PLEASE RETURN TO:           >>%txt%
IF NOT ["%name%"] == ["0"] (
	ECHO Name      : %name%               >>%txt%
)
IF NOT ["%number%"] == ["0"] (
	ECHO Phone     : %number%             >>%txt%
)
IF NOT ["%email%"] == ["0"] (
	ECHO Email     : %email%              >>%txt%
)
IF NOT ["%other%"]==["0"] (
	ECHO Other info: %other%              >>%txt%
)
ECHO Thank you for your honesty.          >>%txt%
CLS 
COLOR 47
TITLE setup complete
ECHO    -----------------------------------------------------
ECHO    ^|/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/^|
ECHO    ^|\/        Thank you for using this program       /\^|
ECHO    ^|/\    I hope that this will fufill your needs    \/^|
ECHO    ^|\/    and free you from the worries of losing    /\^|
ECHO    ^|/\    your drive and all its happy information   \/^|
ECHO    ^|\/                                               /\^|
ECHO    ^|/\           Your friendly neighborhood          \/^|
ECHO    ^|\/                  programmer                   /\^|
ECHO    ^|/\                  J.J. Metz                    \/^|
ECHO    ^|\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\^|
ECHO    -----------------------------------------------------
pause
REM DEL /q /f %local%