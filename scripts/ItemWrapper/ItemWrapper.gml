//nothing is as permament as a temporary solution
function ItemWrapper(item = undefined) constructor
{
	_item				= undefined;
	_types				= undefined;
	
	name				= undefined;//argument[0];
	description			= undefined;//is_undefined(argument[1]) ? "N/A" : argument[1];
	descriptionShort	= undefined;//is_undefined(argument[2]) ? "N/A" : argument[2];
	attack				= undefined;//is_undefined(argument[3]) ? 0 : argument[3];
	range				= undefined;//is_undefined(argument[4]) ? 0 : argument[4];
	penetration			= undefined;//is_undefined(argument[5]) ? 0 : argument[5];
	ammo				= undefined;//is_undefined(argument[6]) ? -1  : argument[6];
	rangedHands			= undefined;//is_undefined(argument[7]) ? 0 : argument[7];
	meleeHands			= undefined;//is_undefined(argument[8]) ? 0 : argument[8];
	armor				= undefined;//is_undefined(argument[9]) ? 0 : argument[9];	
	isArmor				= undefined;//is_undefined(argument[10]) ? 0 : argument[10];
	split				= undefined;//is_undefined(argument[11]) ? 0 : argument[11]; //split(?) written as 'spli' in the original code. Seemingly 'splash weapon'
	specialDescription	= undefined;//is_undefined(argument[12]) ? "" : argument[12];
	
	
	#region Functions
		function IsType(itemType)
		{
			if(!_item.HasProperty(ITEM_TYPES)) { return false; }
			return ArrayContains(_item.GetProperty(ITEM_TYPES), itemType);
		}
	#endregion
	
	#region Constructor
		function _ItemWrapper(item)
		{
			_item = Validate(1, item, [Item/*, Artifact*/], true) ?? new Item();
		
			name = _item.GetProperty(ITEM_NAME);
	
			//item has been given a different name than what's given in legacy code?
			if(!is_undefined(_item.GetProperty(ITEM_LEGACY_NAME))) { name = _item.GetProperty(ITEM_LEGACY_NAME); }
	
			description = _item.GetProperty(ITEM_DESCRIPTION) ?? "";
			descriptionShort = _item.GetProperty(ITEM_DESCRIPTION_SHORT) ?? "";
			attack = _item.GetProperty(ITEM_ATTACK) ?? 0;
			range = _item.GetProperty(ITEM_RANGE) ?? 0;
			ammo = _item.GetProperty(ITEM_AMMO_MAX) ?? -1;
			rangedHands = _item.GetProperty(ITEM_HANDS_RANGED) ?? 0;
			meleeHands = _item.GetProperty(ITEM_HANDS_MELEE) ?? 0;
			armor = _item.GetProperty(ITEM_ARMOR) ?? 0;
			specialDescription = "";//"N/A";
			penetration = _item.GetProperty(ITEM_PENETRATION) ?? 0;
			isArmor = IsType(ITEM_TYPE_ARMOR);
			
	
			split = 0; 
			if(_item.HasProperty(ITEM_RAPID_FIRE)) { split = 1; }
			if(_item.HasProperty(ITEM_SPLASH)) { split = 1; }
		}
		
		_ItemWrapper(item);
	
	#endregion
	
	
}