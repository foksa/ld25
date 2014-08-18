package screens 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author marshall
	 */
	public class StartScreen extends IntroScreen
	{
		
		public function StartScreen() 
		{
			btnStart.addEventListener(MouseEvent.CLICK, startGame);
		}
		
		private function startGame(e:MouseEvent):void 
		{
			dispatchEvent(new Event("start"));
		}
		
	}

}