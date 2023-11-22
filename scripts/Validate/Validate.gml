function Validate(index, value, expectedTypes, allowUndefined = false)
{
	if(!TryValidate(index, value, expectedTypes, allowUndefined, true))
	{
		return undefined;
	}
	
	return value;
}

function TryValidate(index, value, expectedTypes, allowUndefined = false, throwIfInvalid = true)
{
	if(is_undefined(value))
	{
		if(allowUndefined) { return true; }
		throw(InvalidArgException(index, value, expectedTypes));
	}
	
	if(!IsInstanceOf(expectedTypes, TYPE_ARRAY))
	{
		if(IsInstanceOf(value, expectedTypes)) { return true; }
	
		if(!throwIfInvalid) { return false; }
		throw(InvalidArgException(index, value, expectedTypes));
	}
	
	
	
	for(var i = 0; i < array_length(expectedTypes); i++)
	{
		if(IsInstanceOf(value, expectedTypes[i])) { return true;}
	}
	
	if(!throwIfInvalid) { return false; }
	throw(InvalidArgException(index, value, expectedTypes));
}