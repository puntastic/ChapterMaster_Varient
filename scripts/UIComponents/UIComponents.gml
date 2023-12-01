// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NullComponent() constructor {
	static is_null = function() {
		return true	
	}
	cid = "NULL"
}

function UIHandle(arg = undefined) {
	static handle = noone
	if arg
		handle = arg;
	return handle
}

function NUIComponent(name = undefined) {
	static components = {}
	if is_string(name)
		return components[$ name]
}
NUIComponent();

function UIComponent(owner, name) constructor {
	static is_null = function() {
		return false
	}
	static finalize = function() {
		//this is here because feather is a little too eager in determining if the static exists yet or not
		var c = NUIComponent.components ?? {};
		c[$ self.cid] = self;
		return owner;
	}
	static make_id = function() {
		static cid = 0;
		return cid++
	}
	
	static cancel_events_of = function(components) {

		static filter = function(elem) {
			return is_instanceof(elem, UIEventComponent)
		}
		
		components = array_map(components, function(elem) {
			return NUIComponent(elem) ?? new NullComponent();	
		})
		
		components = array_filter(components, filter)
		
		array_foreach(components, function(elem) {
			if elem.cid != cid
				elem.is_canceled = true;	
		})
	}
	
	self.owner = owner;
	if name == ""
		cid = string("UIComponent{0}", make_id())
	else
		cid = name;
		
	is_canceled = false;
}

function UIEventComponent(owner, name) : UIComponent(owner, name) constructor {
	
	static __ev_funcs = [];
	callback = function(c){}
	ev_type = undefined
	ev_code = undefined
	use_gui_coords = false;
	
	self.event_time_source = time_source_create(time_source_game, 1, time_source_units_frames, function() {
		if is_event() {
			callback(self);	
		}
		
		is_canceled = false
	}, [], -1)
	time_source_start(event_time_source)
	
	static set_callback = function(cb) {
		if is_callable(cb) {
			callback = cb;
		}
		return self;
	}

	/**
	 * @param {enum.KEY_EV_TYPE|enum.MOUSE_BT_EV_TYPE|enum.MOUSE_EV_TYPE} ev an event type corresponding to the event to test for
	 */
	static set_event_type = function(ev) {
		ev_type = ev;
		return self;
	}
	
	static set_ev_code = function(key) {
		ev_code = key
		return self;
	}
	
	static is_event = function() {
		return !is_canceled && owner.is_active && __ev_funcs[ev_type](ev_code)
	}
	
	static cleanup = function() {
		time_source_destroy(event_time_source)	
	}
}

function UIMouseEventComponent(owner, name = "") : UIEventComponent(owner, name) constructor {
	static move_threshold = 2;
	enum MOUSE_EV_TYPE {
		ON_ENTER,
		ON_MOVE,
		ON_HOVER,
		ON_LEAVE,
		ON_STOP,
		GLOBAL_ON_MOVE,
		GLOBAL_ON_STOP
	}
	was_in_rect = false;
	static __ev_funcs = [
		/*ON_ENTER*/
		function() {
			var f1 = mouse_x
			var f2 = mouse_y
			if use_gui_coords {
				f1 = window_mouse_get_x()
				f2 = window_mouse_get_y()
			}
			var test = owner.is_in_bounding_rect(f1, f2)
			var result = test && !was_in_rect
			was_in_rect = test;
			return result;
		},
		/*ON_MOVE*/
		function() {
			var f1 = mouse_x
			var f2 = mouse_y
			if use_gui_coords {
				f1 = window_mouse_get_x()
				f2 = window_mouse_get_y()
			}
			var dx = window_mouse_get_delta_x()
			var dy = window_mouse_get_delta_y()
			return owner.is_in_bounding_rect(f1, f2) && ((dx*dx + dy*dy) > move_threshold)
		},
		/*ON_HOVER*/
		function() {
			var f1 = mouse_x
			var f2 = mouse_y
			if use_gui_coords {
				f1 = window_mouse_get_x()
				f2 = window_mouse_get_y()
			}
			return owner.is_in_bounding_rect(f1, f2)
		},
		/*ON_LEAVE*/
		function() {
			var f1 = mouse_x
			var f2 = mouse_y
			if use_gui_coords {
				f1 = window_mouse_get_x()
				f2 = window_mouse_get_y()
			}
			var test = owner.is_in_bounding_rect(f1, f2)
			var result = !test && was_in_rect
			was_in_rect = test;
			return result;
		},
		/*ON_STOP*/
		function() {
			var f1 = mouse_x
			var f2 = mouse_y
			if use_gui_coords {
				f1 = window_mouse_get_x()
				f2 = window_mouse_get_y()
			}
			var dx = window_mouse_get_delta_x()
			var dy = window_mouse_get_delta_y()
			return owner.is_in_bounding_rect(f1, f2) && ((dx*dx + dy*dy) <= move_threshold)
		},
		/*GLOBAL_ON_MOVE*/
		function() {
			var dx = window_mouse_get_delta_x()
			var dy = window_mouse_get_delta_y()
			return ((dx*dx + dy*dy) > move_threshold)
		},
		/*GLOBAL_ON_STOP*/
		function() {
			var dx = window_mouse_get_delta_x()
			var dy = window_mouse_get_delta_y()
			return ((dx*dx + dy*dy) <= move_threshold)
		},
	]
	ev_type = MOUSE_EV_TYPE.ON_ENTER
}

