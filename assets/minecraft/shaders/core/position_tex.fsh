#version 150

uniform sampler2D Sampler0;
uniform vec4 ColorModulator;

in vec2 texCoord0;
in float rot;
in vec4 glPos;
flat in int isPano;

out vec4 fragColor;

float random (float v) {
    return fract(sin(v) * 43758.5453123);
}

void main() {
    if(isPano > 0) {
        if(isPano == 2) discard;
        // modified to work on 1.21.5
        // ScreenSize and GameTime is calculated because using the uniform is unstable (if youre reading this, you should vote for MC-296043 on the bug tracker)
        vec2 ScreenPos = (glPos.xy / glPos.w) * 0.5 + 0.5;
        vec2 ScreenSize = round(gl_FragCoord.xy / ScreenPos);
        float GameTime = -(rot / 6.2831853) / 1.7;

        vec2 uv = gl_FragCoord.xy / ScreenSize;
        GameTime += 230.122; // this is to make the "random" hash look more random

        // the rest is from mojangs default minecraft assets
        float columns = floor(ScreenSize.x / 16.0);
        float rows = floor(ScreenSize.y / 16.0);

        float column = floor(uv.x * columns);
        float row = floor(uv.y * rows);

        float runners = (1.0 + 3.0 * random(column));
        float runner_phase = random(3.6 * column + 0.4231) * 2.0 + (GameTime * 300.0);

        float cells_per_runner = floor(rows / runners);
        float runner = floor(row / cells_per_runner);

        float runner_start = cells_per_runner * runner - runner_phase;
        float cell_to_runner_start = row - runner_start;

        float brightness = 1.0 - fract(cell_to_runner_start / cells_per_runner);
        const float e = 8.0;
        float green = pow(brightness, e);
        float not_green = pow(brightness, e * 4.0);

        vec4 glow = vec4(not_green, green, not_green, 1.0);

        const float glyph_width = 128.0 / 8.0;
        const float glyph_height = 128.0 / 8.0;

        float glyph_row = floor(random(3 * column + 5 * row) * 8.0);
        float glyph_column = floor(random(7 * column + 9 * row) * 17.0);

        float shift_x = fract(uv.x * columns);
        float shift_y = 1.0 - fract(uv.y * rows);
        vec4 glyph_color = texture(Sampler0, vec2((glyph_column + shift_x) / glyph_width, (glyph_row + shift_y) / glyph_height));

        fragColor = glow * glyph_color * ColorModulator;
        return;
    }

    vec4 color = texture(Sampler0, texCoord0);
    if (color.a == 0.0) {
        discard;
    }
    fragColor = color * ColorModulator;
}
