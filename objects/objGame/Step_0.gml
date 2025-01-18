/// @description Insert description here
// You can write your code in this editor
piece.y_part += max(grav,grav*(softdropping*12));
while (piece.y_part >= 1) {
	piece.y_part--;
	var success = move(0,1);
	if (success && softdropping) {
		snd_play_effect(snd.slide);
	}
}

if (shape_collide(0,1,piece.shape)) {
	if (lock_delay <= -1) { lock_delay = 30; }
	if (hard_lock_delay <= -1) { hard_lock_delay = 60*5; }
} else {
	lock_delay = -1;
	hard_lock_delay = -1;
}
lock_delay--;
hard_lock_delay--;
if (lock_delay == 0) {
	lock_delay--;
	if (shape_collide(0, 1, piece.shape)) lock_piece();
}
if (hard_lock_delay == 0) {
	hard_lock_delay--;
	if (shape_collide(0, 1, piece.shape)) lock_piece();
}
#region input

softdropping = input_check("softdrop");
if (input_check_pressed("harddrop")) {
	while (!shape_collide(0, 1, piece.shape)) {
		piece.y++;
	}
	lock_piece();
	snd_play_effect(snd.harddrop)
}

if (input_check_pressed("left") || input_check_repeat("left", 0, 2, 10)) {
	var success = move(-1, 0);
	if (success) {
		snd_play_effect(snd.slide);
	}
}
if (input_check_pressed("right") || input_check_repeat("right", 0, 2, 10)) {
	var success = move(1, 0);
	if (success) {
		snd_play_effect(snd.slide);
	}
}


if (input_check_pressed("rotatecw")) {
	var success = kick(piece.rotation, false);
	if (success) {
	lock_delay = 30;
	snd_play_effect(snd.rotate, 5, 1, 0.95);	
	}
}

if (input_check_pressed("rotateccw")) {
	var success = kick(modulo(piece.rotation - 1, 4), true);
	if (success) {
	lock_delay = 30;
	snd_play_effect(snd.rotate);	
	}
}
if (input_check_pressed("hold")) {
	var success = hold_piece();	
	if (success) {
	snd_play_effect(snd.hold);
	}
}
#endregion