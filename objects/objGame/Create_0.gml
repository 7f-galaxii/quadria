/// @description Initialize
#region function definitions
function bag() {
	if (array_length(_bag_array) == 0) {
		//_bag_array = [global.pieces.i, global.pieces.i, global.pieces.i];
		_bag_array = array_shuffle([
			global.pieces.i,global.pieces.o,
			global.pieces.t,global.pieces.s,
			global.pieces.z,global.pieces.j,
			global.pieces.l,
		]);
	}
	return array_pop(_bag_array);
}

function init_bag() {
	_bag_array = [];
	next_queue = [bag(), bag(), bag(), bag(), bag()];	
}

function init_board() {
	board = array_create(y_size, pointer_null);
	for (var _y = 0; _y < y_size; _y++) {
		board[_y] = array_create(x_size, pointer_null);
		for (var _x = 0; _x < x_size; _x++) {
			board[_y][_x] = { id : -1 };
		}
	}
}

function hold_piece() {
	if (has_held) return false;
	has_held = true;
	if (held_piece == pointer_null) {
		held_piece = variable_clone(piece);
		for (var i = 0; i < held_piece.rotation; i++) {
			array_rotate(held_piece.shape, true);	
		}
		held_piece.rotation = 0;
		spawn_piece(array_shift(next_queue));
		array_push(next_queue, bag());
	} else {
		var _temp = variable_clone(held_piece);
		held_piece = variable_clone(piece);
		for (var i = 0; i < held_piece.rotation; i++) {
			array_rotate(held_piece.shape, true);	
		}
		held_piece.rotation = 0;
		spawn_piece(_temp);
	}
	return true;
}

function spawn_piece(_spawn) {
	piece = variable_clone(_spawn);
	piece.rotation = 0; // 0 = default, 1 = CW once, 2 = 180, 3 = CCW once
	if (!struct_exists(piece, "kick")) {
		piece.kick = global.pieces.def.kick;
	}
	if (!struct_exists(piece, "spin_type")) {
		piece.spin_type = global.pieces.def.spin_type;
	}
	piece.x = floor((x_size - array_length(piece.shape)) / 2);
	piece.y = 0;
	piece.y_part = 0;
	lock_delay = -1;
	hard_lock_delay = -1;
	was_spun = false;

}

function check_board() {
	var lines_cleared = 0;
	for (var _y = 0; _y < y_size; _y++) {
		var should_break = true;
		for (var _x = 0; _x < x_size; _x++) {
			if (board[_y][_x].id == -1) { should_break = false; break; }
		}
		if (should_break) {
			lines_cleared++;
			for (var _y2 = _y; _y2 > 0; _y2--) {
				board[_y2] = variable_clone(board[_y2-1])
			}
		}
	}
	do_scoring(lines_cleared);
}

function do_scoring(cleared) {
	if (cleared && was_spun) { 
		// spin code
		instance_create_layer(235, 160, "UI", objText, {
			text: "T-spin",
			halign: fa_right,
			valign: fa_top,
			
		});
	}
	if (cleared >= 4) {
		snd_play_effect(snd.clear4, 5, 2, 1+global.combo_pitch[min(combo, 7)]);
		combo++;
	} else if (cleared > 0) {
		snd_play_effect(snd.clear, 5, 2, 1+global.combo_pitch[min(combo, 7)]);
		combo++;
	} else {
		combo = 0;
	}
}

function lock_piece() {
	has_held = false;
	var _size = array_length(piece.shape);
	for (var _y = 0; _y < _size; _y++) {
		for (var _x = 0; _x < _size; _x++) {
			if (piece.shape[_y][_x] != 0) { OG.board[piece.y+_y][piece.x+_x].id = piece.color; }
		}
	}
	check_board();
	piece = {};
	spawn_piece(array_shift(next_queue));
	array_push(next_queue, bag());
	snd_play_effect(sndLock);
}

function shape_collide(_x, _y, _shape) {
	var _size = array_length(_shape);
	for (var i = 0; i < _size; i++) {
		for (var j = 0; j < _size; j++) {
			if (_shape[j][i] != 0) {
				if (check_collision(piece.x + _x + i, piece.y + _y + j)) { return true; }
			}
		}
	}
	return false;
}

function kick(index,ccw) {
	var _temp_shape = variable_clone(piece.shape);
	var mult = ccw ? -1 : 1;
	var _ret = false;
	array_rotate(_temp_shape,ccw);
	// check if offset is valid
	// create temp rotated version, and check against kicktable
	for (var i = 0; i < array_length(piece.kick[0]); i++) {
		if (!shape_collide(piece.kick[index][i][0]*mult, piece.kick[index][i][1]*mult, _temp_shape)) {
			piece.x += piece.kick[index][i][0]*mult;
			piece.y += piece.kick[index][i][1]*mult;
			piece.rotation = modulo(piece.rotation+mult, 4)
			array_rotate(piece.shape, ccw);
			_ret = true;
			break;
		}
	}
	if (_ret && piece.spin_type == "T") {
		var corners = 0;
		corners += check_collision(piece.x,   piece.y  );
		corners += check_collision(piece.x+2, piece.y  );
		corners += check_collision(piece.x,   piece.y+2);
		corners += check_collision(piece.x+2, piece.y+2);
		if (corners >= 3) { was_spun = true; }
	}
	return _ret;
}

function move(x_off, y_off) {
	var col = shape_collide(x_off, y_off, piece.shape);
	if (!col) {
		piece.x += x_off;
		piece.y += y_off;
		was_spun = false;
		return true;
	}
	return false;
}

function check_collision(_x, _y) {
	if (_x < 0 || _x >= x_size || _y < 0 || _y >= y_size) { return true; }
	return board[_y][_x].id != -1;
}

function draw_piece(_piece, _x, _y) {
	for (var i = 0; i < array_length(_piece.shape); i++) {
		for (var j = 0; j < array_length(_piece.shape[0]); j++) {
			if (_piece.shape[j][i]) draw_sprite(sprite,_piece.color,_x+(i*16),_y+(j*16));
		}
	}	
}

function delay_lock() {
	if (ld_count == 15) {
		lock_piece();
	}
}
#endregion
#region init
init_globals();
randomize();
ld_count = 0;
points = 0;
combo = 0;
was_spun = false;
skin = "Gradient (Modern)";
_f = function(_e, _i){ return _e.name == skin; }
sprite = global.skins[array_find_index(global.skins,_f)].sprite;
snd = global.sounds[0];
x_size = 10;
y_size = 20+1;
ghost_y = 0;
grav = 1/20;
softdropping = false;
lock_delay = -1;
hard_lock_delay = -1;
held_piece = pointer_null;
has_held = false;
init_board();
init_bag();	
#endregion

// spawning code
spawn_piece(array_shift(next_queue));
array_push(next_queue, bag());

