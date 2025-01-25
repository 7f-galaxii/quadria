/// @description Insert description here
// You can write your code in this editor
var _col = draw_get_color();

draw_set_alpha(clamp((--t/60),0,1));
draw_set_color(c_white);
draw_set_font(fMonogram24);
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_text(x,y,text);

draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(0);
draw_set_valign(0);