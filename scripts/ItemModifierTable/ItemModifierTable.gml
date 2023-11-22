//Similar behavior to the (inherited) LookupTable. However items may get a duplicate entry under a 'legacy' name.
function ItemModifierTable(log, loadedStruct) : LookupTable(log) constructor
{
	#region Variables
		//_log = log;
		
	#endregion
	
	#region Functions
	
		function GetOperationCollection(names) { return GetAll(names); }
		
	#endregion
	
	#region Constructor
		function _ItemModifierTable(loadedStruct)
		{
			//_LookupTable(Item, loadedStruct);
			
			var names = variable_struct_get_names(loadedStruct);
			for(var i = 0; i < array_length(names); i++)
			{
				var currentItem = new ItemModifier(names[i], variable_struct_get(loadedStruct, names[i]));
				_TryAdd(names[i], currentItem);
				//_lookup.Add(names[i], currentItem);			
			}
		}
		
		_ItemModifierTable(loadedStruct);
	#endregion
}