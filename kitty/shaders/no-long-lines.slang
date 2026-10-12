#language slang 2026
import kitty_custom_shader_types;

static const float THRESHOLD = 0.8; 

static const float4 COLOR = float4(
    5.0/255,
    0.0/255,
    5.0/255.0,
    1
);
public float4 fragment_main(
    float4 color,
    KittyTextures textures,
    KittyCustomShaderData data) {

    float4 cursor = data.cursor_trail_history_to[0]; 
    float cursorX = (cursor.x + cursor.y) / 2.0; 

    if (cursorX <= THRESHOLD) {
        return color;
    }

    if (textures.pos.x < THRESHOLD) {
        return color;
    }

    return lerp(color, COLOR, 0.9); 
}
