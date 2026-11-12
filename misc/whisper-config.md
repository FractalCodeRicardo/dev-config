uv tool run --with "av<19" whisper-ctranslate2 audio.mp4 \
  --language en \
  --output_format srt \
  --vad_filter True \
  --vad_max_speech_duration_s 8 \
  --word_timestamps True
