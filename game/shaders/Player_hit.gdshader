shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1.);
uniform float flash_pct: hint_range(0.0, 1.0) = 0.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 current_color = COLOR;
	vec4 apply_flash_color = flash_color;
	apply_flash_color.a = current_color.a;
	COLOR = mix(current_color, apply_flash_color, flash_pct);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
