#language slang 2026
import kitty_custom_shader_types;

// This is vibecoded


static const float3 TRAIL_COLOR = float3(0.55, 0.25, 1.0); // linear RGB
static const float OPACITY = 0.25;    // max strength of the trail (0..1)
static const float DURATION = 0.15;   // trail lifetime in seconds
static const float SOFTNESS = 12.0;   // edge fade in pixels (higher = softer)

static float ease_out10(float x) {
    float y = 1.0 - x;
    float y2 = y * y;
    float y4 = y2 * y2;
    return y4 * y4 * y2;
}

static float blend_smooth(float t) {
    float s = t * t;
    return s / (2.0 * (s - t) + 1.0);
}

static float sdBox(float2 p, float2 center, float2 hext) {
    float2 d = abs(p - center) - hext;
    return length(max(d, float2(0.0))) + min(max(d.x, d.y), 0.0);
}

static float seg(float2 p, float2 a, float2 b, inout float s, float d) {
    float2 e = b - a;
    float2 w = p - a;
    float2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    d = min(d, dot(p - proj, p - proj));
    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    s *= lerp(1.0, -1.0, step(0.5, allCond + noneCond));
    return d;
}

static float sdQuad(float2 p, float2 v0, float2 v1, float2 v2, float2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);
    return s * sqrt(d);
}

static float movementVertexFactor(float2 a, float2 b) {
    float c1 = step(b.x, a.x) * step(a.y, b.y);
    float c2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(c1, c2);
}

public float4
fragment_main(float4 color, KittyTextures t, KittyCustomShaderData d) {
    if (d.cursor_trail_color.a <= 0.0) return color;
    if (d.cursor_trail_age < 0.0) return color;
    float age = clamp(d.cursor_trail_age / DURATION, 0.0, 1.0);
    if (age >= 1.0) return color;

    float easedProgress = ease_out10(blend_smooth(age));
    if (easedProgress <= 0.0) return color;

    float2 pixelDims = float2(d.viewport_size_pixels) * t.viewport.zw;
    float2 px = t.pos * pixelDims;

    float curLeft = d.cursor_trail_edge.x * pixelDims.x;
    float curRight = d.cursor_trail_edge.y * pixelDims.x;
    float curTop = d.cursor_trail_edge.z * pixelDims.y;
    float curBottom = d.cursor_trail_edge.w * pixelDims.y;
    float curWidth = curRight - curLeft;
    float curHeight = curTop - curBottom;
    float2 curCenter = float2((curLeft + curRight) * 0.5, (curTop + curBottom) * 0.5);

    float prevLeft = d.cursor_trail_prev_edge.x * pixelDims.x;
    float prevTop = d.cursor_trail_prev_edge.z * pixelDims.y;
    float prevBottom = d.cursor_trail_prev_edge.w * pixelDims.y;
    float2 prevCenter = float2(
        (d.cursor_trail_prev_edge.x + d.cursor_trail_prev_edge.y) * 0.5 * pixelDims.x,
        (d.cursor_trail_prev_edge.z + d.cursor_trail_prev_edge.w) * 0.5 * pixelDims.y);

    float lineLength = max(length(curCenter - prevCenter), 1.0);
    // 0 at the current cursor, 1 at the far end of the trail
    float alphaModifier = min(length(px - curCenter) / (lineLength * easedProgress), 1.0);

    float vf = movementVertexFactor(curCenter, prevCenter);
    float ivf = 1.0 - vf;
    float2 v0 = float2(lerp(curLeft, curRight, vf), curBottom);
    float2 v1 = float2(lerp(curLeft, curRight, ivf), curTop);
    float2 v2 = float2(prevLeft + curWidth * ivf, prevTop);
    float2 v3 = float2(prevLeft + curWidth * vf, prevBottom);

    float sdfCursor = sdBox(px, curCenter, float2(curWidth, curHeight) * 0.5);
    float sdfTrail = sdQuad(px, v0, v1, v2, v3);

    // Soft edge: full strength SOFTNESS px inside, zero SOFTNESS px outside
    float shape = 1.0 - smoothstep(-SOFTNESS, SOFTNESS, sdfTrail);
    float strength = OPACITY * shape * (1.0 - alphaModifier);

    float3 rgb = lerp(color.rgb, TRAIL_COLOR, strength);
    float4 result = float4(rgb, color.a);

    // Leave the cursor itself untouched
    return lerp(result, color, step(sdfCursor, 0.0));
}
