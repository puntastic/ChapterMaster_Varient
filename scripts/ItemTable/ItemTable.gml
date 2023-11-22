//Similar behavior to the (inherited) LookupTable. However items may get a duplicate entry under a 'legacy' name.
function ItemTable(log, loadedStruct) : LookupTable(log) constructor
{
	#region Variables
		//_log = log;
		
	#endregion
	
	#region Functions
	
		
		function GetItem(itemName, modifierNames = undefined, modifiers = undefined)
		{
			if(!KeyExists(itemName)) { return undefined };
			
			var item = GetValue(itemName);
			if(is_undefined(modifierNames)) { return item; }
			
			return item.Clone(modifierNames, modifiers);
		}
	#endregion
	
	#region Constructor
		function _ItemTable(loadedStruct)
		{
			//_LookupTable(Item, loadedStruct);
			
			var names = variable_struct_get_names(loadedStruct);
			for(var i = 0; i < array_length(names); i++)
			{
				var currentItem = new Item(_log, names[i], variable_struct_get(loadedStruct, names[i]));
				_lookup.Add(names[i], currentItem);
				
				// Also add under a legacy name (if any) so old code can interact with it
				//!!!!: not only is such an item added twice, but should it clash with another item of the same
				//	name undefined behavior will occur. 
				//
				// (Normally not a problem since json requires unique property names.)
				if(!currentItem.HasProperty(ITEM_LEGACY_NAME)) { continue; }
				_lookup.Add(currentItem.GetProperty(ITEM_LEGACY_NAME), currentItem);				
			}
		}
		
		_ItemTable(loadedStruct);
	#endregion
}