/// @description Insert description here
// You can write your code in this 

var _scissor = gpu_get_scissor()
gpu_set_scissor(240,20,160,320)
draw_sprite_tiled(sprGrid,0,240,20)
gpu_set_scissor(_scissor);

for (var _y = 1; _y < y_size; _y++) {
	for (var _x = 0; _x < x_size; _x++) {
		if (board[_y][_x].id != -1) draw_sprite(sprite,board[_y][_x].id,240+(_x*16),4+(_y*16))
	}
}
if (held_piece != pointer_null) {
	draw_piece(held_piece, 170, 36);
}

for (var p = 0; p < array_length(next_queue); p++) {
	draw_piece(next_queue[p], 406, 36+(p*38));
}

draw_set_alpha(0.4)
draw_piece(piece, 240+(piece.x*16), 4+(ghost_y*16));
draw_set_alpha(1)

draw_piece(piece, 240+(piece.x*16), 4+(piece.y*16));




