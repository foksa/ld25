package 
{
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;
	import screens.GameScreen;
	import screens.StartScreen;

	/**
	 * ...
	 * @author marshall
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		private var startScreen:StartScreen = new StartScreen();
		private var gameScreen:GameScreen = new GameScreen();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			TweenPlugin.activate([TintPlugin]);
			createCursor();
		}

		public function createCursor():void
		{
			if (Mouse.supportsCursor)
			{
				var cursorBd:BitmapData = new BitmapData(17, 17, true, 0x00CCCCCC);
				cursorBd.draw(new CrossHair());
				var cursorVecor:Vector.<BitmapData> = new Vector.<BitmapData>();
				cursorVecor[0] = cursorBd;
				var cursorData:MouseCursorData = new MouseCursorData();
				cursorData.hotSpot = new Point(9, 9);
				cursorData.data = cursorVecor;
				Mouse.registerCursor("crosshair", cursorData);
				Mouse.cursor = "crosshair";
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(startScreen);
			startScreen.addEventListener("start", startGame);
			gameScreen.addEventListener(Event.COMPLETE, restartGame);
		}
		
		private function startGame(e:Event):void 
		{
			removeChild(startScreen)
			addChild(gameScreen);
			gameScreen.reset();
			gameScreen.start();
		}
		
		private function restartGame(e:Event):void
		{
			resetVariables();
			addChild(startScreen);
			removeChild(gameScreen);
		}
		
		private function resetVariables():void 
		{
			
			GameVariables.policemanChance = GameConstants.policemanChance;
			GameVariables.soldierChance = GameConstants.soldierChance;
		}

	}

}