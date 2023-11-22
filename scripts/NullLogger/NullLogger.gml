//Does nothing with inputs. Baseline skeleton
function Logging_NullLogger(logLevel = LOGGING_LEVEL_FATAL) : ALoggerBase(logLevel) constructor
{
	#region Variables
//		_logLevel = LOGGING_LEVEL_FATAL;
	#endregion
	
	#region Constructor
		//script_execute_ext(method_get_index(self._Construct), [logLevel]);
		
		//_Construct = function(logLevel) {  }
	#endregion
	
	#region Functions
		Write = function(text, logLevel = LOGGING_LEVEL_DEBUG) { }
		WriteLine = function(text, logLevel = LOGGING_LEVEL_DEBUG) { }
		SetLogLevel = function(logLevel) { }
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