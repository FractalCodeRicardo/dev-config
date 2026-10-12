#language slang 2026

import kitty_custom_shader_types;

static const float RADIUS = 0.03;
static const float BORDER = 0.002;
static const float DELAY = 2.0;
static const float ANIM_SECONDS = 3600.0;
static const float4 COLOR = float4(
    100.0/255, 
    52.0/255, 
    240.0/255.0, 
    1.0
);

float getAspectRatio(
    KittyTextures textures, 
    KittyCustomShaderData data
) {

  float2 pixelDims = float2(data.viewport_size_pixels) 
    * textures.viewport.zw;

  float aspectRatio = pixelDims.x / pixelDims.y;

  return aspectRatio;
}

public float4 fragment_main(
    float4 color, 
    KittyTextures textures,
    KittyCustomShaderData data
) {

  float elapsed = textures.animation_progress * ANIM_SECONDS;
  if (elapsed < DELAY)
    return color;

  float4 cursor = data.cursor_trail_history_to[0];
  float cx = (cursor.x + cursor.y) / 2.0;
  float cy = (cursor.z + cursor.w) / 2.0;
  float2 center = float2(cx, cy);
  float aspectRatio = getAspectRatio(textures, data);

  float dist = length((textures.pos - center) * 
    float2(aspectRatio, 1.0));

  if (dist > RADIUS + BORDER) {
    return color;
  }

  bool insideBorder = RADIUS < dist &&
    (RADIUS + BORDER) > dist;

  if (insideBorder)  {
    return COLOR; 
  }

  float t = abs(sin(data.wrapped_time(3600)*2.0));
  float4 newColor = lerp(COLOR, color, t);

  return newColor;
    
}
