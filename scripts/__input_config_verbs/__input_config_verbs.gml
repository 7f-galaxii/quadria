// Feather disable all

//This script contains the default profiles, and hence the default bindings and verbs, for your game
//
//  Please edit this macro to meet the needs of your game!
//
//The struct return by this script contains the names of each default profile.
//Default profiles then contain the names of verbs. Each verb should be given a binding that is
//appropriate for the profile. You can create bindings by calling one of the input_binding_*()
//functions, such as input_binding_key() for keyboard keys and input_binding_mouse() for
//mouse buttons

function __input_config_verbs()
{
    return {
        keyboard_and_mouse:
        {
            left:      input_binding_key(vk_left),
            right:     input_binding_key(vk_right),
			softdrop:  input_binding_key(vk_down),
			harddrop:  input_binding_key(vk_space),
			rotateccw: input_binding_key("Z"),
			rotatecw:  input_binding_key("X"),
			hold:      input_binding_key("C"),
			pause:     input_binding_key(vk_escape),
			
            menu_up:     input_binding_key(vk_up),
            menu_down:   input_binding_key(vk_down),
            menu_left:   input_binding_key(vk_left),
            menu_right:  input_binding_key(vk_right),
            accept:      [input_binding_key(vk_space), input_binding_key(vk_enter), input_binding_key("Z")],
            cancel:      [input_binding_key(vk_backspace), input_binding_key(vk_escape), input_binding_key("X")],
        },
        
        gamepad:
        {
            softdrop:  input_binding_gamepad_button(gp_padd),
            harddrop:  input_binding_gamepad_button(gp_padu),
            left:      input_binding_gamepad_button(gp_padl),
            right:     input_binding_gamepad_button(gp_padr),
            rotateccw: input_binding_gamepad_button(gp_face1),
			rotatecw:  input_binding_gamepad_button(gp_face2),
            hold:      input_binding_gamepad_button(gp_shoulderr),
			pause:     input_binding_gamepad_button(gp_start),
			
			
            accept:     input_binding_gamepad_button(gp_face1),
            cancel:     input_binding_gamepad_button(gp_face2),
            menu_down:  [input_binding_gamepad_axis(gp_axislv, false), input_binding_gamepad_button(gp_padd)],
            menu_left:  [input_binding_gamepad_axis(gp_axislh, true),  input_binding_gamepad_button(gp_padl)],
            menu_right: [input_binding_gamepad_axis(gp_axislh, false), input_binding_gamepad_button(gp_padr)],
			menu_up:    [input_binding_gamepad_axis(gp_axislv, true),  input_binding_gamepad_button(gp_padu)],

        },
        
        touch:
        {
            //up:    input_binding_virtual_button(),
            //down:  input_binding_virtual_button(),
            //left:  input_binding_virtual_button(),
            //right: input_binding_virtual_button(),
            
            //accept:  input_binding_virtual_button(),
            //cancel:  input_binding_virtual_button(),
            //action:  input_binding_virtual_button(),
            //special: input_binding_virtual_button(),
            
            //pause: input_binding_virtual_button(),
        }
    };
}