package elements 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author marshall
	 */
	public class Windows extends Sprite
	{
		
		private var windows:Vector.<BaseWindow>
		
		public function Windows() 
		{
			windows = new Vector.<BaseWindow>();
			for (var i:int = 0; i < 5; i++) 
			{
				for (var j:int = 0; j < 14; j++) 
				{
					var t:BaseWindow = new BaseWindow();
					t.x = 20 + j * 50;
					t.y = 25 + i * 75;
					windows.push(t);
					addChild(t);
				}
			}
		}
		
		public function tick():void
		{
			for each (var w:BaseWindow in windows)
			{
				w.tick();
			}
		}
		
		public function end():void
		{
			for each (var w:BaseWindow in windows)
			{
				w.end();
			}
		}
		
		public function clear():void 
		{
			for each (var w:BaseWindow in windows)
			{
				w.clear();
			}
		}
		
	}

}