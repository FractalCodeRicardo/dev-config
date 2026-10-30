sudo modprobe v4l2loopback exclusive_caps=1

v4l2-ctl --list-devices

scrcpy \
  --video-source=camera \
  --camera-facing=back \
  --camera-size=1920x1080 \
  --video-bit-rate=20M \
  --v4l2-sink=/dev/video4 \
  --no-audio

# OBS (no Streamfog)

paru -S obs-shaderfilter obs-composite-blur obs-backgroundremoval

Source: Video Capture Device (V4L2) -> /dev/video4

Filters on the source (top -> bottom):
1. Color Correction: slight brightness / saturation / warmth
2. User-defined shader (obs-shaderfilter): skin smoothing, low strength
3. Sharpen: small amount to restore eyes / hair detail
4. Background Removal (optional): blur or replace background

Not replaceable on Linux: face-tracked AR (slim face, big eyes, masks)
