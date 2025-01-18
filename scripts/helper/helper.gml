function draw_rectangle_size(_x, _y, width, height) {
	draw_rectangle(_x, _y, _x+width, _y+height, false);
}

function snd_play_effect(sound, priority = 5, gain = 1, pitch = 1) {
	audio_stop_sound(sound);
	audio_play_sound(sound,priority,false,gain,0,pitch);
}
function log(msg) {
	show_debug_message(msg);
}

function rgb(r,g,b) {
	return make_color_rgb(r,g,b);
}

function hsv(h,s,v) {
	return make_color_hsv((h/360)*255,(s/100)*255,(v/100)*255);
}

function array_rotate(array, ccw) {
	var _s = array_length(array);
	// reversing here does CCW
	if (ccw) {
		for (var i = 0; i < _s; ++i) { array_reverse_ext(array[i]); }
	}
	// "transpose" array
	for (var i = 0; i < _s; ++i) {
		for (var j = i; j < _s; ++j) {
			var _temp = array[i][j];
			array[i][j] = array[j][i];
			array[j][i] = _temp;
		}
	}
	// reversing here does CW
	if (!ccw) {
		for (var i = 0; i < _s; ++i) { array_reverse_ext(array[i]); }
	}
}

// GET SCARED


/// @description copies over a struct into a new struct
/// @function struct_copy(ref)
/// @param ref the reference to the struct to be copied
function struct_copy(ref){

	if (is_struct(ref)) {
		
		 //shows struct to be copied in debug output window
		//show_debug_message("function struct_copy() - original struct:"); show_debug_message(ref);
		
        var base = instanceof(ref);
		var ref_new;
        
        switch (base) {
            case("struct"):
            case("weakref"):
                ref_new = {};
            break;
                
            default:
                // Feather disable GM1041
                var constr = method(undefined, asset_get_index(base));
                ref_new = new constr();
        }
        
        var names = variable_struct_get_names(ref);
        var length = variable_struct_names_count(ref);
        
        for (var i = 0; i < length; i++) {
            var name = names[i];
            
            variable_struct_set(ref_new, name, variable_struct_get(ref, name));
        }
        
		//shows new struct in debug output window
		//show_debug_message("function struct_copy() - new struct:"); show_debug_message(ref_new);
        return ref_new;
		
    } else {
		
		show_debug_message("function struct_copy() - argument is not a struct. It cannot be copied.")
		var empty_struct = {};
		return empty_struct;
		
	}
}

function struct_merge(primary, secondary, shared) {
    var return_struct = primary;

    if (shared)	{
        var property_names = variable_struct_get_names(primary);
        for (var i = 0; i < array_length(property_names); i ++)	{
            if (variable_struct_exists(secondary, property_names[i]))	{
                variable_struct_set(return_struct, property_names[i], variable_struct_get(secondary, property_names[i]));
            }
        }
    } else {
        var property_names = variable_struct_get_names(secondary);
        for (var i = 0; i < array_length(property_names); i ++)	{
            variable_struct_set(return_struct, property_names[i], variable_struct_get(secondary, property_names[i]));
        }
    }
    return return_struct;
}

function struct_get_default(struct, variable, fallback = undefined) {
    var ret = variable_struct_get(struct, variable);
    if is_undefined(ret) {
        return fallback;
    }
    // Feather disable GM1035
    return ret;
}

function ds_list_to_array(list) {
    var result_array = [];
    for (var i = 0; i < ds_list_size(list); i++) {
        result_array[i] = list[| i];
    }
    return result_array;
}

function approach(value, target, amount) {
    if (target < value) {
        return max(target, value - amount)
    } else if (target > value) {
        return min(target, value + amount)
    }
    return target
}

function modulo(val, cap)
{
	var ret = val % cap;
	return (ret < 0) ? ret + cap : ret
}

function pad_num(num, spaces=2)
{
    return string_replace_all(string_format(num, spaces, 0), " ", "0")
}
