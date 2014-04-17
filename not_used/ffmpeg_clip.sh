# script to clip a specific section -ss is start time -t is duration
ffmpeg -ss hh:mm:ss -t 00:00:01 -i <file> -acodec copy -vcodec copy <clip>
