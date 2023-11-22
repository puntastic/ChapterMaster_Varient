function Item(log = undefined, nameOrClone = undefined, fromStruct = undefined, modifierNames = undefined, modifiers = undefined) constructor
{
	#region Variables
		_log = undefined;
		_name = undefined;
		_properties = undefined; //originally a wrapper struct for ds_map, now just the id
		_modifierNames = undefined; //set as a string array if this is an item modified from the base template
		_modifiers = undefined;
	#endregion
	
	#region Functions
		//meant to be read-only once initially created
		function _RemoveTrait(trait) { ds_map_delete(_properties, trait); /*_properties.Remove(trait);*/ }	
		function _SetTrait(trait, value) 
		{ 
			if(!IS_VALID_ITEM_PROPERTY(trait)) { throw(string("Invalid item trait \"{0}\" in \"{1}\"", trait, _name));}	
			//_properties.Set(trait, value); 
			ds_map_set(_properties, trait, value);
		}
		
		function _ColateOperationsFiltered(targetName)
		{
			var found = [];
			for(var i = 0; i < array_length(_modifiers); i++)
			{
				var current = _modifiers[i].GetOperationsFiltered(targetName);
				if(array_length(current) == 0) { continue; }
				
				found = array_concat(found, current);
			}
			
			return found;
		}
		
		
		function _ColateOperations()
		{
			var found = [];
			for(var i = 0; i < array_length(_modifiers); i++)
			{
				var current = _modifiers[i].GetOperations();
				if(array_length(current) == 0) { continue; }
				
				found = array_concat(found, current);
			}
			
			return found;
		}
		
		function _UpdateWithModifications()  
		{ 
			var operations = _ColateOperations();
			
			var i = 0;
			var operationName = ITEM_MODIFIER_INDEX(i);
			do
			{
				_ApplyAllOperationsMatching(operationName, operations)
				
				i++;
				operationName = ITEM_MODIFIER_INDEX(i);
			} until (is_undefined(operationName));
		}
		
		function _ApplyAllOperationsMatching(operationName, operations)
		{
			//todo: optimization and/or caching
			for(var i = 0; i < array_length(operations); i++)
			{
				var current = operations[i];
				if(current.GetOperation() != operationName) { continue; }
				current.Apply(_properties);
			}
		}
		
		function GetName() { return _name; }
		function GetFriendlyName()
		{
			//todo: prefix/postfix?
			if(!HasProperty(ITEM_FRIENDLY_NAME)) { return GetName(); }
			return GetProperty(ITEM_FRIENDLY_NAME); //'special' item probably
		}
		
		
		function HasProperty(name) { return !is_undefined(ds_map_find_value(_properties, name)); } 
		function GetProperty(name) { return ds_map_find_value(_properties, name);}
		
		function HasTrait(trait) { return HasProperty(trait); } //defunct, use HasPropery
		function GetTrait(trait) { return GetProperty(trait); }	//defunct, use GetPropety
		
		function IsModified() { return !IsEqual(_modifierNames, undefined); }
		function GetModifierNames() { return _modifierNames ?? []; }
		
		function Clone(modifierNames = undefined, modifiers = undefined) { return new Item(_log, self, undefined, modifierNames, modifiers); }
		
		
		
		function ToString()
		{
			//todo: strictly speaking this should be unchanging for any given item
			//so it can all be precalculated
			
			var str = GetName();
			if(!IsModified()) { return str; }
			
			
			for(var i = 0; i < array_length(_modifierNames); i++)
			{
				// having two different dilimeters isn't really necessary (first index should always be an item name)
				// but it does slightly improve the readability of the end result
				
				//todo: since i'm being pedantic elsewhere these should probably be a predefined macro too	
				if(i == 0) { str += "&"; } 
				else { str += "|"; }
				
				str += _modifierNames[i];
			}
			
			return str;
		}
		
	#endregion
	
	#region Constructor
		function _Item_Clone(original, modifierNames = undefined, modifiers = undefined)
		{
			_name = original._name;
			//_properties = new Map(original._properties);
			_properties = ds_map_create();
			ds_map_copy(_properties, original._properties);

			
			_modifierNames = modifierNames;
			_modifiers = modifiers;
			
			if(IsModified()) { _UpdateWithModifications(); }
		}
		
		function _Item(name, fromStruct, modifierNames = undefined, modifiers = undefined)
		{	
			_name = Validate(2, name, TYPE_STRING, true) ?? UNKNOWN;
			Validate(3, fromStruct, TYPE_STRUCT, true);
			
			//_properties = new Map();
			_properties = ds_map_create();
			_modifierNames = modifierNames;
			_modifiers = modifiers;
	
			if(IsEqual(fromStruct, undefined)) { return; } //empty item def
			
			var fieldNames = variable_struct_get_names(fromStruct);
			for(var i = 0; i < array_length(fieldNames); i++)
			{
				var currentName = fieldNames[i];				
				_SetTrait(currentName, variable_struct_get(fromStruct, currentName));
			}
			
			if(IsModified()) { _UpdateWithModifications(); }
		}
		
		_log = is_undefined(log) ? new Logging_NullLogger() : log;//todo: validate
		
		if(is_instanceof(nameOrClone, Item)) {_Item_Clone(nameOrClone, modifierNames, modifiers)}
		else { _Item(nameOrClone, fromStruct, modifierNames, modifiers); }
		
	#endregion
	
	#region Destructor
		_isDestroyed = false;
		
		function Destroy(deepScan = false)
		{
			if(_isDestroyed) { return; }
			_isDestroyed = true;
		
			//todo:!!!!:potential memory leak if not used correctly
			if(is_undefined(_properties)) { return; }
			if(!ds_exists(_properties, ds_type_map)) 
			{
				_properties = undefined;
				return;
			}
			
			ds_map_destroy(_properies);
			_properties = undefined;
			//_properties.Destroy(deepScan);
		}
	#endregion
	//todo: destructor
}
