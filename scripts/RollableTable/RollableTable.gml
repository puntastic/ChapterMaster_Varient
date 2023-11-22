//Similar behavior to the (inherited) LookupTable. However items may get a duplicate entry under a 'legacy' name.
function RollableTable() constructor
{
	#region Variables
		//_log = log;
		_possible = [];
		_max = 0;
	#endregion
	
	#region Functions
	function Add(result, chance = 1)
	{
		array_push(_possible, new Rollable(result, chance));
		_max += chance;
	}
	
	function AddArray(resultArray)
	{
		Validate(1, resultArray, TYPE_ARRAY);
		for(var i = 0; i < array_length(resultArray); i++)
		{
			Add(resultArray[i]);
		}
	}
	
	function Pick()
	{
		if(array_length(_possible) == 0) { return undefined; }
		var val =  random_range(0,_max);
		
		for(var i =0; i < array_length(_possible); i++)
		{
			var current = _possible[i];
			if(val < current.GetChance()) { return current.GetResult(); }
			
			val -= current.GetChance();
		}
		
		throw("Invalid Operation");
	}
	#endregion
	
	#region Constructor
		
	#endregion
}

function Rollable(result, chance) constructor
{
	_chance = chance;
	_result = result;
	
	function GetChance() { return _chance; }
	function GetResult() { return _result; }
}