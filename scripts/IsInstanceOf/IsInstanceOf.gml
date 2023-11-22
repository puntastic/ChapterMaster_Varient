//!!!!:didn't want to bring this over since it needs a lot more testing and work before
//I feel confident in it... but a lot of the reworked engine relies on it.
//
// notably if 'value' is a number and 'type' is a constuctor (ie. a reference that gets convered to a number)
// this will erroneously return true
function IsInstanceOf(value, type)
{
	if(is_struct(value) && type == TYPE_STRUCT) { return true; }
	
	var typeType = _IsInstanceOf_GetTypeOrInstance(type, true);
	var valueType = _IsInstanceOf_GetTypeOrInstance(value);
	if(typeof(value)!= TYPE_STRUCT) { return valueType == typeType; }
	if(typeType != TYPE_NUMBER) { return valueType == typeType; }
	
	return valueType == script_get_name(type);
}

//todo: should probably make this its own thing
function _IsInstanceOf_GetTypeOrInstance(value, stringConversion = false)
{
	if(is_undefined(value)) { return TYPE_UNDEFINED; }
	if(typeof(value) == TYPE_STRUCT) { return instanceof(value); }
	if(!stringConversion) { return typeof(value); }
	
	if(typeof(value) == TYPE_STRING) { return IS_VALID_TYPE(value) ? value : TYPE_STRING; }
	
	return typeof(value);
}