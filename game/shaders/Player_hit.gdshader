shader_type canvas_item;

uniform bool whiten = true;
uniform float time = 0.0;
uniform float alpha = 3.0;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (whiten && sin(time*alpha) < 0.0) {
		vec3 white = vec3(1,1,1);
		vec3 whitened_texture_rgb = mix(texture_color.rgb, white, 1.0);
		COLOR = vec4(whitened_texture_rgb, texture_color.a);
	} else {
		COLOR = texture_color;
	}
}