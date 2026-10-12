#language slang 2026
import kitty_custom_shader_types;

// Multiplier boost applied to the colors on the cursor line, 0.2 = 20% brighter.
// Has little visible effect on very dark backgrounds, use LIFT for those.
static const float BRIGHTNESS = 0.2;
// Fraction by which colors on the cursor line are blended towards the
// foreground color, which brightens even black backgrounds.
static const float LIFT = 0.06;
// Width in pixels of the soft fade at the top and bottom of the line, 0 for crisp edges.
static const float FEATHER = 0.0;
// Height of a cell divided by its width. Only used for the underline cursor
// shape, whose rectangle does not tell us the height of the line.
static const float CELL_ASPECT = 2.0;
// Restrict the highlight to the active window, otherwise it spans the whole OS window.
static const bool ACTIVE_WINDOW_ONLY = true;

public float4
fragment_main(float4 color, KittyTextures t, KittyCustomShaderData d) {
    // No cursor move has been recorded yet
    if (d.cursor_trail_history_age[0].x < 0.0) return color;
    if (ACTIVE_WINDOW_ONLY) {
        float4 g = d.active_window_geometry;
        if (g.z <= 0.0 || g.w <= 0.0) return color;
        if (t.pos.x < g.x || t.pos.x > g.x + g.z) return color;
    }

    // Work in pixel space so FEATHER is in pixels.
    float2 pixelDims = float2(d.viewport_size_pixels) * t.viewport.zw;
    float y = t.pos.y * pixelDims.y;
    // .x=left, .y=right, .z=top, .w=bottom in UV
    float4 e = d.cursor_trail_history_to[0];
    float bottom = e.w * pixelDims.y;
    float height = (e.z - e.w) * pixelDims.y;
    float width = (e.y - e.x) * pixelDims.x;
    // An underline cursor is shorter than it is wide, estimate the cell height
    if (height < width) height = width * CELL_ASPECT;
    float top = bottom + height;

    float f = max(FEATHER, 1e-3);
    float amount = smoothstep(bottom - f, bottom, y) * (1.0 - smoothstep(top, top + f, y));
    if (amount <= 0.0) return color;

    float3 bright = lerp(color.rgb * (1.0 + BRIGHTNESS), d.foreground.rgb, LIFT);
    return float4(lerp(color.rgb, bright, amount), color.a);
}
