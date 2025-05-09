#version 150

uniform sampler2D Sampler0;
uniform vec4 ColorModulator;

in vec2 texCoord0;
in float rot;
in vec4 glPos;
flat in int isPano;

out vec4 fragColor;

vec4 sampleCodeTexture(vec2 uv) {
    return texture(Sampler0, uv);
}
#moj_import <eg_craftmine_title:craftmine_effect.glsl>

void main() {
    if(isPano > 0) {
        if(isPano == 2) discard;
        // modified to work on 1.21.5
        // ScreenSize and GameTime is calculated because using the uniform is unstable
        // (if youre reading this, you should vote for MC-296043 on the minecraft bug tracker)
        vec2 ScreenPos = (glPos.xy / glPos.w) * 0.5 + 0.5;
        vec2 ScreenSize = round(gl_FragCoord.xy / ScreenPos);
        float GameTime = -(rot / 6.2831853) / 1.7;

        fragColor = drawCraftmineEffect(ScreenSize, GameTime) * ColorModulator;
        return;
    }

    vec4 color = texture(Sampler0, texCoord0);
    if (color.a == 0.0) {
        discard;
    }
    fragColor = color * ColorModulator;
}
