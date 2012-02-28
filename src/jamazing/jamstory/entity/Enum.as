//	Copyright 2012 Jamazing Games©
//	Author: Gordon D Mckendrick
//
//	Enum
//		Enumerated type, missing from the flash language
//		This is a typesafe and self-numering Enum implementation


package jamazing.jamstory.entity 
{
		
	//	Class: Enum
	public class Enum 
	{       
			protected var value:int;       				//	The Integer value of this Enum
			protected var string:String;    			//	The String representation of the Enum
			private static var isInitialised:Boolean;	//	Used for first time initialisation of the value etc
			private static var count:int;				//	The next value to assign to an Enum
	 
			//      Constructor: (Enum, int, String)
			public function Enum(enum:Enum, value:int = 0, string:String = null)
			{
				if (isInitialised) {
					if (value == 0) {
						this.value = count++;
					}else{
						this.value = value;
						count++;
					}
				}else {
					count = value + 1;
					isInitialised = true;
					this.value = value;
				}
			}
			
			//	Function: setString ( String = null)
			//	Used to set the String representation for this Enum value
			protected function setString(string:String = null):void
			{
				this.string = string;
			}
			
			//	Accessor: valueOf()
			//	Returns the integer value of this Enum
			public function valueOf():int
			{
				return ( this.value ); 
			}
			
			//	Accessor: toString()
			//	Returns the String representation of this Enum
			public function toString():String 
			{
				return ( this.string ); 
			}
			
	}

}