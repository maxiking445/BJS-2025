shader_type canvas_item;

uniform vec4 water_color : source_color = vec4(0.0, 0.4, 0.7, 0.8);
uniform float wave_speed = 1.5;
uniform float wave_amplitude_x = 0.015;
uniform float wave_amplitude_y = 0.007;
uniform float wave_length = 20.0;

void fragment() {
    float t = TIME * wave_speed;


    float wave_x = sin(UV.x * wave_length + t) * wave_amplitude_x
                 + sin(UV.x * (wave_length * 0.5) + t * 1.3) * (wave_amplitude_x * 0.5);

    float wave_y = cos(UV.y * wave_length * 2.0 + t * 1.1) * wave_amplitude_y;

    vec2 uv = UV;
    uv.x += wave_x;
    uv.y += wave_y;

    vec4 tex_color = texture(TEXTURE, uv);


    if (tex_color.rgb == vec3(0.0)) {
        discard;
    }

    COLOR = vec4(water_color.rgb * tex_color.rgb, tex_color.a * water_color.a);
}