#version 450 core

in vec2 fullscreen_texture_position;

uniform sampler2D rendering_texture;

layout(location = 0) out vec4 fragment_color;
#define CONSTANT_1 2.51
#define CONSTANT_2 0.03
#define CONSTANT_3 2.43
#define CONSTANT_4 0.59
#define CONSTANT_5 0.14
const vec3 lumCoeff = vec3(0.2125, 0.7154, 0.0721);
const float brightness=0.02f;
const float contrast =1.2f;
const float  saturation =      1.3f;
const float  redScale  =     0.0f;
const float  greenScale =      0.0f;
const float  blueScale =      0.0f;
const float  redOffset =     0.0f;
const float  greenOffset =      0.0f;
const float  blueOffset =      0.0f;
const float  vignette   =    0.3f;
// PRESET_EDITORS_CHOICE
 /*   {
        0.05f, // brightness
        1.1f, // contrast
        1.3f, // saturation
        0.0f, // red scale
        0.0f, // green scale
        0.0f, // blue scale
        0.0f, // red offset
        0.0f, // green offset
        0.0f, // blue offset
        0.3f // vignette
    }*/
vec3 tone_mapping(vec3 input_color)
{
	return (input_color * ((CONSTANT_1 * input_color) + CONSTANT_2)) / ((input_color * ((CONSTANT_3 * input_color) + CONSTANT_4)) + CONSTANT_5);

	vec3 color = input_color;
    color *= contrast;
    color += vec3(brightness, brightness, brightness);
    vec3 intensity = vec3(dot(color, lumCoeff));
    color = mix(intensity, color, saturation);
    vec3 newColor = (color.rgb - 0.5) * 2.0;
    newColor.r = 2.0 / 3.0 * (1.0 - (newColor.r * newColor.r));
    newColor.g = 2.0 / 3.0 * (1.0 - (newColor.g * newColor.g));
    newColor.b = 2.0 / 3.0 * (1.0 - (newColor.b * newColor.b));
    newColor.r = clamp(color.r + redScale * newColor.r + redOffset, 0.0, 1.0);
    newColor.g = clamp(color.g + greenScale * newColor.g + greenOffset, 0.0, 1.0);
    newColor.b = clamp(color.b + blueScale * newColor.b + blueOffset, 0.0, 1.0);
    color = newColor;
    /*vec2 position = (gl_FragCoord.xy / resolution.xy) - vec2(0.5);
    float len = length(position);
    float vig = smoothstep(0.75, 0.75 - 0.45, len);
    color = mix(color, color * vig, vignette);*/
    return color;
}
void main()
{
	vec4 rendered_color = texture(rendering_texture, fullscreen_texture_position);
	//rendered_color.xyz = 1.0 - exp(-1.0 * rendered_color.xyz);
	rendered_color.xyz = tone_mapping(rendered_color.xyz);

	fragment_color = rendered_color;
}