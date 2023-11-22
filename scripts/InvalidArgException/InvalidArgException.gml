function InvalidArgException(argIndex, arg, expectedType)
{
	var errorMessage = "Invalid Argument[{0}]: Expected \"{1}\" got \"{2}\"";
	if(is_string(expectedType))
	{
		return string(errorMessage, argIndex, expectedType, typeof(arg));
	}
	
	var types = "";
	for(var i = 0; i < array_length(expectedType); i++)
	{
		if(i > 0) { types += ", "; }
		types += string("\"{0}\"",expectedType[i]);
	}
	
	return string(errorMessage, argIndex, types, typeof(arg));	
}