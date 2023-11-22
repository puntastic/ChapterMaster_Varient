function ItemModifier(name, fromStruct = undefined) constructor
{
	#region Variables
		_name = undefined;
		_operations = undefined;
	#endregion
	
	#region Functions
		function GetOperations() { return _operations; }
		function GetOperationsFiltered(targetName)
		{
			var found = [];
			for(var i = 0; i < array_length(_operations); i++)
			{
				var current = _operations[i];
				if(current.GetTargetName() != targetName) { continue; }
				
				array_push(found, current);
			}
			
			return found;
		}
	#endregion
	
	#region Constructor
		function _ItemModifier(name, fromStruct)
		{
			_name = Validate(1, name, TYPE_STRING, true) ?? UNKNOWN;
			Validate(2, fromStruct, TYPE_ARRAY);
			
			_operations = [];
	
			if(IsEqual(fromStruct, undefined)) { return; } //empty item def
			
			for(var i = 0; i < array_length(fromStruct); i++)
			{
				var currentOperation = new ModifierOperation(fromStruct[i]);
				array_push(_operations, currentOperation);
			}
		}
		
		_ItemModifier(name, fromStruct);
	#endregion

}