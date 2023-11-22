//todo: this and children thereof should probably be modified to use the load_json_data()
//methods of the project they're being imported into, for consistency sake.
function LookupTable(log, containedType = undefined, loadedStruct = undefined) constructor
{
	#region Variables
		_log = log;
		_lookup = ds_map_create();//new Map();
	#endregion
	
	#region Functions
		function _TryAdd(key, value) { return ds_map_add(_lookup, key, value); }
		
		function KeyExists(name) { return !is_undefined(ds_map_find_value(_lookup, name));/*_lookup.KeyExists(name);*/ } 
		function GetValue(name) { return ds_map_find_value(_lookup, name);/*_lookup.GetValue(name); */}
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
		//function Clear() { _items.Clear(); }
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
		
		if(typeof(self) == typeof(LookupTable)) { _LookupTable(containedType, loadedStruct); }
	#endregion
	
	#region Destructor
		isDestroyed = false;
		function Destroy(deepScan = false)
		{
			if(_isDestroyed) { return; }
			_isDestroyed = true;
			
			
			if(is_undefined(_lookup))  { return; }
			if(!ds_exists(_lookup, ds_type_map))
			{
				_lookup = undefined; 
				return;
			}
				/*_lookup.Destroy(deepScan)*/;
			ds_map_destroy(_lookup);
			_lookup = undefined;
		}
	#endregion
}