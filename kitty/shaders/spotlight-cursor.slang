#language slang 2026
import kitty_custom_shader_types;

static const float2 SIZE = float2(0.3, 0.25);
static const float SOFTNESS = 0.08; 

static const float4 COLOR = float4(
    5.0/255,
    0.0/255,
    5.0/255.0,
    1
);

float getAspectRatio(
    KittyTextures textures,
    KittyCustomShaderData data
) {
    float2 pixelDims = float2(data.viewport_size_pixels)
        * textures.viewport.zw;
    return pixelDims.x / pixelDims.y;
}

public float4 fragment_main(
    float4 color,
    KittyTextures textures,
    KittyCustomShaderData data
) {
    float4 cursor = data.cursor_trail_history_to[0];  
    float2 center = float2(
        (cursor.x + cursor.y) / 2.0,
        (cursor.z + cursor.w) / 2.0);

    float aspectRatio = getAspectRatio(textures, data);

    float2 q = (abs(textures.pos - center) - SIZE) * 
        float2(aspectRatio, 1.0);

    float dist = length(max(q, float2(0.0)));

    float intensity = smoothstep(0.0, SOFTNESS, dist);
    intensity = min(intensity, 0.93);
    return lerp(color, COLOR, intensity);
}
