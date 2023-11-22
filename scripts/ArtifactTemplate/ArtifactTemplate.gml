function ArtifactTemplate(name, allowed) constructor
{
	_name = undefined;
	_allowed = undefined;
	
	function GetItemName() { return _name; }
	function GetAllowed() { return _allowed; }
	function PickModifier()
	{
		if(is_undefined(_allowed)) { return undefined; }
		if(array_length(_allowed) == 0) { return undefined; }
		
		var picked = _allowed[random_range(0, array_length(_allowed))];
		
		if(is_string(picked)) { return picked; }
		//if(IsInstanceOf(picked, TYPE_STRING)) { return picked; }
		if(array_length(picked) == 0) { return undefined; }
		if(array_length(picked) == 1) { return picked[0]; }
		
		return picked[random_range(0, array_length(picked))];
	}
	
	#region Constructor
	function _ArtifactTemplate(name, allowed)
	{	
		_name = name;
		_allowed = allowed;
	}
	
	_ArtifactTemplate(name, allowed)
	#endregion
}

