/*-------------------------- (Hopefully) Everything needed to define a more dynamically generated item. --------------------------*/
#region Dynamic modifiers
	#region Validation
		function IS_VALID_ITEM_MODIFIER(artiMod, throwIfInvalid = false)
		{
			switch(artiMod)
			{
				case ITEM_MODIFIER_CONDITIONAL:
				case ITEM_MODIFIER_PLUS_MINUS:
				case ITEM_MODIFIER_MULTIPLY:
				case ITEM_MODIFIER_TRAIT_ADD:
				case ITEM_MODIFIER_TRAIT_REMOVE:
				case ITEM_MODIFIER_DESCRIPTION:
				case ITEM_MODIFIER_MAX:
				case ITEM_MODIFIER_MIN:
					return true;
			}
			
			if(!throwIfInvalid) { return false; }
			throw(string("Unknown item modifier: \"{0}\"", artiMod));
		}
	
		function IS_VALID_ITEM_MODIFIER_ARRAY(traitArray, throwIfInvalid = false)
		{
			if(!IsInstanceOf(traitArray, TYPE_ARRAY)) { throw(InvalidArgException(1, traitArray, TYPE_ARRAY)); }
		
			for(var i = 0; i < array_length(traitArray); i++)
			{
				if(!IS_VALID_ITEM_PROPERTY(traitArray[i], throwIfInvalid)) { return false; }
			}
		
			return true;
		}
	#endregion

	//explicit definition for modifier order-of-operations
	function ITEM_MODIFIER_INDEX(index)
	{
		switch(index)
		{
			case 0: return ITEM_MODIFIER_DESCRIPTION;
			case 1: return ITEM_MODIFIER_PLUS_MINUS;
			case 2: return ITEM_MODIFIER_MULTIPLY;
			case 3: return ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE;
			case 4: return ITEM_MODIFIER_MAX;
			case 5: return ITEM_MODIFIER_MIN;
		}
		
		return undefined;
	}

	#macro ITEM_MODIFIER_CONDITIONAL "conditions"
	#macro ITEM_MODIFIER_PLUS_MINUS "plusMinus" //eg. ammo etc
	#macro ITEM_MODIFIER_MULTIPLY "multiply" //eg. damage etc.
	#macro ITEM_MODIFIER_TRAIT_ADD "trait add"
	#macro ITEM_MODIFIER_TRAIT_REMOVE "trait remove"
	#macro ITEM_MODIFIER_TRAIT_ADD_OR_REMOVE "trait add remove" // turns into add/remove based on value
	#macro ITEM_MODIFIER_DESCRIPTION "description" //no direct effect
	//!!!!: todo: this will doubtlessly be confusing
	#macro ITEM_MODIFIER_MAX "max"
	#macro ITEM_MODIFIER_MIN "min"
#endregion

#region Dynamic 'Conditionals' that a modifier may be selectively applied under
	//I'm overdesigning this for sure.
	function IS_VALID_CONDITIONAL(conditional, throwIfInvalid = false)
	{
		switch(conditional)
		{
			case CONDITION_ANY:
			case CONDITIONAL_GREATER_THAN:
				return true;
		}
		
		if(!throwIfInvalid) { return false; }
		throw(string("Unknown conitional trait: \"{0}\"", artiMod));
	}
	
	function IS_VALID_CONDITIONAL_ARRAY(conditional, throwIfInvalid = false)
	{
		if(!is_array(conditional)) { throw(InvalidArgException(1, conditional, TYPE_ARRAY)); }
	
		for(var i = 0; i < array_length(conditional); i++)
		{
			if(!IS_VALID_CONDITIONAL(conditional[i], throwIfInvalid)) { return false; }
		}
	
		return true;
	}

	
	#macro CONDITIONAL_GREATER_THAN ">"
	#macro CONDITION_ANY "any"
#endregion