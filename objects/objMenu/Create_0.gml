/// @description
draw_set_alpha(1)
draw_set_color(c_white)

menus = {
	main: [
		{button: "Singleplayer", active: true, action: "menu_singleplayer"},
		{button: "Customization", active: false, action: "menu_customization"},
		{button: "Options", active: true, action: "menu_options"},
		{button: "Exit", active: true, action: "exit_game"},
	]
}

menu = yui_document_create("UI/main_menu.yui", objMenu, false)