function ExistsOrDefault(struct, name, defaultValue)
{
	if(variable_struct_exists(struct, name)) { return variable_struct_get(struct,name); }
	return defaultValue;
}

function GetStructValue(struct, name, expectedType = undefined, defaultValue = undefined, throwIfInvalid = false)
{
	if(!variable_struct_exists(struct, name)) 
	{
		show_debug_message("Member \"{0}\" not found in struct", name);
		if(throwIfInvalid) { throw(string("Struct member \"{0}\"not found in \"{1}\"", name, struct)); }
		return defaultValue;
	}
	
	if(IsInstanceOf(variable_struct_get(struct, name), expectedType)) { return variable_struct_get(struct,name); }
	if(throwIfInvalid) { throw(string("Struct member \"{0}\"not of expected type \"{1}\" in \"{2}\"", name, expectedType, struct)); }
}

function CopyStructProperty(assignTo, fromStruct, key, expectedType = undefined, defaultValue = undefined, throwIfInvalid = false)
{
	var val = GetStructValue(fromStruct, key, expectedType, defaultValue, throwIfInvalid);
	if(IsInstanceOf(assignTo, Map)) 
	{ 
		assignTo.Add(key, val); 
		return;
	}
	
	variable_struct_set(assignTo, key, val);
		
}
