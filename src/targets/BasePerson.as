package targets 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author marshall
	 */
	public class BasePerson extends Sprite 
	{
		
		public var head:Sprite = new Head() as Sprite;
		public var body:Sprite = new Body() as Sprite;
		public var hair:Sprite = new ShortHair() as Sprite;
		public var hat:Sprite = new Hat() as Sprite;
		public var managerHat:Sprite = new ManagerHat() as Sprite;
		
		public var score:int = 1;
		public var headshotScore:int = 2;
		
		public var type:String;
		
		public function BasePerson() 
		{
			head.x = 8;
			head.y = 6;
			addChild(head);
			
			body.x = 4;
			body.y = 21;			
			addChild(body);
			
			hair.x = 8;
			hair.y = 6;
			addChild(hair);
			hair.mouseEnabled = false;
			hair.visible = false;
			
			hat.y = 4;
			hat.x = 8;
			addChild(hat);
			hat.mouseEnabled = false;
			hat.visible = false;
			
			managerHat.x = 6;
			managerHat.y = 0;
			managerHat.visible = false;
			managerHat.mouseEnabled = false;
			addChild(managerHat);
		}
		
	}

}