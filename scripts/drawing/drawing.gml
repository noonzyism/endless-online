function draw_texture_cube() {
	//uses variables from the calling object
	//adds the calling object's sprite image to the draw queue that's iterated on by ctrl_draw
	//the sprite is split into slices to be drawn with 3d depth
	{
		draw_texture_cube_ext(0, 1);
	}
}

function draw_texture_cube_ext(argument0, argument1) {
	//uses variables from the calling object
	//adds the calling object's sprite image to the draw queue that's iterated on by ctrl_draw
	//the sprite is split into slices to be drawn with 3d depth
	var _angle = argument0;
	var _scale = argument1;

	var spr_height = _scale * sprite_get_height(sprite_index);
	var spr_width = _scale * sprite_get_width(sprite_index);
	var full_height = sprite_get_height(sprite_index);

	var o_dx = spr_width/2 - _scale*sprite_get_xoffset(sprite_index);
	var o_dy = spr_height/2 - _scale*sprite_get_yoffset(sprite_index);

	var o_dir = point_direction(x, y, x + o_dx, y - o_dy);
	var o_len = point_distance(x, y, x + o_dx, y - o_dy);

	var ox = lengthdir_x(o_len, _angle - o_dir);
	var oy = lengthdir_y(o_len, _angle - o_dir);

	var tx = ox + lengthdir_x(spr_height/2, 90 + _angle);
	var ty = oy + lengthdir_y(spr_height/2, 90 + _angle);

	var lx = ox + lengthdir_x(spr_width/2, 180 + _angle);
	var ly = oy + lengthdir_y(spr_width/2, 180 + _angle);

	var bx = ox + lengthdir_x(spr_height/2, 270 + _angle);
	var by = oy + lengthdir_y(spr_height/2, 270 + _angle);

	var rx = ox + lengthdir_x(spr_width/2, _angle);
	var ry = oy + lengthdir_y(spr_width/2, _angle);

	var draw_height = 0;

	// spacing is a value that dictates the precision/amount of slices to be used; should be kept in the range of [1, 4]
	// lower = more precision/detail
	var spacing = 1;

	var slices = ceil(full_height / spacing);

	for (var i = 0; i < slices; i += 1) {
		var j = (i+1)*spacing;
	
		// these are percentages indicating how much to trim from the top/bottom of the sprite
		var top_trim = clamp(-0.10 + ((full_height - j) / full_height), 0, 1);
		var bot_trim = clamp((i * spacing) / full_height, 0, 1);
	
		// draw sides of block
		draw_request(id, x + tx, y + ty, draw_height, sprite_index, image_index, _scale, _angle + 180, 0, top_trim, 0, bot_trim, 0);
		draw_request(id, x + lx, y + ly, draw_height, sprite_index, image_index, _scale, _angle + 270, 0, top_trim, 0, bot_trim, 0);
		draw_request(id, x + bx, y + by, draw_height, sprite_index, image_index, _scale, _angle, 0, top_trim, 0, bot_trim, 0);
		draw_request(id, x + rx, y + ry, draw_height, sprite_index, image_index, _scale, _angle + 90, 0, top_trim, 0, bot_trim, 0);
	
		draw_height += spacing * _scale;
	}

	// draw top face of block
	draw_request(id, x, y, draw_height - spacing * _scale, sprite_index, image_index, _scale, _angle, 0, 0, 0, 0, 0);
}


function draw_request(_inst, _x, _y, _z, _spr, _subimg, _scale, _angle, _ltrim, _ttrim, _rtrim, _btrim, _billboard) {
	//adds a new draw request to the 3d drawing queue

	{	
		var request;
		request[0]	= _inst;
		request[1]	= _x;
		request[2]	= _y;
		request[3]	= _z;
		request[4]	= _spr;
		request[5]	= _subimg;
		request[6]	= _scale;
		request[7]	= _angle;
		request[8]	= _ltrim;
		request[9]	= _ttrim;
		request[10]	= _rtrim;
		request[11]	= _btrim;
		request[12]	= _billboard;
	
		ds_priority_add(global.drawgrid, request, -_z);
	}
}

