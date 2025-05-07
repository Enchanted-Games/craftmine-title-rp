#version 150

#moj_import <minecraft:globals.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>

in vec3 Position;
out vec3 texCoord0;

out vec4 glPos;

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
    glPos = ProjMat * ModelViewMat * vec4(Position, 1.0);

    float aspect = ScreenSize.x / ScreenSize.y;
    texCoord0 = (ProjMat * vec4(Position * aspect, 1.0)).xyz;
}
