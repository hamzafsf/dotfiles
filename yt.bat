@echo off
:start
echo.
echo -------------------------------------------------------------------------
echo ! 1. ! Downlaod single video (1f for fhd) !                             !
echo ! 2. ! Download single audio              !                             !
echo !-----------------------------------------------------------------------!
echo ! 3. ! Download playlist video            !                             !
echo ! 31.! Download playlist video from start ! (1-end)                     !
echo ! 32.! Download playlist video from range ! (1-2,5,7)                   !
echo !-----------------------------------------------------------------------!
echo ! 4. ! Download playlist audio            !                             !
echo ! 41.! Download playlist audio from start ! (1-end)                     !
echo ! 42.! Download playlist audio from range ! (1-2,5,7)                   !
echo !-----------------------------------------------------------------------!
echo ! 5. ! Show all and download              ! (IDs) you can merge two IDs !
echo ! 51.! Stream with mpv from ID            ! (51s. skip showing all IDs) !
echo ! 52.! Print url from ID                  ! (52s. skip showing all IDs) !
echo !-----------------------------------------------------------------------!
echo ! 6. ! Clip and download with ffmpeg      !                             !
echo ! 7. ! Update yt-dlp                      !                             !
echo -------------------------------------------------------------------------
echo.
set /p num=.  choose a number: 
set /p url=.  Url: 
echo.
if %num%==1    goto download-single-video
if %num%==1f   goto download-single-video-fhd
if %num%==2    goto download-single-audio
if %num%==3    goto download-playlist-video
if %num%==31   goto downlaod-playlist-video-from-start
if %num%==32   goto downlaod-playlist-video-from-range
if %num%==4    goto download-playlist-audio
if %num%==41   goto downlaod-playlist-audio-from-start
if %num%==42   goto downlaod-playlist-audio-from-range
if %num%==5    goto show-all
if %num%==51   goto stream-mpv
if %num%==51s  goto stream-mpv-skip
if %num%==52   goto print-url
if %num%==52s  goto print-url-skip
if %num%==6    goto clip-and-download
if %num%==7    goto update-yt-dlp

::1
:download-single-video
	echo Command: $ yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o ./"%%(title)s.%%(ext)s" --no-playlist --no-mtime "%url%"
	echo.
	yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o ./"%%(title)s.%%(ext)s" --no-playlist --no-mtime "%url%"
	goto exit
	::1f
	:download-single-video-fhd
	echo Command: $ yt-dlp.exe -f "bestvideo[height<=?1080][ext=mp4]+bestaudio[ext=m4a]" -o ./"%%(title)s.%%(ext)s" --no-playlist --no-mtime "%url%"
	echo.
	yt-dlp.exe -f "bestvideo[height<=?1080][ext=mp4]+bestaudio[ext=m4a]" -o ./"%%(title)s.%%(ext)s" --no-playlist --no-mtime "%url%"
	goto exit
	

::2
:download-single-audio
	echo Command: $ yt-dlp.exe -f bestaudio[ext=m4a] -o "./%%(title)s.%%(ext)s" --no-playlist --no-mtime "%url%"
	echo.
	yt-dlp.exe -f bestaudio[ext=m4a] -o "./%%(title)s.%%(ext)s" --no-playlist --no-mtime "%url%"
	goto exit

::3
:download-playlist-video
	echo Command: $ yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --no-mtime "%url%"
	echo.
	yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --no-mtime "%url%"
	goto exit

::31
:downlaod-playlist-video-from-start
	echo Command: $	yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-start %playlist-start% --no-mtime "%url%"
	echo.
	set /p playlist-start=Playlist start: 
	yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-start %playlist-start% --no-mtime "%url%"
	goto exit

::32
:downlaod-playlist-video-from-range
	echo Command: $ yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-items %playlist-items% --no-mtime "%url%"
	echo.
	set /p playlist-items=Playlist range: 
	yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-items %playlist-items% --no-mtime "%url%"
	goto exit

::4
:download-playlist-audio
	echo Command: $ yt-dlp.exe -f "bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --no-mtime "%url%"
	echo.
	yt-dlp.exe -f "bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --no-mtime "%url%"
	goto exit

::41
:downlaod-playlist-audio-from-start
	echo Command: $ yt-dlp.exe -f "bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-start %playlist-start% --no-mtime %url%
	echo.
	set /p playlist-start=Playlist start: 
	yt-dlp.exe -f "bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-start %playlist-start% --no-mtime %url%
	goto exit

::42
:downlaod-playlist-audio-from-range
	echo Command: $ yt-dlp.exe -f "bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-items %playlist-items% --no-mtime "%url%"
	echo.
	set /p playlist-items=Playlist range: 
	yt-dlp.exe -f "bestaudio[ext=m4a]" -o "./%%(playlist)s/%%(playlist_index)s.%%(title)s.%%(ext)s" --yes-playlist --playlist-items %playlist-items% --no-mtime "%url%"
	goto exit

::5
:show-all
	echo Command: $ yt-dlp.exe -F --no-playlist "%url%"
	echo.
	yt-dlp.exe -F --no-playlist "%url%"
	set /p id=id: 
	yt-dlp.exe -f %id% --no-playlist "%url%"
	goto exit

::51
:stream-mpv
	echo Command: $ yt-dlp.exe -F %url%
	echo.
	yt-dlp.exe -F %url%
	::51s
	:stream-mpv-skip
		set /p id=id: 
		echo Command: $ mpv.exe --ytdl-format=%id% "%url%"
		echo.
		mpv.exe --ytdl-format=%id%  "%url%"
		goto exit

::52
:print-url
	echo Command: $ yt-dlp.exe -F --no-playlist %url%
	echo.
	yt-dlp.exe -F --no-playlist %url%
	:print-url-skip
		set /p id=id:
		echo Command: $ yt-dlp.exe -g -f %id% --no-playlist "%url%"
		echo.
		yt-dlp.exe -g -f %id% --no-playlist "%url%"
		goto exit

::6
:clip-and-download
	echo Command: $ yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o ./"%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %clip-start% -to %clip-end%" --no-playlist --no-mtime "%url%"
	echo.
	set /p clip-start= Clip start: 
	set /p clip-end= Clip end: 
	yt-dlp.exe -f "22/bestvideo[height<=?720][ext=mp4]+bestaudio[ext=m4a]" -o ./"%%(title)s.%%(ext)s" --external-downloader ffmpeg --external-downloader-args "ffmpeg_i:-ss %clip-start% -to %clip-end%" --no-playlist --no-mtime "%url%"
	goto exit

::7
:update-yt-dlp
	echo Command: $ yt-dlp.exe -U
	echo.
	yt-dlp.exe -U
	goto exit

:exit
pause
goto start



