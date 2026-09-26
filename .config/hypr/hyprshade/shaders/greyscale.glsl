precision mediump float;

uniform sampler2D tex;
varying vec2 v_texcoord;

void main() {
    vec4 color = texture2D(tex, v_texcoord);
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    gl_FragColor = vec4(vec3(gray), color.a);
}

