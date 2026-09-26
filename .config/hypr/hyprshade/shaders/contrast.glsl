precision mediump float;

uniform sampler2D tex;
varying vec2 v_texcoord;

void main() {
    vec4 color = texture2D(tex, v_texcoord);

    color.rgb = (color.rgb - 0.5) * 1.15 + 0.5;

    gl_FragColor = color;
}

