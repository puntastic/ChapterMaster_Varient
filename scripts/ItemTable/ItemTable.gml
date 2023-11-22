//Similar behavior to the (inherited) LookupTable. However items may get a duplicate entry under a 'legacy' name.
function ItemTable(log, loadedStruct) : LookupTable(log) constructor
{
	#region Variables
		//_log = log;
		
	#endregion
	
	#region Functions
		function TryGetItem(rawName, modifierTable = undefined)
		{
			if(is_undefined(rawName)) { return false; }
	
			var itemDescriptor = SplitString(rawName, "&");//artifact?
			var itemName = itemDescriptor[0];
	
			if(string_length(itemName) == 0)  { return false; } //non existant item
			if(array_length(itemDescriptor) == 1) { return GetItem(itemName) ?? false; }
			if(is_undefined(modifierTable)) { return GetItem(itemName) ?? false; }
	
			//todo: further parsing for underslung etc.
			var modifierNames = SplitString(itemDescriptor[1], "|"); 
			var modifiers = modifierTable.GetOperationCollection(modifierNames);
	
			return GetItem(itemName, modifierNames, modifiers) ?? false;
		}
		
		function GetItem(itemName, modifierNames = undefined, modifiers = undefined)
		{
			Validate(1, itemName, TYPE_STRING); 
			
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
				_TryAdd(names[i], currentItem);
				//_lookup.Add(names[i], currentItem);
				
				// Also add under a legacy name (if any) so old code can interact with it
				//!!!!: not only is such an item added twice, but should it clash with another item of the same
				//	name undefined behavior will occur. 
				//
				// (Normally not a problem since json requires unique property names.)
				if(!currentItem.HasProperty(ITEM_LEGACY_NAME)) { continue; }
				_TryAdd(currentItem.GetProperty(ITEM_LEGACY_NAME), currentItem);
				//_lookup.Add(currentItem.GetProperty(ITEM_LEGACY_NAME), currentItem);				
			}
		}
		
		_ItemTable(loadedStruct);
	#endregion
}