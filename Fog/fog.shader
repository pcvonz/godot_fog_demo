shader_type canvas_item;

uniform sampler2D viewport;
uniform sampler2D cloud_texture;
void fragment() {
	vec3 c = texture(viewport, UV).rgb;
	vec3 cloud = texture(cloud_texture, UV).rgb;
	c=vec3(1.0)-c;
	COLOR = vec4(0.0, 0.0, 0.0, c.r);
}