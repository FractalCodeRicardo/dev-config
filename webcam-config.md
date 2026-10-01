sudo modprobe v4l2loopback exclusive_caps=1

v4l2-ctl --list-devices

scrcpy \
  --video-source=camera \
  --camera-facing=back \
  --camera-size=1920x1080 \
  --video-bit-rate=20M \
  --v4l2-sink=/dev/video4 \
  --no-audio
