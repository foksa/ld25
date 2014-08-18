package screens 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author marshall
	 */
	public class GameOverScreen extends GOScreen 
	{
		
		public function GameOverScreen() 
		{
			btnOk.addEventListener(MouseEvent.CLICK, close);
		}
		
		private function close(e:MouseEvent):void 
		{
			var ev:Event = new Event(Event.COMPLETE, true);
			dispatchEvent(ev);
		}
		
		public function setScore(ck:int, ch:int, mk:int, mh:int, pk:int, ph:int, sk:int, sh:int, score:int ):void
		{
			tfCK.text = ""+ck;
			tfCH.text = ""+ch;
			tfMK.text = ""+mk;
			tfMH.text = ""+mh;
			tfPK.text = ""+pk;
			tfPH.text = ""+ph;
			tfSK.text = ""+sk;
			tfSH.text = ""+sh;
			tfTK.text = ""+(ck+mk+pk+sk);
			tfTH.text = ""+(ch+mh+ph+sh);
			tfScore.text = ""+(score);
		}
		
	}

}