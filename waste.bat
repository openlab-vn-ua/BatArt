@echo off
setlocal

Echo Free space waste utility.
Echo Will waste your free space on %CD% with trash.

Echo Warming up...

:: Windows will add CR+LF after output of echo command 
set WASTE_61=4PgWKRU3BLEWrg7ZO1iw5t8jCyaE5Kaexn4W6z002vXBfvMHaT572zDYT0ObHr
echo %WASTE_61%>waste_1K.wat
for /l %%i in (2,1,16) do echo %WASTE_61%>>waste_1K.wat
Echo Fill 1K

copy /b waste_1K.wat+waste_1K.wat+waste_1K.wat+waste_1K.wat waste_4K.wat > nul || (goto done) & Echo Fill 4K   
copy /b waste_4K.wat+waste_4K.wat+waste_4K.wat+waste_4K.wat waste16K.wat > nul || (goto done) & Echo Fill 16K  
copy /b waste16K.wat+waste16K.wat+waste16K.wat+waste16K.wat waste64K.wat > nul || (goto done) & Echo Fill 64K  
copy /b waste64K.wat+waste64K.wat+waste64K.wat+waste64K.wat wasteX6K.wat > nul || (goto done) & Echo Fill 256K 
copy /b wasteX6K.wat+wasteX6K.wat+wasteX6K.wat+wasteX6K.wat waste_1M.wat > nul || (goto done) & Echo Fill 1M   
Echo Deleting small warming up files...
del waste??K.wat

Echo Preparing 1st GB of trash...
copy /b waste_1M.wat+waste_1M.wat+waste_1M.wat+waste_1M.wat waste_4M.wat > nul || (goto done) & Echo Fill 4M  
copy /b waste_4M.wat+waste_4M.wat+waste_4M.wat+waste_4M.wat waste16M.wat > nul || (goto done) & Echo Fill 16M 
copy /b waste16M.wat+waste16M.wat+waste16M.wat+waste16M.wat waste64M.wat > nul || (goto done) & Echo Fill 64M 
copy /b waste64M.wat+waste64M.wat+waste64M.wat+waste64M.wat wasteX6M.wat > nul || (goto done) & Echo Fill 256M
copy /b wasteX6M.wat+wasteX6M.wat+wasteX6M.wat+wasteX6M.wat waste_1G.wat > nul || (goto done) & Echo Fill 1G

::Echo Gigawork
::copy /b waste_1G.wat+waste_1G.wat+waste_1G.wat+waste_1G.wat waste_4G.wat > nul || (goto done) & Echo Fill 4G
::copy /b waste_4G.wat+waste_4G.wat+waste_4G.wat+waste_4G.wat waste16G.wat > nul || (goto done) & Echo Fill 16G
::copy /b waste16G.wat+waste16G.wat+waste16G.wat+waste16G.wat waste64G.wat > nul || (goto done) & Echo Fill 64G
::copy /b waste64G.wat+waste64G.wat+waste64G.wat+waste64G.wat wasteX6G.wat > nul || (goto done) & Echo Fill 256G
::copy /b wasteX6G.wat+wasteX6G.wat+wasteX6G.wat+wasteX6G.wat waste_1T.wat > nul || (goto done) & Echo Fill 1T

::Echo Terawork
::copy /b waste_1T.wat+waste_1T.wat+waste_1T.wat+waste_1T.wat waste_4T.wat > nul || (goto done) & Echo Fill 4T
::copy /b waste_4T.wat+waste_4T.wat+waste_4T.wat+waste_4T.wat waste16T.wat > nul || (goto done) & Echo Fill 16T
::copy /b waste16T.wat+waste16T.wat+waste16T.wat+waste16T.wat waste64T.wat > nul || (goto done) & Echo Fill 64T
::copy /b waste64T.wat+waste64T.wat+waste64T.wat+waste64T.wat wasteX6T.wat > nul || (goto done) & Echo Fill 256T
::copy /b wasteX6T.wat+wasteX6T.wat+wasteX6T.wat+wasteX6T.wat waste_1P.wat > nul || (goto done) & Echo Fill 1P

Echo Running mainstream...
::Rem up 100T
set MAX_G=102400
for /l %%i in (2,1,%MAX_G%) do (
  if %%i LSS 10 (
    copy /b wasteX6M.wat+wasteX6M.wat+wasteX6M.wat+wasteX6M.wat waste_%%iG.wat > nul
  ) else (
    copy /b wasteX6M.wat+wasteX6M.wat+wasteX6M.wat+wasteX6M.wat waste%%iG.wat > nul
  )
  if errorlevel 1 goto done
  echo Fill %%iG
)
goto finish

:finish
Echo STOP! There are %MAX_G%G, written, but disk is not full.
Echo We decide to stop as it may be kind of error (or you have huge HDD)
Echo Delete all waste files...
del waste*.wat
exit /b 1
goto :eof

:done
Echo DONE? Cannot write to disk anymore, probably task is completed or aborted
Echo Delete all waste files...
del waste*.wat
exit /b 0
goto :eof

