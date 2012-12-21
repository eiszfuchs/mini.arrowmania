package de.eiszfuchs.utils {

	import flash.net.SharedObject;

	/**
	 * Useful class to keep track of settings, like the last dimensions that were used or the author's name.
	 * It can even return default values back if there was no key set before.
	 *
	 * Sets tile_width to the last used value or 8 if it was not set before.
	 * @usage	foo = Settings.getSetting('bar', 'fallback_value');
	 *
	 * @version 1
	 * @author	eiszfuchs
	 */
	public class Settings {

		// SharedObject local key
		protected static const SHARED_KEY:String = "eiszfuchs/arrowmania/3";

		// data
		protected static var settings:Object = new Object;

		/**
		 * Get a setting's value by its name.
		 * @author eiszfuchs
		 *
		 * @param	key				name of the setting
		 * @param	defaultValue	fallback value if it was not set
		 * @return	setting value OR fallback value
		 */
		public static function getSetting(key:String, defaultValue:*):* {
			if (!settings[key]) return defaultValue;
			return settings[key];
		}

		/**
		 * Set a setting's value by its name.
		 * @author eiszfuchs
		 *
		 * @param	key		name of the setting
		 * @param	value	anything!
		 */
		public static function setSetting(key:String, value:*):void {
			settings[key] = value;
			store();
		}

		/**
		 * Store everything on the client's machine.
		 * @author eiszfuchs
		 */
		public static function read():void {
			var shared:SharedObject;
			shared = SharedObject.getLocal(SHARED_KEY);
			settings = shared.data;
		}

		/**
		 * Get all settings, if they were saved before.
		 * @author eiszfuchs
		 */
		private static function store():void {
			var shared:SharedObject;
			shared = SharedObject.getLocal(SHARED_KEY);
			for(var key:* in settings) {
				shared.data[key] = settings[key];
			}
			shared.flush();
		}

		/**
		 * Static initializer.
		 * @author eiszfuchs
		 */
		{ loadSettings(); }
		private static function loadSettings():void {
			// get all settings that were stored. if any.
			read();
		}
	}
}
