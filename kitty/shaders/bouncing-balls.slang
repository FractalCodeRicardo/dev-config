#language slang 2026


// This was vibecoded
import kitty_custom_shader_types;

static const int NUM_BALLS = 9;
static const float BALL_RADIUS = 0.07f;          // in units of window height
static const float BALL_INTENSITY = 0.55f;       // overall ball brightness
static const float BLACK_BLEND_THRESHOLD = 0.15f; // terminal pixels brighter than this keep their color
static const float TIME_SCALE = 1.0f;
// Set to 1.0f if the balls fall toward the top of the window instead of the bottom
static const float FLIP_Y = 0.0f;

float
hash11(float n) {
    return frac(sin(n * 127.1f) * 43758.5453f);
}

// Triangle wave in [0,1] with period 1
float
tri(float x) {
    return abs(frac(x) * 2.0f - 1.0f);
}

float3
palette(float t) {
    return 0.5f + 0.5f * cos(6.28318f * (t + float3(0.0f, 0.33f, 0.67f)));
}

public float4
fragment_main(float4 color, KittyTextures t, KittyCustomShaderData d) {
    float2 pixelDims = float2(d.viewport_size_pixels) * t.viewport.zw;
    float aspect = pixelDims.x / max(pixelDims.y, 1.0f);

    float time = d.wrapped_time(3600u) * TIME_SCALE;

    // Space where the window height is 1 and the width is `aspect`, y pointing up
    float up = lerp(t.pos.y, 1.0f - t.pos.y, FLIP_Y);
    float2 p = float2(t.pos.x * aspect, up);

    float4 terminalColor = t.backbuffer.Sample(t.pos);

    // Dark base with a faint vertical gradient
    float3 col = float3(0.03f, 0.03f, 0.06f) * (0.7f + 0.6f * up);

    float3 balls = float3(0.0f);

    [ForceUnroll]
    for (int i = 0; i < NUM_BALLS; i++) {
        float fi = float(i);
        float r = BALL_RADIUS * (0.7f + 0.6f * hash11(fi + 1.0f));

        // Horizontal: triangle wave bounces between the side walls
        float speedX = 0.05f + 0.08f * hash11(fi + 2.0f);
        float tx = tri(time * speedX + hash11(fi + 3.0f));
        float x = r + tx * (aspect - 2.0f * r);

        // Vertical: parabolic arc that touches the floor at each period boundary
        float period = 1.1f + 1.4f * hash11(fi + 4.0f);
        float f = frac(time / period + hash11(fi + 5.0f));
        float h = 4.0f * f * (1.0f - f);
        float apex = 0.45f + 0.45f * hash11(fi + 6.0f);
        float y = r + h * (apex - r);

        // Squash slightly around floor contact
        float squash = 1.0f - 0.25f * smoothstep(0.12f, 0.0f, f) - 0.25f * smoothstep(0.88f, 1.0f, f);
        float2 dd = p - float2(x, y);
        dd.y /= squash;
        dd.x *= squash;

        float dist = length(dd);
        float body = smoothstep(r, r - 0.004f, dist);

        // Simple lighting with the highlight toward the upper left
        float2 n = dd / r;
        float3 normal = normalize(float3(n, sqrt(max(0.0f, 1.0f - dot(n, n)))));
        float light = clamp(0.6f + 0.4f * dot(normal, normalize(float3(-0.5f, 0.6f, 0.6f))), 0.0f, 1.0f);

        // Soft glow around each ball
        float glow = 0.015f / (dist * dist + 0.02f) * r;

        float3 c = palette(hash11(fi + 7.0f));
        balls += c * (body * light + glow * 0.15f);
    }

    col += balls * BALL_INTENSITY;

    // Same blending approach as the fireworks example: show the effect where the
    // terminal is dark, keep the terminal pixel where there is text.
    float termLum = dot(terminalColor.rgb, float3(0.299f, 0.587f, 0.114f));
    float textPreserve = 1.0f - smoothstep(BLACK_BLEND_THRESHOLD, BLACK_BLEND_THRESHOLD + 0.2f, termLum);
    float3 blended = lerp(terminalColor.rgb, col, textPreserve);

    return float4(blended, terminalColor.a);
}
