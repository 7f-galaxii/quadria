/// @description Insert description here
// You can write your code in this editor
var _col = draw_get_color();

draw_set_color(color);
draw_set_font(font);
draw_set_halign(halign);
draw_set_valign(valign);
draw_text(x,y,text);

draw_set_color(_col);

if (++t == time) { instance_destroy(); }