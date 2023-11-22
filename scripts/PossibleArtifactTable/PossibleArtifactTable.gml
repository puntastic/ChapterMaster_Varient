//Similar behavior to the (inherited) LookupTable. However items may get a duplicate entry under a 'legacy' name.
function PossibleArtifactTable(log, loadedStruct) : LookupTable(log) constructor
{
	#region Variables
		//_log = log;
	#endregion
	
	#region Functions
		function _LoadMultiple(current)
		{
			Validate(1, current.names, TYPE_ARRAY);
			var group = new PossibleArtifactTable(_log, undefined);
			
			for(var i = 0; i < array_length(current.names); i++)
			{
				var currentName = current.names[i];
				var currentPossible = new ArtifactTemplate(currentName, current.allowed);
				group._lookup.Add(currentName, currentPossible);		
			}
			
			_lookup.Add(current.name, group);		
		}

		function GetGroup(groupName)
		{
			if(!KeyExists(groupName)) { throw("not found"); }
			
			var group = GetValue(groupName);
			if(!IsInstanceOf(group, PossibleArtifactTable)) { throw ("Not table"); }
			
			return group._lookup.GetAllValues();
		}
	#endregion
	
	#region Constructor
		function _PossibleArtifactTable(loadedStruct)
		{
			if(is_undefined(loadedStruct)) { return; }
			Validate(1, loadedStruct, TYPE_ARRAY);
			
			
			for(var i = 0; i < array_length(loadedStruct); i++)
			{
				var current = loadedStruct[i];
				Validate(1, current.name, TYPE_STRING);
				Validate(1, current.allowed, TYPE_ARRAY);
				
				if(variable_struct_exists(current, "names"))
				{
					_LoadMultiple(current);
					continue;
				}
				
				var currentPossible = new ArtifactTemplate(current.name, current.allowed);
				_lookup.Add(current.name, currentPossible);		
			}
		}
		
		_PossibleArtifactTable(loadedStruct);
	#endregion
}