uniform float uTime;
uniform float uSize;
uniform float uYpos;
uniform float uRandom;

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
    float angleOffset = (1.0 / 1.0) * uTime;
    angle += angleOffset;
    // modelPosition.x = uYpos;
    modelPosition.y = uYpos;
    // modelPosition.y += sin(angle) / 2.0 * aScale;
    // modelPosition.x -= cos(angle) / 2.0 * aScale;

    // Randomness
    modelPosition.xyz += aRandomness;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;

    /**
     * Size
     */
    //  float scaleOffset = 0.5;
     float scaleOffset = 1.0;
     scaleOffset *=  1.5 + (sin(angleOffset) + 0.4) *  0.5;
    //  scaleOffset *= aRandomness;
    gl_PointSize = uSize  * aScale ;
    gl_PointSize *= (1.0 / - viewPosition.z * 2.8)* scaleOffset;

    /**
     * Color
     */
    vColor = color;
}