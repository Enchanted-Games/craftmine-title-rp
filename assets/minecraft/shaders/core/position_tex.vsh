#version 150

in vec3 Position;
in vec2 UV0;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec2 texCoord0;
out float rot;
out vec4 glPos;

void main() {
    texCoord0 = UV0;

    gl_Position = ProjMat * vec4(Position, 1.0); // dont multiply by model view mat so the panorama doesnt rotate

    rot = atan(ModelViewMat[0][2], ModelViewMat[0][0]);
    glPos = gl_Position;
}
