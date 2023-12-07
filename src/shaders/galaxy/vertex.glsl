uniform float uTime;
uniform float uSize;
uniform float uYpos;

attribute vec3 aRandomness;
attribute float aScale;

varying vec3 vColor;

void main()
{
    /**
     * Position
     */
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
                
    // Rotate
    float angle = atan(modelPosition.x, modelPosition.z);
    float distanceToCenter = length(modelPosition.xz);
    float angleOffset = (1.0 / 2.0) * uTime;
    angle += angleOffset;
    // modelPosition.y *= sin(angle)/ 1.0;
    // modelPosition.x *= sin(angle)/ 1.0;
    modelPosition.y = uYpos;

    // Randomness
    modelPosition.xyz += aRandomness;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;

    /**
     * Size
     */
     float scaleOffset = 0.5;
     scaleOffset *=  1.0 + (sin(angleOffset) + 1.0) *  0.5;
    gl_PointSize = uSize * aScale * scaleOffset;
    gl_PointSize *= (1.0 / - viewPosition.z * 1.2);

    /**
     * Color
     */
    vColor = color;
}