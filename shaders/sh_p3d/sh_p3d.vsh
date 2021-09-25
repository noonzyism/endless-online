attribute vec3 in_Position;			// vertex position
attribute vec2 in_TextureCoord;		// texture coordinates on the overall texture page
attribute vec4 in_Normal;			// using to store instance-specific metadata
attribute vec2 in_InstPosition;		// origin x/y of instance corresponding to this vertex
attribute vec2 in_LocalTexcoord;	// texture coordinates relative to the specific texture region for this instance's sprite
varying vec2 v_vTexcoord;				
varying vec3 v_curPosition;
uniform vec4 viewData;				// vec4(camera.x, camera.y, view_angle, view_radius)
uniform int dynamicIds[16];
uniform vec2 dynamicPosition[16];
uniform vec4 dynamicTextureDiffs[16];
uniform int dynamicCount;

// when_eq: if (x == y) returns 1, else 0
float when_eq(int x, int y) {
  return 1.0 - abs(sign(float(x - y)));
}

void main() {
	///////////////////////////////////////////////////////////////////
	// variables
	///////////////////////////////////////////////////////////////////
	int instanceId = int(in_Normal.x);
	float billboard = in_Normal.y;
	float camAngle = viewData.z;
	//vec2 viewShift = vec2(sin(camAngle), -cos(camAngle));
	
	vec3 vertexPosition = in_Position;
	vec2 vertexTexture = in_TextureCoord;
	vec2 originOffset = vertexPosition.xy - in_InstPosition;
	
	///////////////////////////////////////////////////////////////////
	// vertex derivation
	///////////////////////////////////////////////////////////////////
	
	// billboard draw: recalculate vertex position using camera angle
	vertexPosition.x += billboard * (-originOffset.x + (originOffset.x * cos(-camAngle)) + (originOffset.y * sin(-camAngle)));
	vertexPosition.y += billboard * (-originOffset.y + (originOffset.x * -sin(-camAngle)) + (originOffset.y * cos(-camAngle)));
	
	// dynamic entity: shift x/y dynamically based on uniform data
	for(int i=0; i<dynamicCount; i+=1) {
		vertexPosition += when_eq(dynamicIds[i], instanceId) * vec3(dynamicPosition[i].x, dynamicPosition[i].y, 0);
	}
	
	///////////////////////////////////////////////////////////////////
	// pseudo 3d effect
	///////////////////////////////////////////////////////////////////
	
	// this is where the magic happens
	vec2 tilt = 1.75*(vertexPosition.xy - viewData.xy)/viewData.w; // perspective tilt
	vec2 z_offset = vertexPosition.z * (tilt);
	
	vec4 object_space_position = vec4(
        vertexPosition.xy + z_offset,
		0,
        1.0
    );
	
	///////////////////////////////////////////////////////////////////
	// texture derivation
	///////////////////////////////////////////////////////////////////
	
	// dynamic entity: use texture offsets from uniform data to determine texture
	for(int i=0; i<dynamicCount; i+=1) {
		vertexTexture += when_eq(dynamicIds[i], instanceId) * (dynamicTextureDiffs[i].xy + vec2(dynamicTextureDiffs[i].z * in_LocalTexcoord.x, dynamicTextureDiffs[i].w * in_LocalTexcoord.y));
	}
	
	///////////////////////////////////////////////////////////////////
	// screen position & variables for frag shader
	///////////////////////////////////////////////////////////////////
	
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_position;
    v_vTexcoord = vertexTexture;
    v_curPosition = vertexPosition;
}

