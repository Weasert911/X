shader_type sky;

uniform vec3 sky_color : source_color = vec3(0.4, 0.6, 0.9);
uniform vec3 cloud_color : source_color = vec3(1.0);
uniform float cloud_speed = 0.01;
uniform float cloud_scale = 3.0;

void sky() {
    vec2 uv = EYEDIR.xz * cloud_scale;

    uv.x += TIME * cloud_speed;

    float noise = sin(uv.x) * cos(uv.y);

    float clouds = smoothstep(0.2, 0.5, noise);

    vec3 col = mix(sky_color, cloud_color, clouds);

    COLOR = col;
}
