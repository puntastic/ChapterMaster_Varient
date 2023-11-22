//using: https://stackoverflow.com/a/2031209 as a template for these
#region LOGGING_LEVEL
	function LOGGING_LEVEL_TryValidate(level)
	{
		if(!IsInstanceOf(level, TYPE_NUMBER)) { return undefined; }
		if(level > LOGGING_LEVEL_NONE) { return LOGGING_LEVEL_NONE; }
		if(level < LOGGING_LEVEL_TRACE) { return LOGGING_LEVEL_TRACE; }
	}
	
	#macro LOGGING_LEVEL_TRACE	0 // Only when I would be "tracing" the code and trying to find one part of a function specifically.
	#macro LOGGING_LEVEL_DEBUG	1 // Information that is diagnostically helpful to people more than just developers (IT, sysadmins, etc.).
	#macro LOGGING_LEVEL_INFO	2 // Generally useful information to log (service start/stop, configuration assumptions, etc).
	#macro LOGGING_LEVEL_WARN	3 // Anything that can potentially cause application oddities, but for which I am automatically recovering.
	#macro LOGGING_LEVEL_ERROR	4 // Any error which is fatal to the operation, but not the service or application.
	#macro LOGGING_LEVEL_FATAL	5 // Any error that is forcing a shutdown of the service or application
	#macro LOGGING_LEVEL_NONE	6 // No logging at all
#endregion