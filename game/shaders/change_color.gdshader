shader_type canvas_item;

uniform bool whiten = true;
uniform vec4 color : source_color = vec4(1.0);

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	if (whiten) {
		vec3 white = vec3(1,1,1);
		vec3 colored_texture = mix(texture_color.rgb, color.rgb, 1.0);
		COLOR = vec4(colored_texture, texture_color.a);
	} else {
		COLOR = texture_color;
	}
}