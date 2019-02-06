shader_type canvas_item;

uniform sampler2D viewport;

void fragment() {
	vec3 c = texture(viewport, UV).rgb;
//	COLOR = vec4(c, 1.0);
	c=vec3(1.0)-c;
	COLOR = vec4(0.0,0.0, 0.0, c.r);
}