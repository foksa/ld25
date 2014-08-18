package targets 
{
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author marshall
	 */
	public class Policeman extends BasePerson 
	{
		
		public function Policeman() 
		{
			type = GameVariables.policeman;
			TweenMax.to(body, 0, { tint:0x3300FF } );
			TweenMax.to(hat, 0, { tint:0x3300FF } );
			hat.visible = true;
			score = 5;
			headshotScore = 10;
			
			
		}
		
	}

}