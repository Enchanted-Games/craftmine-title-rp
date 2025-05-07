#version 150

#moj_import <minecraft:globals.glsl>

uniform samplerCube Sampler0;

in vec3 texCoord0;

out vec4 fragColor;

in vec4 glPos;

void main() {
    fragColor = texture(Sampler0, normalize((-glPos).xyz));
    fragColor = vec4(normalize((-glPos).xyz), 1);
    fragColor = vec4(((gl_FragCoord.xy / ScreenSize) - 0.5) * 2, -glPos.z, 1);
    fragColor = texture(Sampler0, vec3(((gl_FragCoord.xy / ScreenSize) - 0.5) * 2, 1));
    // fragColor = vec4((gl_FragCoord.xy / ScreenSize) - 0.5, 0, 1);
}
