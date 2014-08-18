package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author marshall
	 */
	public class PersonEvent extends Event 
	{
		
		public static const HIT:String = "hit";
		public static const SHOOT:String = "shoot";
		
		public var headshot:Boolean = false;
		public var score:int = 0;
		
		public var personType:String;
		
		public function PersonEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new PersonEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PersonEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}