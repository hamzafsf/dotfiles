@echo off
setlocal enabledelayedexpansion
if "%~1"=="" (
    goto :start
) else (
    set num=%~1
    goto :run
)
:start
setlocal enabledelayedexpansion
echo .     ┆[1]--------------------------------------┆
echo .     ┆ v. ┆ Video Download HD                  ┆
echo .     ┆ a. ┆ Audio Downlaod                     ┆
echo .     ┆ i. ┆ Downlaod from id                   ┆
echo .     ┆[A]--------------------------------------┆
echo .     ┆ p. ┆ Playlist Download                  ┆   
echo .     ┆[B]--------------------------------------┆
echo .     ┆ s. ┆ Stream with mpv                    ┆
echo .     ┆ c. ┆ Clip with ffmpeg                   ┆
echo .     ┆-----------------------------------------┆
echo. 
echo [i] command should be [1] / [1][A] / [1][B]
echo [i] example vf or aprs (audio playlist, from range, stream with mpv)
echo.
set /p num=".  the magic word: "
:run
set /p url=".  Url: "
echo.
if "!num!"=="v"    (call :yf-video & call :yo & set command=-f !yf! !yo! & goto :ytdlp)
if "!num!"=="vp"   (call :yf-video & goto :c-playlist)
if "!num!"=="vs"   (call :yf-video & goto :c-mpvstream)
if "!num!"=="vc"   (call :yf-video & call :yo & goto :c-ffmpegclip)

if "!num!"=="a"    (call :yf-audio & call :yo & set command=-f !yf! !yo! & goto :ytdlp)
if "!num!"=="ap"   (call :yf-audio & goto :c-playlist)
if "!num!"=="as"   (call :yf-audio & goto :c-mpvstream)
if "!num!"=="ac"   (call :yf-audio & call :yo & goto :c-ffmpegclip)

if "!num!"=="i"    (call :yf-id & call :yo & set command=!yf! !yo! & goto :ytdlp)
if "!num!"=="is"   (call :yf-id & goto :c-mpvstream)
if "!num!"=="ic"   (call :yf-id & call :yo & goto :c-ffmpegclip)

:ytdlp
set run-command=yt-dlp.exe !command! "!url!"
goto end

:yf-video
set /p yf-q="Default 720p type [y] for 1080p:  "
if "!yf-q!"=="y" (
    set yf="bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]"
) else (
    set yf="22/bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]"
)
EXIT /B 0

:yf-audio
set yf="bestaudio[ext=m4a]"
EXIT /B 0

:yo
set yo=-o C:/Users/%USERNAME%/Downloads/ytdlp/"%%(title)s.%%(ext)s" --no-playlist --no-mtime
EXIT /B 0

:yo-pl
set yo=-o C:/Users/%USERNAME%/Downloads/ytdlp/"%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --no-mtime
EXIT /B 0

:yplrange
echo choose a range [i] ex 4:6,8:-1 "from 4 to 6 and from 8 to the end"
set /p plrx="Playlist range: "
set plr= --playlist-items !plrx!
EXIT /B 0

:yf-id
set /p yt-idx="Skip showing id list (y for YES): "
if not "!yt-idx!"=="y" yt-dlp.exe -F !url!
echo You can choose one id or combine two with + "ex: 233+605"
set /p yf="id: "
EXIT /B 0

:c-playlist
call :yo-pl
set /p pldl="Download All Playlist (y for YES): "
if not "!pldl!"=="y" call :yplrange
set command=-f !yf! !yo! !plr!
goto :ytdlp

:c-ffmpegclip
set /p clip-start=" Clip start: "
set /p clip-end=" Clip end: "
set command=-f !yf! !yo! --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss !clip-start! -to !clip-end!"
goto :ytdlp

:c-mpvstream
echo .   Opening MPV ... 
set run-command=mpv.exe --ytdl-format=!yf! "!url!"
goto end

:end
echo [$] !run-command!
echo.
!run-command!
endlocal
pause
cls
goto start
