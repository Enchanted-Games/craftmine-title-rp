#version 150

#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
out vec3 texCoord0;

out float rot;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    texCoord0 = Position;

    rot = atan(ModelViewMat[0][2], ModelViewMat[0][0]);
}
