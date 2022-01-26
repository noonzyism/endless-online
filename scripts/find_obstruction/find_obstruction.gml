/// find_obstruction(x0, y0, x1, y1, tolerance)
function find_obstruction(argument0, argument1, argument2, argument3, argument4) {
	// checks if a collision map tile exists on the line between (x0, y0) and (x1, y1)
	// if so, returns the point of collision, else undefined
	//
	//      x0,y0       first point on collision line, real
	//      x1,y1       second point on collision line, real
	//		tolerance	the lower the number, the more precise the detection
	{
	    var ox,oy,dx,dy, tolerance;
	    ox = argument0;
	    oy = argument1;
	    dx = argument2;
	    dy = argument3;
		tolerance = argument4;
	
		var points;
	
		if (abs(ox - dx) < tolerance) && (abs(oy - dy) < tolerance) {
			return undefined;
		}
	
		var collision_map = layer_tilemap_get_id(layer_get_id("collision_map"));
	
		var mx = (ox + dx) / 2;
		var my = (oy + dy) / 2;
	
		var mid = tilemap_get_at_pixel(collision_map, mx, my) & tile_index_mask;
	
		if (mid != 0) {
			points[0] = mx;
			points[1] = my;
			return points;
		}
	
		points = find_obstruction(ox, oy, mx, my, tolerance);
	
		if (points != undefined) {
			return points;
		}
	
		return find_obstruction(mx, my, dx, dy, tolerance);
	
	}


}


function find_obstruction_v2(ox, oy, dx, dy, tolerance, collision_map) {
	// checks if a collision map tile exists on the line between (x0, y0) and (x1, y1)
	// if so, returns the point of collision, else undefined
	//
	//      x0,y0       first point on collision line, real
	//      x1,y1       second point on collision line, real
	//		tolerance	the lower the number, the more precise the detection
	{
		var points;
	
		if (abs(ox - dx) < tolerance) && (abs(oy - dy) < tolerance) {
			return undefined;
		}
		
		var len = point_distance(ox, oy, dx, dy);
		
		var ux = (dx - ox) / len;
		var uy = (dy - oy) / len;
	
		var mx = ox + (ux*tolerance);
		var my = oy + (uy*tolerance);
	
		var col = tilemap_get_at_pixel(collision_map, mx, my) & tile_index_mask;
	
		if (col != 0) {
			points[0] = mx;
			points[1] = my;
		}
		else {
			points = find_obstruction_v2(mx, my, dx, dy, tolerance, collision_map);
		}
		
		return points;
	}
}