// A function `vec4 sampleCodeTexture(vec2)` must be defined before this is imported

// This is a slightly modified version of Mojangs code from the title_rain.fsh shader
// in the 25w14craftmine snapshot. I do not claim ownership of this file

float random (float v) {
    return fract(sin(v) * 43758.5453123);
}

vec4 drawCraftmineEffect(vec2 ScreenSize, float GameTime) {
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
    vec4 glyph_color = sampleCodeTexture(vec2((glyph_column + shift_x) / glyph_width, (glyph_row + shift_y) / glyph_height));

    return glow * glyph_color;
}