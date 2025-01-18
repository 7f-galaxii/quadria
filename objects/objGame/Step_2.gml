/// @description Insert description here
// You can write your code in this editor
ghost_y = piece.y;
var y_offset = 0;
while (!shape_collide(0, ++y_offset, piece.shape)) {
	ghost_y++;
}