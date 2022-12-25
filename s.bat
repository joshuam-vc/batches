@echo off
REM THIS IS A SHORTCUT FOR SEARCHING A TERM IN DIFFERENT BROWSERS OR SEARCH ENGINE
SETLOCAL enabledelayedexpansion

:: LIST OF SEARCHABLE SITES
:: a  = amazon.com
:: ap = ap.org
:: b  = bing.com
:: d  = duckduckgo.com
:: e  = ebay.com
:: et = etsy.com
:: g  = google.com [DEFAULT]
:: h  = huffingtonpost.com
:: m  = manta.com
:: n  = newegg.com
:: ny = nytimes.com
:: t  = twitter.com
:: wp = washingtonpost.com
:: w  = wikipedia.com
:: ye = yelp.com
:: y  = youtube.com
:: ~  = full domain name [no search]

IF "%LOGS%" == "" (
	SET LOGS=%userprofile%\logs
	IF NOT EXIST !LOGS! (
		MKDIR !LOGS!
	)
)

GOTO:SET-VARIABLES
:RETURN
REM CHECK FIRST CHAR FOR LEADING SLASH ELSE USE DEFAULTS
ECHO "f: is !f!"
IF "!f!" == "/" (
	CALL:GET-BROWSER
	CALL:GET-SITE
) ELSE (
	ECHO "Calling no input"
	CALL:NO-INPUT
)
CALL:DO-SEARCH

CALL:CLOSING

EXIT /B %ERRORLEVEL%

































:: \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
::               FUNCTION SECTION
:: /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

:SET-VARIABLES
SET browser=%1
SET f=!browser:~0,1!
SET br=!browser:~1,1!
SET e=!browser:~2,1!
SET x=!browser:~3,1!
SET argCount=-1
FOR %%x IN (%*) DO (
   SET /A argCount+=1
   SET "args[!argCount!]=%%~x"
)
SET search=
REM prepend each index of the array with '+' for query string
FOR /L %%i IN (1,1,%argCount%) DO (
	SET search=!search!+!args[%%i]!
)
SET b=brave.exe
SET s=google.com/search?q=
SET yelp_location=West+Des+Moines%%2C+IA
SET manta_location=West+Des+Moines+IA
GOTO:RETURN

:GET-BROWSER
IF /I "!br!" == "f" (
	SET b=firefox.exe
)
IF /I "!br!" == "b" (
	SET b=brave.exe
)
IF /I "!br!" == "c" (
	SET b=chrome.exe
)
IF /I "!br!" == "o" (
	SET b=opera.exe
)
IF /I "!br!" == "s" (
	SET b=safari.exe
)
IF /I "!br!" == "i" (
	SET b=iexplore.exe
)
IF /I "!br!" == "e" (
	SET b=microsoft-edge
)
IF /I "!br!" == "" (
 	SET br=b
)
GOTO:EOF

:GET-SITE
IF /I "!e!" == "a" (
	IF "!x!" == "p" (
		SET e=p
		SET s=ap.org/en-us/search?q=
	) ELSE (
		SET s=amazon.com/s/ref=nb_sb_noss_2/137-1389269-8296927?field-keywords=
	)
)
IF /I "!e!" == "b" (
	SET s=bing.com/search?q=
)
IF /I "!e!" == "d" (
	SET s=duckduckgo.com?q=
)
IF /I "!e!" == "e" (
	IF /I "!x!" == "t" (
		SET s=etsy.com/search?q=
	) ELSE (
		SET s=ebay.com/sch/i.html?_nkw=
	)
)
IF /I "!e!" == "g" (
	SET s=google.com/search?q=
)
IF /I "!e!" == "h" (
	SET s=huffingtonpost.com/search?sortBy=recency^&sortOrder=desc^&keywords=
)
IF /I "!e!" == "i" (
	SET s=imdb.com/find?s=all^&q=
)
IF /I "!e!" == "m" (
	SET s=manta.com/search?search_location=%manta_location%^&search=
)
REM new york time
IF /I "!e!" == "n" (
	IF /I "!x!" == "y" (
		SET s=query.nytimes.com/search/sitesearch/?pgtype=
	) ELSE (
		SET s=newegg.com/Product/ProductList.aspx?Submit=ENE^&DEPA=0^&Order=BESTMATCH^&Description=
	)
)
IF /I "!e!" == "t" (
	SET s=twitter.com/search?q=
)
IF /I "!e!" == "w" (
	IF /I "!x!" == "p" (
		SET s=washingtonpost.com/newssearch/search.html?st=
	) ELSE (
		SET s=wikipedia.org/w/index.php?search=
	)

)
IF /I "!e!" == "y" (
	IF /I "!x!" == "e" (
		SET s=yelp.com/search?find_loc=%yelp_location%^&find_desc=
	) ELSE (
		SET s=youtube.com/results?search_query=
	)
)
IF /I "!e!" == "~" (
	SET s=FALSE
)
IF /I "!e!" == "" (
 	SET e=g
)
GOTO:EOF

:NO-INPUT
REM set these values to the logs know what was searched
SET br=b
SET e=g
SET search=%browser%+!search!
GOTO:EOF


:DO-SEARCH
ECHO on
IF "!search:~-1!" == "+" (
	SET search=!search:~0,-1!
)
IF "!search:~0,1!" == "+" (
	SET search=!search:~1!
)
IF /I "!br!" == "e" (
	IF "%s%" == "FALSE" (
		SET "v=%b%:https://!search!"
		START !v!
	) ELSE (
		IF "%x%" == "y" (
			SET "v=%b%:https://%s%!search!"
			START !v!
		) ELSE (
			SET "v=%b%:https://www.%s%!search!"
			START !v!
		)
	)
) ELSE (
	IF "%s%" == "FALSE" (
		START %b% "https://!search!"
	) ELSE (
		IF "%x%" == "y" (
			START %b% "https://%s%!search!"
		) ELSE (
			START %b% "https://www.%s%!search!"
		)
	)
)
@ECHO off
GOTO:EOF

:CLOSING
ECHO /s - %DATE% %TIME% - %br%%e% - !search! >> %LOGS%\runtimeLogs.txt
GOTO:EOF