function UIKeyboardEventComponent(owner, name = "") : UIEventComponent(owner, name) constructor {
	enum KEY_EV_TYPE {
		BASIC,
		DIRECT,
		PRESS,
		RELEASE
	}
	
	static __ev_funcs = [
		keyboard_check,
		keyboard_check_direct,
		keyboard_check_pressed,
		keyboard_check_released
	]
	
	ev_type = KEY_EV_TYPE.BASIC
	ev_code = vk_anykey
	
}

function UIMouseButtonEventComponent(owner, name = "") : UIEventComponent(owner, name) constructor {
	enum MOUSE_BT_EV_TYPE {
		DIRECT,				//0
		PRESS,				//1
		RELEASE,			//2
		SCROLL_UP,			//3
		SCROLL_DOWN,		//4
		GLOBAL_DIRECT,		//5
		GLOBAL_PRESS,		//6
		GLOBAL_RELEASE,		//7
		GLOBAL_SCROLL_UP,	//8
		GLOBAL_SCROLL_DOWN	//9
	}
	
	static __ev_funcs = [
		mouse_check_button,
		mouse_check_button_pressed,
		mouse_check_button_released,
		function(b) {return mouse_wheel_up()},
		function(b) {return mouse_wheel_down()}
	]
	
	
	static is_mouse_in_rect = function() {
		var _x, _y, _w, _h;
		_x = owner.gui_x;
		_y = owner.gui_y;
		_w = _x + owner.width;
		_h = _y + owner.height
		var f1 = mouse_x;
		var f2 = mouse_y;
		if use_gui_coords {
			f1 = window_mouse_get_x()
			f2 = window_mouse_get_y()
		}
		return point_in_rectangle(f1, f2, _x, _y, _w, _h)
	}

	static is_event = function() {
		return !is_canceled && owner.is_active && __ev_funcs[ev_type % MOUSE_BT_EV_TYPE.GLOBAL_DIRECT](ev_code) && (ev_type >= MOUSE_BT_EV_TYPE.GLOBAL_DIRECT || is_mouse_in_rect())
	}


	time_source_reconfigure(event_time_source, 1, time_source_units_frames, function() {
		if is_event() {
			callback(self);	
		}
		
		is_canceled = false;
	}, [], -1)
	
	time_source_start(event_time_source)
	ev_type = MOUSE_BT_EV_TYPE.DIRECT;
	ev_code = mb_any;
}

function UINodeDebugComponent(owner, name ="") : UIComponent(owner, name) constructor {
	static error_code_map = [
		"OutsideOfRectError",
		"SuccessStatus",
		"EdgeOverlapError",
		"SameSizeAsChildError",
		"SurroundsChildError",
		"CriticalError"
	]
	status_messages = []
	self.owner = owner;
	/**
	 * Pushes an error message to the stack for deferred handling/logging
	 * @param {enum.UINODE_STATUS} type
	 */
	static push_status = function(type, tester, testee, caller) {
		var err = {
			type,
			ui_node: weak_ref_create(tester),
			caused_by: weak_ref_create(testee),
			caller
		}
		array_push(status_messages, err)
	}
	
	static log = function() {
		var str = $"{owner.gid} UINodeDebugComponent : \{\n"
		
		for(var i = 0; i < array_length(status_messages); i++) {
			var code = error_code_map[status_messages[i].type]
			var ref1 = undefined
			var ref2 = undefined
			var func = status_messages[i].caller
			
			if weak_ref_alive(status_messages[i].ui_node) {
				with(status_messages[i].ui_node.ref) {
					ref2 = {gid, gui_x, gui_y, width, height}	
				}
			}
			if weak_ref_alive(status_messages[i].caused_by) {
				with(status_messages[i].caused_by.ref) {
					ref1 = {gid, gui_x, gui_y, width, height}	
				}
			}
			str += string("  UIWARNING: {0} caused by node: {1} against node: {2} in function: {3}\n", code, ref1, ref2, func)
		}
		show_debug_message(str + "}")
	}
	
	static toString = function() {
		return "UINodeDebugComponent"	
	}
}