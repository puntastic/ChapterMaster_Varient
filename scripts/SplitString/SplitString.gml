function SplitString(text, delimiter = ",")
{
	if(string_length(text) == 0) { return [""]; }
	var output = [];
	var tmp = "";
	var currentChar;
	
	for(var i = 1; i <= string_length(text); i++)
	{
		currentChar = string_char_at(text, i)
		if(currentChar == delimiter) 
		{
			array_push(output, tmp);
			tmp="";
			continue;
		}
		
		tmp += currentChar;		
	}
	if(string_length(tmp) > 0) { array_push(output, tmp); }
	
	return output;
}