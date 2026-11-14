uv tool run --with "av<19" whisper-ctranslate2 audio.mp4 \
  --model large-v3-turbo \
  --language en \
  --output_format srt \
  --word_timestamps True \
  --max_line_width 42 \
  --max_line_count 2 \
  --vad_filter True \
  --vad_threshold 0.5 \
  --vad_min_silence_duration_ms 500 \
  --vad_max_speech_duration_s 6 \
  --condition_on_previous_text False \
  --hallucination_silence_threshold 2 \
  --no_speech_threshold 0.6

# Notes
# --max_line_width / --max_line_count : short cues (max 2 lines of 42 chars). Both must be set,
#                                       this also splits cues on pauses > 3s so text is not kept on screen in silence.
#                                       Alternative: --max_words_per_line 6 for even shorter cues.
# --word_timestamps                   : required for the line limits; cue ends at the last spoken word.
# --vad_min_silence_duration_ms 500   : cut speech chunks on half-second silences (default 2000).
# --condition_on_previous_text False  : avoids repeated/hallucinated text propagating between segments.
# --hallucination_silence_threshold 2 : skip silent gaps > 2s where Whisper tends to invent text.
# --model large-v3-turbo              : better accuracy than the default "small"; use "small"/"medium" if too slow.
