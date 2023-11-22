function ModifierOperation(operationOrStruct = ITEM_MODIFIER_DESCRIPTION, target = undefined, value = undefined, conditions = undefined) constructor
{
	_operation = undefined;
	_target = undefined;
	_value = undefined;
	_conditions = undefined;
	
	#region Functions	
		function _IsAddRemove(operation) 
		{
			Validate(1, operation, TYPE_STRING);
			
			if(operation == ITEM_MODIFIER_TRAIT_ADD) { return true; }
			if(operation == ITEM_MODIFIER_TRAIT_REMOVE) { return true; }
			if(operation == ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE) { return true; }
			
			return false;
		}
		
		function TryGetMerged(mergeWith) { return CanMergeWith(mergeWith) ?  GetMerged(mergeWith) : undefined; }
		function CanMergeWith(mergeWith)
		{
			Validate(1, mergeWith, ModifierOperation);
			
			if(_operation == ITEM_MODIFIER_DESCRIPTION || mergeWith._operation == ITEM_MODIFIER_DESCRIPTION) { return false; }
			//if(!IsEqual(_conditions), undefined)
			//if(array_length(_conditions ?? []) + array_length(mergeWith._conditions ?? []) > 0) { throw("Not Implemented"); } //todo:
			
			return (_IsAddRemove(_operation) && _IsAddRemove(mergeWith._operation)) 
				|| IsEqual(_operation, mergeWith._operation);
		}
		
		//Operations should be derterministic no matter the order they arrive in.
		//Merging them here allows for a less finicky array traversal
		//And gives one place for the logic to sit
		function GetMerged(mergeWith)
		{
			Validate(1, mergeWith, ModifierOperation);
			if(!CanMergeWith(mergeWith)) {throw("Operation must match"); }
			if(!IsEqual(_target, mergeWith._target)) { throw("Target must match"); }
				
			switch(_operation)
			{
				//case ITEM_MODIFIER_DESCRIPTION:  return new ModifierOperation();
				case ITEM_MODIFIER_PLUS_MINUS: return new ModifierOperation(_operation, _target, GetValue() + mergeWith.GetValue());
				case ITEM_MODIFIER_MULTIPLY: return new ModifierOperation(_operation, _target, (GetValue() + mergeWith.GetValue()) - 1);
				case ITEM_MODIFIER_MAX: return new ModifierOperation(_operation, target, max(GetValue(), mergeWith.GetValue()));
				case ITEM_MODIFIER_MIN: return new ModifierOperation(_operation, target, min(GetValue(), mergeWith.GetValue()));
				case ITEM_MODIFIER_TRAIT_ADD:
				case ITEM_MODIFIER_TRAIT_REMOVE:
				case ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE:
					return new ModifierOperation(ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE, _target, GetValue() + mergeWith.GetValue());
			}
			
			throw("Not Implemented");
		}
		
		function GetOperation() { return _operation; }
		function GetTarget() { return _target; }
		function GetValue() 
		{
			if(GetOperation() == ITEM_MODIFIER_TRAIT_ADD) { return _value ?? 1; }
			if(GetOperation() == ITEM_MODIFIER_TRAIT_REMOVE) { return _value ?? -1; }
			
			return _value;
		}
		
		function Apply(itemTraits)
		{
			Validate(1, itemTraits, Map);
			if(!IsEqual(_conditions, undefined) && !_conditions.IsTrue(itemTraits)) { return; }
			
			switch(_operation)
			{
				case ITEM_MODIFIER_DESCRIPTION: return;
				case ITEM_MODIFIER_TRAIT_ADD:
				case ITEM_MODIFIER_TRAIT_REMOVE:
				case ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE:
					if(GetValue() > 0) { itemTraits.Add(_target, true); }
					if(GetValue() < 0) { itemTraits.Remove(_target); }
					return;
			}
			
			if(!itemTraits.KeyExists(_target)) { return; }			
			itemTraits.Set(_target, GetApplyValue(itemTraits.GetValue(_target)));
		}
		
		function GetApplyValue(baseValue)
		{
			//if(IsEqual(baseValue, TYPE_UNDEFINED)) { return undefined; }
			baseValue = baseValue ?? 0;
			
			switch(_operation)
			{
				case ITEM_MODIFIER_DESCRIPTION: return;
				case ITEM_MODIFIER_PLUS_MINUS: return baseValue + GetValue();		
				//case ITEM_MODIFIER_MULTIPLY: return baseValue * (GetValue() - 1);
				case ITEM_MODIFIER_MULTIPLY: return baseValue * GetValue();				
				case ITEM_MODIFIER_TRAIT_ADD:
				case ITEM_MODIFIER_TRAIT_REMOVE:
				case ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE:
					return GetValue();
			}
			
			throw("Invalid Operation");
		}
	#endregion
	
	#region Constructor	
		function _ModifierOperation(operation, target, value, conditions)
		{
			Validate(1, operation, TYPE_STRING);
			IS_VALID_ITEM_MODIFIER(operation, true);
			_operation = operation;
			
			if(!IsEqual(conditions, undefined)) { _conditions = new ConditionalCollection(conditions); }
			
			//todo: refactor into seperate related objects?
			switch(_operation)
			{
				case ITEM_MODIFIER_DESCRIPTION:
					_value = Validate(3, value, TYPE_STRING);
					return;
					
				case ITEM_MODIFIER_TRAIT_ADD:
				case ITEM_MODIFIER_TRAIT_REMOVE:
					_target = Validate(2, target, TYPE_STRING);
					return;
				
				case ITEM_MODIFIER_PLUS_MINUS:
				case ITEM_MODIFIER_MULTIPLY:
					_target = Validate(2, target, TYPE_STRING);
					_value = Validate(3, value, TYPE_NUMBER);
					return;
					
				case ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE:
					_target = Validate(2, target, TYPE_STRING);
					_value = Validate(3, value, TYPE_NUMBER, true) ?? 0;
					if(_value > 0) { _operation = ITEM_MODIFIER_TRAIT_ADD; }
					if(_value < 0) { _operation = ITEM_MODIFIER_TRAIT_REMOVE; }
					return;
					
				case ITEM_MODIFIER_MAX:
				case ITEM_MODIFIER_MIN:
					_target = Validate(2, target, TYPE_STRING);
					_value = Validate(3, value, TYPE_NUMBER);
					return
			}
			
			throw("Not Implemented");
		}
		
		function _ModifierOperation_FromStruct(fromStruct)
		{
			 _ModifierOperation
			 (
				ExistsOrDefault(fromStruct, "operation", undefined),
				ExistsOrDefault(fromStruct, "target", undefined),
				ExistsOrDefault(fromStruct, "value", undefined),
				ExistsOrDefault(fromStruct, "conditions", undefined)
				//GetStructValue(fromStruct, "operation", undefined, true),
				//GetStructValue(fromStruct, "target", undefined, false),
				//GetStructValue(fromStruct, "value", undefined, false),
				//GetStructValue(fromStruct, "conditions", undefined, false)
			);
		}
		
		
		//TryValidate(index, value, expectedTypes, allowUndefined = false, throwIfInvalid = true)
		if(TryValidate(1, operationOrStruct, [TYPE_STRUCT], false, false)) { _ModifierOperation_FromStruct(operationOrStruct); }
		else { _ModifierOperation (operationOrStruct, target, value, conditions); }
		
	#endregion
}