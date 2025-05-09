#version 150

#moj_import <eg_craftmine_title:util.glsl>
#moj_import <eg_craftmine_title:global_defines.glsl>

uniform sampler2D Sampler0;

in vec3 Position;
in vec2 UV0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec2 texCoord0;
out float rot;
out vec4 glPos;
flat out int isPano;

vec2 CORNERS[4] = vec2[4](vec2(1, -1), vec2(1, 1), vec2(-1, 1), vec2(-1, -1));

void main() {
    texCoord0 = UV0;

    isPano = 0; // 0 = use vanilla rendering, 1 = use matrix rendering, 2 = discard
    ivec2 sampler0Size = textureSize(Sampler0, 0);
    if(sampler0Size.x == 128 && sampler0Size.y == 128) {
        if(rougheq(texelFetch(Sampler0, ivec2(0, 127), 0), MARKER_PIXEL_COLOUR)) isPano = 1;
    }
    else if(sampler0Size.x == 1 && sampler0Size.y == 1) {
        if(rougheq(texture(Sampler0, vec2(0.0, 0.0)), MARKER_PIXEL_COLOUR)) isPano = 2;
    }

    if(isPano > 0) {
        // stretch one of the panorama planes to cover the screen
        float w = (ProjMat * vec4(Position, 1.0)).w;
        gl_Position = vec4(CORNERS[gl_VertexID % 4] * w, 0, w);
    } else {
        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    }

    rot = atan(ModelViewMat[0][2], ModelViewMat[0][0]);
    glPos = gl_Position;
}
