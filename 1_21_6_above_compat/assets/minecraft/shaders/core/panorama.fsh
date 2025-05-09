#version 150

#moj_import <minecraft:globals.glsl>
#moj_import <eg_craftmine_title:util.glsl>
#moj_import <eg_craftmine_title:global_defines.glsl>

uniform samplerCube Sampler0;

in vec3 texCoord0;

in float rot;

out vec4 fragColor;

vec4 sampleCodeTexture(vec2 uv) {
    vec2 texSize = vec2(textureSize(Sampler0, 0));
    vec2 nearestUV = (vec2(ivec2(uv * texSize)) + 0.5) / texSize;
    return sample1PanoramaFace(Sampler0, nearestUV);
}
#moj_import <eg_craftmine_title:craftmine_effect.glsl>

void main() {
    if(rougheq(sampleCodeTexture(vec2(0, 0.999)).rgb, MARKER_PIXEL_COLOUR.rgb)) {
        float panoTime = -(rot / 6.2831853) / 1.7;
        fragColor = drawCraftmineEffect(ScreenSize, panoTime);
        return;
    }

    fragColor = texture(Sampler0, texCoord0);
}
