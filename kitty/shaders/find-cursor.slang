#language slang 2026

import kitty_custom_shader_types;

static const float RADIUS = 0.25;
public float4
fragment_main(
    float4 color,
    KittyTextures textures,
    KittyCustomShaderData data) {

   // if (data.cursor_trail_corners_y.x == 0) {
   //  return color;
   // }
   //
   //  float2 pixelDims = float2(data.viewport_size_pixels) 
   //  * textures.viewport.zw;
   //  float aspectRatio = pixelDims.x / pixelDims.y;
   //
   //  float cx = data.cursor_trail_corners_x.x;
   //  float cy = data.cursor_trail_corners_y.x;
   //  float2 center = float2(cx, cy);

    textures.persist.Sample(float2(0,0)).xy = float2(0.5, 0.5)

    float dist = length((textures.pos - center) * float2(aspectRatio, 1.0));

    if (dist > RADIUS ) { 
        return color;
    }

    return float4(
        color.r,
        1,
        color.b,
        0.5);
}
