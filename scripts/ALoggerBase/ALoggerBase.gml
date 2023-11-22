//Does nothing with inputs. Baseline skeleton
function ALoggerBase(logLevel = LOGGING_LEVEL_FATAL) constructor
{
	#region Variables
		_logLevel = logLevel;
	#endregion
	
	#region Constructor
		//script_execute_ext(method_get_index(self._Construct), [logLevel]);
		
		//_Construct = function(logLevel) { _logLevel = logLevel; }
	#endregion
	
	#region Functions
		Write = function(text, logLevel = LOGGING_LEVEL_DEBUG) { throw("Not implemented"); }
		WriteLine = function(text, logLevel = LOGGING_LEVEL_DEBUG) { throw("Not implemented"); }
		SetLogLevel = function(logLevel) { throw("Not implemented"); }
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