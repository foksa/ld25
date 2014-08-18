package targets 
{
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author marshall
	 */
	public class Soldier extends BasePerson 
	{
		
		public function Soldier() 
		{
			type = GameVariables.soldier;
			TweenMax.to(body, 0, { tint:0x336633 } );
			TweenMax.to(hat, 0, { tint:0x336633 } );
			hat.visible = true;
			score = 10;
			headshotScore = 20;
		}
		
	}

}