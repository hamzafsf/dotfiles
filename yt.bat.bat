@echo off
setlocal enabledelayedexpansion
if "%~1"=="" (
    goto :start
) else (
    set num=%~1
    set url=%~2
    goto :run
)
:start
setlocal enabledelayedexpansion
echo ┆[1]--------------------------------------┆
echo ┆ v. ┆ Video Download HD                  ┆
echo ┆ vf.┆ for FHD                            ┆
echo ┆ a. ┆ Audio Downlaod                     ┆
echo ┆ i. ┆ Downlaod from id                   ┆
echo ┆ ix.┆ skip showing id list               ┆
echo ┆[2]--------------------------------------┆
echo ┆ p. ┆ Playlist Download                  ┆   
echo ┆ pb.┆ for choosing the beginning (1-end) ┆   
echo ┆ pr.┆ for choosing the range (1-2,5,7)   ┆   
echo ┆[3]--------------------------------------┆
echo ┆ s. ┆ Stream with mpv                    ┆
echo ┆ c. ┆ Clip with ffmpeg                   ┆
echo ┆ u. ┆ Print url                          ┆
echo ┆-----------------------------------------┆
echo. 
echo [i] command should be [1] / [1][2] / [1][3] / [1][2][3] 
echo [i] example vf or aprs (audio playlist from range stream with mpv)
echo.
set /p num=.  the magic word: 
set url=https://www.youtube.com/watch?v=P5TmbqJxHFg
::set /p url=.  Url: 
echo.
:run
if "!num!"=="v"    (call :yf720 & call :yo & set command=-f !yf! !yo! & goto ytdlp)
if "!num!"=="vp"   (call :yf720 & call :yoplaylist & set command=-f !yf! !yo! & goto ytdlp)
if "!num!"=="vpb"  (call :yf720 & call :yoplaylist & call :yplstart & set command=-f !yf! !yo! !plr! & goto ytdlp)
if "!num!"=="vpr"  (call :yf720 & call :yoplaylist & call :yplrange & set command=-f !yf! !yo! !plr! & goto ytdlp)
if "!num!"=="vs"   (call :yf720 & call :yo & mpv --ytdl-format=!yf! "!url!" & goto end)
if "!num!"=="vc"   (call :yf720 & call :yo & call :ffmpegclip & goto ytdlp)

if "!num!"=="vf"   (call :yf1080 & call :yo & set command=-f !yf! !yo! & goto ytdlp)
if "!num!"=="vfp"  (call :yf1080 & call :yoplaylist & set command=-f !yf! !yo! & goto ytdlp)
if "!num!"=="vfpb" (call :yf1080 & call :yoplaylist & call :yplstart & set command=-f !yf! !yo! !plr! & goto ytdlp)
if "!num!"=="vfpr" (call :yf1080 & call :yoplaylist & call :yplrange & set command=-f !yf! !yo! !plr! & goto ytdlp)
if "!num!"=="vfs"  (call :yf1080 & call :yo & mpv --ytdl-format=!yf! "!url!" & goto end)
if "!num!"=="vfc"  (call :yf1080 & call :yo & call :ffmpegclip & goto ytdlp)

if "!num!"=="a"    (call :yfaudio & call :yo & set command=-f !yf! !yo! & goto ytdlp)
if "!num!"=="ap"   (call :yfaudio & call :yoplaylist & set command=-f !yf! !yo! & goto ytdlp)
if "!num!"=="apb"  (call :yfaudio & call :yoplaylist & call :yplstart & set command=-f !yf! !yo! !plr! & goto ytdlp)
if "!num!"=="apr"  (call :yfaudio & call :yoplaylist & call :yplrange & set command=-f !yf! !yo! !plr! & goto ytdlp)
if "!num!"=="as"   (call :yfaudio & call :yo & mpv.exe --ytdl-format=!yf! "!url!" & goto end)
if "!num!"=="ac"   (call :yfaudio & call :yo & call :ffmpegclip & goto ytdlp)

if "!num!"=="i"    (call :yfid & call :yo & set command=!yf! !yo! & goto ytdlp)
if "!num!"=="is"   (call :yfid & call :yo & mpv.exe --ytdl-format=!yf! & goto end)
if "!num!"=="ic"   (call :yfid & call :yo & ffmpegclip & goto ytdlp)

if "!num!"=="ix"   (call :yfidx & call :yo & set command=!yf! !yo! & goto ytdlp)
if "!num!"=="ixs"  (call :yfidx & call :yo & mpv.exe --ytdl-format=!yf! & goto end)
if "!num!"=="ixc"  (call :yfidx & call :yo & ffmpegclip & goto ytdlp)

:ytdlp
echo [$] yt-dlp.exe !command! "!url!"
::yt-dlp.exe !command! "!url!"
goto end

:yf720
set yf="22/bestvideo[height<=720][ext=mp4]+bestaudio[ext=m4a]"
EXIT /B 0

:yf1080
set yf="bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]"
EXIT /B 0

:yfaudio
set yf="bestaudio[ext=m4a]"
EXIT /B 0

:yo
set yo=-o C:/Users/%USERNAME%/Downloads/"%%(title)s.%%(ext)s" --no-playlist --no-mtime
EXIT /B 0

:yoplaylist
set yo=-o C:/Users/%USERNAME%/Downloads/"%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --no-mtime
EXIT /B 0

:yplstart
set /p plrx=Playlist start: 
set plr= --playlist-start !plrx!
EXIT /B 0

:yplrange
set /p plrx=Playlist range: 
set plr= --playlist-items !plrx!
EXIT /B 0

:ffmpegclip
set /p clip-start= Clip start: 
set /p clip-end= Clip end: 
set command=-f !yf! !yo! --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss !clip-start! -to !clip-end!"
goto ytdlp

:yfid
yt-dlp.exe -F !url!
:yfidx
set /p yf=id: 

:end
endlocal
pause
cls
goto start