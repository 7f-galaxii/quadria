#macro OG objGame

#macro SPR global.sprite

function init_globals(){
	global.combo_pitch = [0, 1/8, 2/8, 2.5/8, 4/8, 5.5/8, 7/8, 1]
	window_set_size(1280,720);
	window_center();
	global.skins = [
	{
		sprite: sprBlock,
		name: "Fallback"
	},
	{
		sprite: sprite_add("skins\\default.png", 10, false, false, 0, 0),
		name: "Default"
	},
	{
		sprite: sprite_add("skins\\invert.png", 10, false, false, 0, 0),
		name: "Gradient"
	},
	{
		sprite: sprite_add("skins\\bevel.png", 10, false, false, 0, 0),
		name: "Beveled"
	},
	{
		sprite: sprite_add("skins\\arcade_tgm.png", 10, false, false, 0, 0),
		name: "Gradient (Arcade)"
	},
	{
		sprite: sprite_add("skins\\arcade_modern.png", 10, false, false, 0, 0),
		name: "Gradient (Modern)"
	},
	];
	global.sounds = [
	{
		name: "Fallback",
		clear: sndClear,
		clear4: sndClearQuad,
		slide: sndSlide,
		hold: sndHold,
		harddrop: sndHardDrop,
		rotate: sndRotate,
		lock: sndLock,
	}
	];
	/* shape: piece shape
	 * color: color id index
	 * kick (optional): kick table, defaults to JLSTZ table
	 * kick tables look like this
	 * 0->R [ [ 0, 0], [-1, 0], [-1,+1], [ 0,-2], [-1,-2] ],
	 * R->2 [ [ 0, 0], [+1, 0], [+1,-1], [ 0,+2], [+1,+2] ],
	 * 2->L [ [ 0, 0], [+1, 0], [+1,+1], [ 0,-2], [+1,-2] ],
	 * L->0 [ [ 0, 0], [-1, 0], [-1,-1], [ 0,+2], [-1,+2] ]
	 *
	 */
	global.pieces = {
		def : {shape: [
					[ 1 ]
				],
				color: 0, piece_name: "?", spin_type: "All", kick: [
				[ [ 0, 0], [-1, 0], [-1,-1], [ 0, 2], [-1, 2] ],
				[ [ 0, 0], [ 1, 0], [ 1, 1], [ 0,-2], [ 1,-2] ],
				[ [ 0, 0], [ 1, 0], [ 1,-1], [ 0, 2], [ 1, 2] ],
				[ [ 0, 0], [-1, 0], [-1, 1], [ 0,-2], [-1,-2] ]
			]},
		i : {shape: [
				[0, 0, 0, 0],
				[1, 1, 1, 1],
				[0, 0, 0, 0],
				[0, 0, 0, 0]
			], piece_name: "I", color: 5, kick: [
				[ [ 0, 0], [-2, 0], [ 1, 0], [-2, 1], [ 1,-2] ],
				[ [ 0, 0], [-1, 0], [ 2, 0], [-1,-2], [ 2, 1] ],
				[ [ 0, 0], [ 2, 0], [-1, 0], [ 2,-1], [-1, 2] ],
				[ [ 0, 0], [ 1, 0], [-2, 0], [ 1, 2], [-2,-1] ]
			]},
			
		o : {shape: [
				[ 1, 1 ],
				[ 1, 1 ]
			], color: 3, piece_name: "O", kick: [ [[0,0]],[[0,0]],[[0,0]],[[0,0]] ]},
			
		t : {shape: [
				[ 0, 1, 0 ],
				[ 1, 1, 1 ],
				[ 0, 0, 0 ]
			], piece_name: "T", spin_type: "T", color: 7},
			
		s : {shape: [
				[ 0, 1, 1 ],
				[ 1, 1, 0 ],
				[ 0, 0, 0 ]
			], piece_name: "S", color: 4},
			
		z : {shape: [
				[ 1, 1, 0 ],
				[ 0, 1, 1 ],
				[ 0, 0, 0 ]
			], piece_name: "Z", color: 1},
			
		j : {shape: [
				[ 1, 0, 0 ],
				[ 1, 1, 1 ],
				[ 0, 0, 0 ]
			], piece_name: "J", color: 6},
		
		l : {shape: [
				[ 0, 0, 1 ],
				[ 1, 1, 1 ],
				[ 0, 0, 0 ]
			], piece_name: "L", color: 2},
	}
}