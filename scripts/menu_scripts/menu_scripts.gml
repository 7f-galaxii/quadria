function exit_game(view_item) {
	var is_doc = view_item[$"object_index"] == yui_document;
	if is_doc {
		var document = view_item;
	}
	else {
		var document = view_item.document;
	}
	document.unload(__exit_game);
}
function __exit_game() {
	game_end();
}

function start_singleplayer(view_item) {
	var is_doc = view_item[$"object_index"] == yui_document;
	if is_doc {
		var document = view_item;
	}
	else {
		var document = view_item.document;
	}
	document.unload(__start_singleplayer)
}
function __start_singleplayer() {
	room_goto(rGame);
}

function close_menu(view_item) {
	var is_doc = view_item[$"object_index"] == yui_document;
	if is_doc {
		var document = view_item;
	}
	else {
		var document = view_item.document;
	}
	document.unload(function() { objGame.paused = !objGame.paused });
}

function to_main_menu() {
	room_goto(rInit);
}
