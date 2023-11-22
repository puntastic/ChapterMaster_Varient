function LookupTable(log, containedType = undefined, loadedStruct = undefined) constructor
{
	#region Variables
		_log = log;
		_lookup = new Map();
	#endregion
	
	#region Functions
		function KeyExists(name) { return _lookup.KeyExists(name); } 
		function GetValue(name) { return _lookup.GetValue(name); }
		function GetAll(names)
		{
			Validate(1, names, TYPE_ARRAY, false);
			
			var found = [];
			for(var i = 0; i < array_length(names); i++)
			{
				var current = names[i];
				if(KeyExists(current)) { array_push(found, GetValue(current)); }
			}
			
			return found;
		}
		function Clear() { _items.Clear(); }
	#endregion
	
	#region Constructor
		function _LookupTable(containedType, loadedStruct)
		{
			throw ("Not Implemented");
			//todo: check value against containedType
			/*if(IsEqual(containedType, undefined)) { return; }
			if(IsEqual(loadedStruct, undefined)) { return; }
			
			for(var i = 0; i < array_length(names); i++)
			{
				var current = new containedType(log, names[i], variable_struct_get(loadedStruct, names[i]));
				_lookup.Add(names[i], current);
			}*/
		}
		
		if(is_instanceof(self, LookupTable)) { _LookupTable(containedType, loadedStruct); }
	#endregion
	
	#region Destructor
		isDestroyed = false;
		function Destroy(deepScan = false)
		{
			if(_isDestroyed) { return; }
			_isDestroyed = true;
			
			if(_lookup != undefined) { _lookup.Destroy(deepScan); }
		}
	#endregion
}