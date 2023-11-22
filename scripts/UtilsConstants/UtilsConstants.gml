//Yes, i'm reinventing the wheel here due to is_string() etc being a thing.
//But I like my types statically typed/defined to the nines
#region Data Types
	function IS_VALID_TYPE(type, throwIfInvalid = false) 
	{
		switch(string_lower(type))
		{
			case TYPE_NUMBER:
			case TYPE_STRING:
			case TYPE_ARRAY:
			case TYPE_BOOL:
			case TYPE_INT_32:
			case TYPE_INT_64:
			case TYPE_POINTER:
			case TYPE_UNDEFINED:
			case TYPE_NULL:
			case TYPE_VECTOR_3:
			case TYPE_VECTOR_4:
			case TYPE_METHOD:
			case TYPE_STRUCT: 
			case TYPE_REF:
			case TYPE_UNKNOWN: 
				return true;
		
		}
	
		if(!throwIfInvalid) { return false; }
		throw(string("Unknown type: \"{0}\"", type));
	}
	#macro TYPE_NUMBER "number"
	#macro TYPE_STRING "string"
	#macro TYPE_ARRAY "array"
	#macro TYPE_BOOL "bool"
	#macro TYPE_INT_32 "int32"
	#macro TYPE_INT_64 "int64"
	#macro TYPE_POINTER "ptr"
	#macro TYPE_UNDEFINED "undefined"
	#macro TYPE_NULL "null"
	#macro TYPE_VECTOR_3 "vec3"
	#macro TYPE_VECTOR_4 "vec4"
	#macro TYPE_METHOD "method"
	#macro TYPE_STRUCT "struct"
	#macro TYPE_REF "ref"
	#macro TYPE_UNKNOWN "unknown"


#endregion