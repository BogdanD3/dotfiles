precision mediump float;

uniform sampler2D tex;
varying vec2 v_texcoord;

void main() {
    vec4 color = texture2D(tex, v_texcoord);

    color.r *= 1.05;
    color.g *= 0.95;
    color.b *= 0.65;

    gl_FragColor = color;
}