function build_buffer_from_requests(requests, vertex_format) {
	var count = ds_list_size(requests);

	if (count <= 0) {
		// no requests to build buffer, return
		return -1;
	}

	var vb = vertex_create_buffer();
	vertex_begin(vb, vertex_format);

	var i = 0;

	while (i < count) {
		var request		= requests[| i];
		var _inst		= request[0];
		var _x			= request[1];
		var _y			= request[2];
		var _z			= request[3];
		var _spr		= request[4];
		var _subimg		= request[5];
		var _scale		= request[6];
		var _angle		= request[7];
		var _ltrim		= request[8];
		var _ttrim		= request[9];
		var _rtrim		= request[10];
		var _btrim		= request[11];
		var _billboard	= request[12];	
		// if the instance is a dynamic, we set its position as 0 because it will be controlled by the dynamic uniform data instead of this static vertex data
		_x = get_metadata_or_else(_inst, "dynamic", false) ? 0 : _x;
		_y = get_metadata_or_else(_inst, "dynamic", false) ? 0 : _y;
	
		// if the drawing method is billboard, we set the angle to 0 as the sprite's angle will be controlled by the shader to always face the camera
		_angle = _billboard ? 0 : _angle;
	
		var cc = dcos(_angle);
		var ss = dsin(_angle);

		var uvs = sprite_get_uvs(_spr, _subimg);
	
		// setting some instance metadata to keep record of the texture most recently written to the buffer for it
		// this is used for dynamics to calculate texture offsets correctly
		set_metadata(_inst, "buffer_texture", uvs);
	
		// texture coordinates
		var txl = uvs[0];  //left
		var tyt = uvs[1];  //top
		var txr = uvs[2];  //right
		var tyb = uvs[3];  //bottom
	
		var uvw = (txr - txl); //texture uv width
		var uvh = (tyb - tyt); //texture uv height
	
		// texture left & top cropped pixels from original sprite
		var cl = uvs[4];
		var ct = uvs[5];
	
		// texture width & height downscale percentage from original sprite
		var pw = uvs[6];
		var ph = uvs[7];
	
		// texture width & height, taking into account downscale percentage
		var tw = pw * sprite_get_width(_spr);
		var th = ph * sprite_get_height(_spr);
	
		// trim values converted from percentages to raw pixel amounts for width & height
		var wtrim = (_ltrim + _rtrim) * tw;
		var htrim = (_ttrim + _btrim) * th;
	
		if ((wtrim > 0) || (htrim > 0)) {
			// if we are trimming a sprite, center the sprite fragment (equal offsets)
			var sr = (tw - wtrim)/2;
			var sl = -sr;
			var sb = (th - htrim)/2;
			var st = -sb;
		}
		else {
			// if we are using a full sprite, use the sprite's origin to determine offset
			// offsets from sprite origin, accounting for cropped pixels
			var sl = cl - sprite_get_xoffset(_spr);
			var st = ct - sprite_get_yoffset(_spr);
			var sr = sl + tw;
			var sb = st + th;
		}
	
		// final offsets, accounting for scale parameter
		var kl = _scale * (sl);
		var kt = _scale * (st);
		var kr = _scale * (sr);
		var kb = _scale * (sb);
	
		// absolute texture coordinates on the overall texture page, taking into account trim parameter
		var tl = txl + _ltrim * uvw;
		var tt = tyt + _ttrim * uvh;
		var tr = txr - _rtrim * uvw;
		var tb = tyb - _btrim * uvh;
	
		// local texture coordinates relative to the specific texture i.e. (0,0) for the top-left and (1,1) for the bottom right of the specific texture
		var tl_local = (tl - txl)/uvw;
		var tt_local = (tt - tyt)/uvh;
		var tr_local = (tr - txl)/uvw;
		var tb_local = (tb - tyt)/uvh;
	
	
		//calculate positions of vertices:
    
		// vertex 0
		var _v0x = _x +  cc*kl + ss*kt;
		var _v0y = _y + -ss*kl + cc*kt;
		// vertex 1
		var _v1x = _x +  cc*kr + ss*kt;
		var _v1y = _y + -ss*kr + cc*kt;
		// vertex 2
		var _v2x = _x +  cc*kr + ss*kb;
		var _v2y = _y + -ss*kr + cc*kb;
		// vertex 3
		var _v3x = _x +  cc*kl + ss*kb;
		var _v3y = _y + -ss*kl + cc*kb;
    
		// upper-right triangle
		vertex_position_3d(vb, _v0x,_v0y,_z);
		vertex_texcoord(vb, tl,tt);
		vertex_float4(vb,_inst,_billboard,0,0);
		vertex_float2(vb,_x,_y);
		vertex_float2(vb,tl_local,tt_local);
	
		vertex_position_3d(vb, _v1x,_v1y,_z);
		vertex_texcoord(vb, tr,tt);
		vertex_float4(vb,_inst,_billboard,0,0);
		vertex_float2(vb,_x,_y);
		vertex_float2(vb,tr_local,tt_local);
	
		vertex_position_3d(vb, _v2x,_v2y,_z);
		vertex_texcoord(vb, tr,tb); 
		vertex_float4(vb,_inst,_billboard,0,0);
		vertex_float2(vb,_x,_y);
		vertex_float2(vb,tr_local,tb_local);
    
		// lower-left triangle
		vertex_position_3d(vb, _v0x,_v0y,_z);
		vertex_texcoord(vb, tl,tt);  
		vertex_float4(vb,_inst,_billboard,0,0);
		vertex_float2(vb,_x,_y);
		vertex_float2(vb,tl_local,tt_local);
	
		vertex_position_3d(vb, _v2x,_v2y,_z);
		vertex_texcoord(vb, tr,tb); 
		vertex_float4(vb,_inst,_billboard,0,0);
		vertex_float2(vb,_x,_y);
		vertex_float2(vb,tr_local,tb_local);
	
		vertex_position_3d(vb, _v3x,_v3y,_z);
		vertex_texcoord(vb, tl,tb);    
		vertex_float4(vb,_inst,_billboard,0,0);
		vertex_float2(vb,_x,_y);
		vertex_float2(vb,tl_local,tb_local);
			
		i += 1;
	}
	vertex_end(vb);

	vertex_freeze(vb);

	return vb;


}

