#language slang 2026
import kitty_custom_shader_types;


static const float HEIGHT = 0.035;
static const float4 COLOR = float4(
    255.0/255.0,
    50.0/255.0,
    255/255.0,
    0.5,
);

public bool isActiveWindow(
    KittyTextures textures,
    KittyCustomShaderData data,
) {
    float4 w = data.active_window_geometry;
    float2 pos = textures.pos;
    if (w.z <= 0.0 || w.w <= 0.0) 
        return false;
        
    if (pos.x < w.x || pos.x > w.x + w.z) 
        return false;

    return true;

}

public float4 fragment_main(
    float4 color, 
    KittyTextures textures, 
    KittyCustomShaderData data) {

    if (!isActiveWindow(textures, data)) 
        return color;
    
    float2 bottomLeft = data.cursor_trail_history_to[0].z;

    bool inside = bottomLeft.y > textures.pos.y && 
        bottomLeft.y < textures.pos.y + HEIGHT;

    if (!inside) {
        return color;
    }
   
    float transparency = 0.05 - 0.05 * textures.animation_progress;
    float4 newColor = lerp(COLOR, color, 0.99 - transparency);

    return newColor;
}
