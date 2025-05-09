vec4 sample1PanoramaFace(samplerCube cubeSampler, vec2 uv) {
    vec2 uvminus1to1 = (uv - 0.5) * 2.0;
    vec3 viewFromUV = vec3(-uvminus1to1.x, uvminus1to1.y, -1.0);
    return texture(cubeSampler, viewFromUV);
}