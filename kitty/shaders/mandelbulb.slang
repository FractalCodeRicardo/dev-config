#language slang 2026

import kitty_custom_shader_types;
 
static const float FACTOR = 2;

float3 rotateY(float3 p, float angle) {
  float c = cos(angle);
  float s = sin(angle);

  return float3(
    c * p.x - s * p.z,
    p.y,
    s * p.x + c * p.z
  );
}

public float getAspectRatio(
  KittyCustomShaderData d,
  KittyTextures t
) {
  float2 dims = float2(d.viewport_size_pixels) * 
    t.viewport.zw;
  float aspectRatio = dims.x / dims.y;
  
  return aspectRatio;
}

float distance(float3 p, float angle) {
  p = rotateY(p, angle);
  int max_iter = 16;
  int i = 0;
  float radius = 0.0;
  float3 zn = float3(p);
  float d = 1.0;
  float power = 8.0;

  while (i < max_iter) {
    radius = length(zn);

    if (radius > 1.5) {
      break;
    }

    // znext = zn + C
    float theta = atan2(length(zn.xy), zn.z);
    float phi = atan2(zn.y, zn.x);
    float r = pow(radius, power);

    float sint = sin(theta * power);
    zn.x = r * sint * cos(phi * power);
    zn.y = r * sint * sin(phi * power);
    zn.z = r * cos(theta * power);

    zn += p;
    
    // derivate
    d = pow(radius, power - 1) * power * d + 1.0;

    i += 1;
  }

  return 0.5 * log(radius) * radius / d;
}

bool march(float3 origin, float3 dir, float angle, out float3 res) {
  int max_iter = 30;
  int i = 0;
  float depth = 0.0;
  float3 ray;

  while (i < max_iter) {
    ray = origin + depth * dir;

    float d = distance(ray, angle);

    if (d < 0.001)
      break;

    depth += d;

    i += 1;
  }

  res = ray;

  if (i == max_iter)
    return false;

  return true;
}

float3 gradient(float3 p, float angle) {
  float e = 0.001;

  float3 n = float3(
      distance(p + float3(e, 0, 0), angle) - distance(p - float3(e, 0, 0), angle),
      distance(p + float3(0, e, 0), angle) - distance(p - float3(0, e, 0), angle),
      distance(p + float3(0, 0, e), angle) - distance(p - float3(0, 0, e), angle)
    );

  return normalize(n);
}

public float4 fragment_main(
    float4 color,
    KittyTextures texture,
    KittyCustomShaderData data) {

    float elapsed = texture.animation_progress * 3600;
    if (elapsed < 3)
      return color;

    float angle = data.wrapped_time(3600u) * 0.5;
    float aspectRatio = getAspectRatio(data, texture);
    float2 uv = texture.pos;
    uv = -1 + 2* uv;
    uv.x *= aspectRatio; 

    float3 camera = float3(0,0,2.5); 
    float3 target = float3(uv, 1.5);
    float3 dir = target - camera;

    dir = normalize(dir);

    float3 p;
    if(!march(camera, dir, angle, p))
      return color;

    float3 dp = gradient(p, angle);

    float3 light = normalize(float3(-1.0, 1.0, 1.0));
    float diffuse = max(dot(dp, light), 0.0);
    float brightness = 0.08 + diffuse * 0.92;

    float4 combined = lerp(color, brightness, 0.6);
    return combined;
}
