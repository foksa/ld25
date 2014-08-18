package screens 
{
	import com.greensock.TweenMax;
	import elements.Windows;
	import events.PersonEvent;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author marshall
	 */
	public class GameScreen extends Sprite
	{
		
		private var building:Sprite = new Building() as Sprite;
		private var windows:Windows = new Windows();
		
		private var scores:ScorePart = new ScorePart();
		
		private var shootSnd:Shoot = new Shoot();
		private var killedSnd:Killed = new Killed();
		
		private var time:uint;
		
		private var score:uint = 0;
		private var clerksKilled:uint = 0;
		private var clerksHeadshots:uint = 0;
		private var managersKilled:uint = 0;
		private var managersHeadshots:uint = 0;
		private var policemenKilled:uint = 0;
		private var policemenHeadshots:uint = 0;
		private var soldiersKilled:uint = 0;
		private var soldiersHeadshots:uint = 0;
		
		private var deathSprite:Sprite = new Sprite()
		
		private var totalKills:uint = 0;
		
		private var bullets:int = 10;
		
		public function GameScreen() 
		{			
			building.x = 40;
			building.y = 100;
			addChild(building);
			windows.x = 40;
			windows.y = 100;
			addChild(windows);
			scores.setBullets(bullets);
			addChild(scores);
			
			deathSprite.graphics.beginFill(0x990000);
			deathSprite.graphics.drawRect(0, 0, 800, 600);
			deathSprite.graphics.endFill();
		}
		
		public function start():void
		{
			addEventListener(Event.ENTER_FRAME, tick);
			addEventListener(MouseEvent.CLICK, shoot);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			time = getTimer();
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				if (scores.adrenalineReady)
				{
					TweenMax.globalTimeScale = 0.5;
					scores.startAdrenalineMode();
					scores.addEventListener("adrenalineFinished", adrenalineFinished);
				}
			}
		}
		
		private function adrenalineFinished(e:Event):void 
		{
			TweenMax.globalTimeScale = 1;
			scores.removeEventListener("adrenalineFinished", adrenalineFinished);
		}
		
		private function playerKilled(e:PersonEvent):void 
		{
			TweenMax.globalTimeScale = 1;
			killedSnd.play();
			deathSprite.alpha = 0.3;
			addChild(deathSprite);
			removeEventListener(Event.ENTER_FRAME, tick);
			removeEventListener(MouseEvent.CLICK, shoot);
			mouseChildren = false;
			mouseEnabled = false;
			windows.end();
			windows.removeEventListener(PersonEvent.HIT, personKilled);
			windows.removeEventListener(PersonEvent.SHOOT, playerKilled);
			TweenMax.delayedCall(2, showGOS);
		}
		
		private function showGOS():void
		{
			removeChild(deathSprite);
			var gameOverScreen:GameOverScreen = new GameOverScreen();
			gameOverScreen.setScore(clerksKilled, clerksHeadshots, managersKilled, managersHeadshots, policemenKilled, policemenHeadshots, soldiersKilled, soldiersHeadshots, score);			
			gameOverScreen.addEventListener(Event.COMPLETE, removeGos);
			addChild(gameOverScreen);
			windows.clear();
			mouseChildren = true;
			mouseEnabled = true;
		}
		
		private function removeGos(e:Event):void 
		{
			removeChild(GameOverScreen(e.target));
		}
		
		private function shoot(e:MouseEvent):void 
		{
			if (e.target is Head)
			{
				scores.increaseAdrenaline();
			}
			else if (!(e.target is Body))
			{
				scores.killAdrenaline();
			}
			bullets--;
			shootSnd.play();
			scores.setBullets(bullets);
			if (bullets == 0) 
			{
				mouseChildren = false;
				mouseEnabled = false;
				var t:Timer = new Timer(2000, 1);
				t.addEventListener(TimerEvent.TIMER, reload)
				t.start();
			}
		}
		
		private function reload(e:TimerEvent):void 
		{
			bullets = 10;
			scores.setBullets(bullets);
			mouseChildren = true;
			mouseEnabled = true;
		}		
		
		private function personKilled(e:PersonEvent):void
		{
			score += e.score;
			totalKills++;
			if (!(totalKills % 10))
			{
				GameVariables.soldierChance += totalKills / 20000;
				GameVariables.policemanChance += totalKills / 10000;
			}
			switch (e.personType) 
			{
				case GameVariables.clerk:
					clerksKilled++;
					if (e.headshot) clerksHeadshots++;
				break;
				case GameVariables.manager:
					managersKilled++;
					if (e.headshot) managersHeadshots++;
				break;
				case GameVariables.policeman:
					policemenKilled++;
					if (e.headshot) policemenHeadshots++;
				break;
				case GameVariables.soldier:
					soldiersKilled++;
					if (e.headshot) soldiersHeadshots++;
				break;
			}
			scores.setScore(score);
		}
		
		private function tick(e:Event):void 
		{
			var timeElapsed:uint = getTimer();
			if (timeElapsed - time > 1000)
			{
				time = timeElapsed;
				windows.tick();
			}
		}
		
		public function reset():void
		{
			score = clerksKilled = clerksHeadshots = managersKilled = managersHeadshots = policemenKilled = policemenHeadshots = soldiersKilled = soldiersHeadshots  = totalKills = 0;
			bullets = 10;
			scores.setScore(score);
			scores.setBullets(bullets);
			scores.adrenalineReady = false;
			scores.killAdrenaline();
			windows.addEventListener(PersonEvent.HIT, personKilled);
			windows.addEventListener(PersonEvent.SHOOT, playerKilled);
		}
		
	}

}