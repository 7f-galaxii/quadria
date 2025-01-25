/// @description
if (room == rInit) {
	init_globals();
	randomize();
	room_goto(rMenu);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(0);
	draw_set_valign(0);
}