//Not having a well defined entry point to a program unnerves me. 'Spooky action at a distance' and all.
//Mostly used for testing atm
function scr_main() constructor
{
	OnCreate = function()
	{
		logger = new Logging_Controller();
		//log.Register(new Logging_NullLogger());
		logger.Register(new Logging_ConsoleLogger(LOGGING_LEVEL_INFO));
		global.LOG = logger;
		//lootTables=
		//itemTables=

		//configPath =  path_append(program_directory, CONFIG_DIRECTORY);
		if(DEV_BUILD)
		{
			logger.WriteLine("!!!!----Debug Build----!!!!", LOGGING_LEVEL_WARN);

			if(Testing_Run(logger) == 0)
			{
				logger.WriteLine("Some tests failed. Aborting execution", LOGGING_LEVEL_FATAL);
				game_end();
				return;
			}
			//return;
		}

		#region Legacy init
			//expected to be populated/called by the time we get to the main menu
			version=0;
			global.returned=0;
			global.icon_name="";

			instance_create(0,0,obj_img);

			randomize();

			script_execute(scr_unit_stats,0,0,0,0,0);
		#endregion

		var path = CONFIG_DIRECTORY + "/" + ITEM_TABLE_FILE_NAME;
		logger.WriteLine("Loading from:" + CONFIG_DIRECTORY/* path*/, LOGGING_LEVEL_DEBUG);
		//if(!file_exists(path)) { throw ("Could not find item table"); } 
		//var json = json_load(path);
		
		//lootTables = new LootTables(CONFIG_DIRECTORY + "/" + LOOT_TABLES_FILE_NAME);
		//equipmentTable = new ItemTable(log, json_load(CONFIG_DIRECTORY + "/" + ITEM_TABLE_FILE_NAME));
		//artifactTraitTable = new ArtifactTraitTable(json_load(CONFIG_DIRECTORY + "/" + ARTIFACT_TRAIT_TABLE_FILE_NAME));

		// These are 'temporary' globals so i'm not putting them in the main globals file.
		// Basically a way to inject this stuff into the older scripts without larger re-writes
		//global._lootTable = lootTables;
		//global.GetLootTable = function()
		//{
			//throw("Defunct");
		//	show_debug_message("Global GetLootTable Called");
		//	return global._lootTable;
		//
		//todo: config loading to it's own specialized object for easier unit testing
		global._itemTable = new ItemTable(logger, json_load(CONFIG_DIRECTORY + "/" + ITEM_TABLE_FILE_NAME));
		global._itemModifierTable = new ItemModifierTable(logger, json_load(CONFIG_DIRECTORY + "/" + MODIFICATION_TABLE_FILE_NAME));
		global._randomArtifactTable = new PossibleArtifactTable(logger, json_load(CONFIG_DIRECTORY + "/" + ALLOWED_MODIFICATIONS_FILE_NAME));
		
		global.GetItemTable = function() { return global._itemTable; }
		global.GetItemModifierTable = function() { return global._itemModifierTable; }
		global.GetRandomArtifactTable = function() { return global._randomArtifactTable; }
		//up up and awaaaaaaaaay...
		room_goto(Main_Menu);
	}
	
	//OnBeginStep = function() {}
	OnStep = function()
	{
		/*if(DEBUG_BUILD)
		{
			show_debug_message("Activating test harness");
			room_goto(MinAssert_test_runner);
		}*/
	}
	//OnEndStep = function() {}
	
	//OnDestroy = function() {}
	//OnCleanup = function() {}
	
	
	
}