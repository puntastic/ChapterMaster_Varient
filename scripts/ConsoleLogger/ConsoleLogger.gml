function Logging_ConsoleLogger(logLevel = LOGGING_LEVEL_DEBUG) : ALoggerBase(logLevel) constructor
{
	#region Variables
		//_logLevel = LOGGING_LEVEL_DEBUG;
	#endregion
	
	#region Constructor
		//script_execute_ext(method_get_index(self._Construct), [logLevel]);
		
		//_Construct = function(logLevel) { SetLogLevel(logLevel); }
	#endregion
	
	#region Functions
		Write = function(text, logLevel = LOGGING_LEVEL_DEBUG) { WriteLine(logLevel, text); }
		WriteLine = function(text, logLevel = LOGGING_LEVEL_DEBUG) 
		{
			if(logLevel < _logLevel) { return; }
			
			//Game maker console auto-newlines
			show_debug_message(text);
		}
		SetLogLevel = function(logLevel) { _logLevel = LOGGING_LEVEL_TryValidate(logLevel) ?? _logLevel;  }
	#endregion
	
	#region Desctructor
		_isDestroyed = false;
		static Destroy = function()
		{
			if(_isDestroyed) { return; }
			_isDestroyed = true;
			
			//
		}
	#endregion
}