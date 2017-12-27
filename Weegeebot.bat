@echo off
title Weegeebot %DATE%
if exist "%~dp0\settings\lang.cfg" set /p lang=<"%~dp0\settings\lang.cfg"
if not exist "%~dp0\settings\lang.cfg" (
   md "%~dp0\settings"
   echo en>"%~dp0\settings\lang.cfg"
)

if exist "%~dp0\settings\start.cfg" set /p start=<"%~dp0\settings\start.cfg"
if not exist "%~dp0\settings\start.cfg" (
   echo pm2>"%~dp0\settings\start.cfg"
)
color 1e

REM Commands
:init
   cls

   echo ==[Weegeebot BETA]==
   if "%lang%"=="en" echo Type 'help' for a list of commands:
   if "%lang%"=="de" echo Gib 'hilfe' ein f�r eine Befehlsliste:

REM Commands
:cmd

   set /p exec= "> "
   if "%lang%"=="en" (
      if "%exec%"=="start" goto start
      if "%exec%"=="restart" goto restart
      if "%exec%"=="tool" goto tool
      if "%exec%"=="install" goto install
      if "%exec%"=="help" goto help
      if "%exec%"=="lang" goto lang
      if "%exec%"=="mode" goto mode
   )
   if "%lang%"=="de" (
      if "%exec%"=="start" goto start
      if "%exec%"=="neustart" goto restart
      if "%exec%"=="tool" goto tool
      if "%exec%"=="install" goto install
      if "%exec%"=="hilfe" goto help
      if "%exec%"=="sprache" goto lang
      if "%exec%"=="modus" goto mode
   )
   goto cmd

REM Normal bot
:start

   if "%start%"=="pm2" start pm2 start %~dp0\bot.js --name="bot" --log="%~dp0\settings\log.txt"
   if "%start%"=="node" start node bot
   if "%lang%"=="en" echo Script started!
   if "%lang%"=="de" echo Skript erfolgreich ausgef�hrt!
   goto cmd

REM Restart
:restart

   start pm2 restart all
   if "%lang%"=="en" echo Script restarted!
   if "%lang%"=="de" echo Skript wurde neugestartet!
   goto cmd

REM Tool bot
:tool

   start nodemon %~dp0tools\BOT-DEV.js
   if "%lang%"=="en" echo Tool-Bot started!
   if "%lang%"=="de" echo Tool-Bot erfolgreich ausgef�hrt!

   goto cmd

REM Installing
:install

   start npm install discord.js
   if "%lang%"=="en" echo Installing Discord.js
   if "%lang%"=="de" echo Installiere Discord.js

   goto cmd

REM Help
:help

   if "%lang%"=="en" (
      echo Command list
      echo _______________________
      echo � start   - starts the bot
      echo � restart - restarts the bot
      echo � install - installs discord.js
      echo � tool    - starts tool bot
      echo � lang    - changes language
      echo � mode    - changes start mode
   )
   if "%lang%"=="de" (
      echo Befehlsliste
      echo _______________________
      echo � start    - startet den Bot
      echo � neustart - startet den Bot neu
      echo � install  - installiert discord.js
      echo � tool     - startet den Tool-Bot
      echo � sprache  - �ndert Sprache
      echo � modus    - �ndert Startmodus
   )

   goto cmd

REM List of languages
:lang

   cls

   if "%lang%"=="en" echo Language List:
   if "%lang%"=="de" echo Sprachliste:
   echo _______________________
   echo [en] - English
   echo [de] - Deutsch

   set /p inp=
   if "%inp%"=="en" goto enLang
   if "%inp%"=="de" goto deLang

REM English language
:enLang

   set lang=en
   echo en>"%~dp0\settings\lang.cfg"

   goto init

REM German language
:deLang
   
   set lang=de
   echo de>"%~dp0\settings\lang.cfg"

   goto init

REM Startmode
:mode

   cls

   if "%lang%"=="en" echo Startup Modes:
   if "%lang%"=="de" echo Startup-Modi:
   echo _______________________
   echo [pm2]  - PM2
   echo [node] - Node.js

   set /p inp=
   if "%inp%"=="pm2" goto pm2
   if "%inp%"=="node" goto node

REM Pm2
:pm2

   set start=pm2
   echo pm2>"%~dp0\settings\start.cfg"

   goto init

REM Node.js
:node

   set start=node
   echo node>"%~dp0\settings\start.cfg"

   goto init