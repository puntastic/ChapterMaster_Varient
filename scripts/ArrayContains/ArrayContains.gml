function ArrayContains(arr, contains)
{
	Validate(1, arr, TYPE_ARRAY);
	for(var i = 0; i < array_length(arr); i++)
	{
		if(arr[i] == contains) { return true; }
	}
	
	return false;
}