package targets 
{
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author marshall
	 */
	public class Manger extends BasePerson 
	{
		
		public function Manger() 
		{
			type = GameVariables.manager;
			TweenMax.to(body, 0, { tint:0x333333 } );
			TweenMax.to(hat, 0, { tint:0x333333 } );
			managerHat.visible = true;
			score = 2;
			headshotScore = 4;
		}
		
	}

}