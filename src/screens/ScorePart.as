package screens 
{
	import com.greensock.TweenMax;
	import flash.events.Event;
	/**
	 * ...
	 * @author marshall
	 */
	public class ScorePart extends ScoreContainer 
	{
		
		private var adrenaline:int = 0;		
		private var maxAdrenaline:int = 10;
		
		public var adrenalineReady:Boolean = false;
		
		
		public function ScorePart() 
		{
			adrenalineMeter.meter.scaleX = 0;
			adrenalineMeter.text.visible = false;
		}
		
		public function setScore(score:int):void
		{
			tfScore.text = ""+score;
		}
		
		public function setBullets(b:Number):void
		{
			mcBullets.gotoAndStop(b + 1);
		}
		
		public function increaseAdrenaline():void
		{
			if (!adrenalineReady)
			{
				adrenaline++;
				if (adrenaline == maxAdrenaline)
				{
					adrenalineReady = true;
					adrenalineMeter.text.visible = true;
				}
				adrenalineMeter.meter.scaleX = adrenaline / maxAdrenaline;
			}
		}
		
		public function killAdrenaline():void
		{
			adrenaline = 0;
			adrenalineReady = false;
			adrenalineMeter.text.visible = false;
			adrenalineMeter.meter.scaleX = adrenaline / maxAdrenaline;
			TweenMax.killTweensOf(adrenalineMeter.meter, true);
			
		}
		
		public function startAdrenalineMode():void 
		{
			TweenMax.to(adrenalineMeter.meter, 2.5, { scaleX:0, onComplete:endAdrenaline } );
			adrenalineMeter.text.visible = false;
		}
		
		private function endAdrenaline():void 
		{
			dispatchEvent(new Event("adrenalineFinished"));
			adrenalineReady = false;
			adrenaline = 0;
		}
		
	}

}