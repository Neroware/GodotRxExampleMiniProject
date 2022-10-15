shader_type canvas_item;

uniform sampler2D background_texture : hint_default_white;
uniform float thresh : hint_range(0.0, 1.0) = 0.1;
uniform float mix_value : hint_range(0.0, 1.0) = 0.5;
uniform vec3 mix_color : source_color = vec3(0.0);

uniform vec3 replaced_color : source_color = vec3(1.0, 0.0, 1.0);

void fragment() {
	float d = distance(COLOR.rgb, replaced_color);
	float r = float(d < thresh);
	vec4 sampled = texture(background_texture, SCREEN_UV);
	COLOR = (1.0 - r) * COLOR + vec4(r * mix(sampled.rgb, mix_color, mix_value), COLOR.a);
}
