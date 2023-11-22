/*-------------------------- Everything needed to define a 'default' item. --------------------------*/

#region Item Properties
	#region Validation
		function IS_VALID_ITEM_PROPERTY(checking, throwIfInvalid = false)
		{
			Validate(1, checking, TYPE_STRING);
	
			switch(checking)
			{
				case ITEM_FRIENDLY_NAME:
				case ITEM_SHORT_NAME:
				case ITEM_INCOMPATIBLE:
				case ITEM_TYPES:
				case ITEM_DESCRIPTION:
				case ITEM_DESCRIPTION_SHORT:
				case ITEM_ATTACK:
				case ITEM_AMMO_MAX:
				case ITEM_RANGE:
				case ITEM_armour:
				case ITEM_HANDS_RANGED:
				case ITEM_HANDS_MELEE:
				case ITEM_SPECIAL_DESCRIPTION:
				case ITEM_TRAITS:
				case ITEM_PENETRATION:
				case ITEM_INTEGRATED:
				case ITEM_LEGACY_NAME:
				case ITEM_UNIT_STAT_PLUS_MINUS:
				case ITEM_UNIT_EXTRA_HANDS:
				case ITEM_UNIT_STAT_MULTIPLYER:
				case ITEM_REQUIRES:
				case ITEM_PERILS_MULTIPLYER:
				case ITEM_COST:
				case ITEM_OVERHEAT:
				case ITEM_MEDKIT:
				case ITEM_SPLASH: //notably in a lot of the older code rapid fire == splash
				case ITEM_RAPID_FIRE:
				case ITEM_UNKNOWN: //technically known
				case ITEM_DAMAGE_TAKEN_MULTIPLIER:
				case ITEM_RANGED_MULTIPLIER:
				case ITEM_MELEE_MULTIPLIER:
				case ITEM_PSYCHIC:
				case ITEM_MIN_XP:
				case ITEM_BANE:
				case ITEM_REPAIR:
				case ITEM_JUMP_PACK:
					return true;
			}
	
			if(!throwIfInvalid) { return false; }
			throw(string("Unknown item key: \"{0}\"", checking));
		}
	#endregion
	
	#macro ITEM_FRIENDLY_NAME "friendlyName"
	#macro ITEM_COST "cost"
	#macro ITEM_NAME "name"
	#macro ITEM_SHORT_NAME "shortName"
	#macro ITEM_INCOMPATIBLE "incompatible"
	#macro ITEM_TYPES "types" //equip region //todo: refactor/rename
	#macro ITEM_DESCRIPTION "description"
	#macro ITEM_DESCRIPTION_SHORT "descriptionShort"
	#macro ITEM_ATTACK "attack"
	#macro ITEM_AMMO_MAX "ammoMax" //-1 or undefined for unlimited.
	#macro ITEM_RANGE "range" // 1 for melee range.
	#macro ITEM_armour "armour"
	#macro ITEM_HANDS_RANGED "handsRanged"//how many hands it takes up in melee/range. //todo: revisit
	#macro ITEM_HANDS_MELEE "handsMelee"
	#macro ITEM_SPECIAL_DESCRIPTION "specialDescription" //todo: legacy/defunct
	#macro ITEM_TRAITS "traits" //todo: defunct
	#macro ITEM_PENETRATION "penetration" // -1 (low penetration), 1 (penetration) //todo: revisit
	#macro ITEM_INTEGRATED "integrated"
	#macro ITEM_LEGACY_NAME "legacyName" //item name as referenced in legacy code
	#macro ITEM_PERILS_MULTIPLYER "perilsMultiplyer" // perils chance.
	#macro ITEM_UNIT_STAT_MULTIPLYER "statMultiplyer" //generic. Applies this change to the equipped unit. Aplies after plus/minus
	#macro ITEM_UNIT_STAT_PLUS_MINUS "statPlusMinus" //generic. Applies this change. Aplies before multiply.
	#macro ITEM_UNIT_EXTRA_HANDS "extraHands" //item gives extra 'hands' worth of use.
	#macro ITEM_REQUIRES "requires"
	#macro ITEM_SPLASH "splash"
	#macro ITEM_RAPID_FIRE "rapidFire"
	#macro ITEM_OVERHEAT "overheat" //{ "chance": 0-1, "damagePercent": 0-1}. Reduced by armour by default
	#macro ITEM_UNKNOWN "unknown"
	#macro ITEM_MELEE_MULTIPLIER "meleeMultiplier"
	#macro ITEM_RANGED_MULTIPLIER "rangedMultiplier"
	#macro ITEM_BANE "bane"
	#macro ITEM_MIN_XP "minXP"
	#macro ITEM_JUMP_PACK "jumpPack"
	#macro ITEM_DAMAGE_TAKEN_MULTIPLIER "damageTakenMultiplier"
	#macro ITEM_MEDKIT "medkit"
	#macro ITEM_PSYCHIC "psychic"
	#macro ITEM_REPAIR "repair"
#endregion

//Slots that an item can be assiend to. or modifiers thereof
#region Equip Regions
	#region Validation
		//todo: I hate putting a function in globals, yet this seems to be where it belongs
		//this'd be a nightmare to update in multiple places
		function IS_VALID_ITEM_TYPE(region, throwIfInvalid = false) 
		{
			switch(string_lower(region))
			{
				case ITEM_TYPE_armour:
				case ITEM_TYPE_HELD:
				case ITEM_TYPE_BACK:
				case ITEM_TYPE_UNKNOWN: //technically a 'known' region
				case ITEM_TYPE_NONE:
				case ITEM_TYPE_MISC:
				case ITEM_TYPE_SPECIAL:
				case ITEM_TYPE_TERMINATOR:
					return true;
				}
		
			if(!throwIfInvalid) { return false; }
			throw(string("Unknown equip region: \"{0}\"", region));
		}

		function IS_VALID_ITEM_TYPE_ARRAY(regionArray, throwIfInvalid = false)
		{
			if(!is_array(regionArray)) { throw(InvalidArgException(1, regionArray, TYPE_ARRAY)); } 
			//if(!IsInstanceOf(regionArray, TYPE_ARRAY)) { throw(InvalidArgException(1, regionArray, TYPE_ARRAY)); }
	
			for(var i = 0; i < array_length(regionArray); i++)
			{
				if(!IS_VALID_ITEM_TYPE(regionArray[i], throwIfInvalid)) { return false; }
			}
	
			return true;
		}
	#endregion
	
	#macro ITEM_TYPE_TERMINATOR "terminator"
	#macro ITEM_TYPE_armour "armour"
	#macro ITEM_TYPE_HELD "held"
	#macro ITEM_TYPE_BACK "back"
	#macro ITEM_TYPE_UNKNOWN "unknown"
	#macro ITEM_TYPE_NONE "none"
	#macro ITEM_TYPE_MISC "misc"
	#macro ITEM_TYPE_SPECIAL "special"

	//todo: ship/vehicle etc.

#endregion