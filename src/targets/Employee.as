package targets 
{
	import com.greensock.TweenMax;
	/**
	 * ...
	 * @author marshall
	 */
	public class Employee extends BasePerson 
	{
		
		private var bodyColors:Array = [0x990000, 0x00FF00, 0xC0C0C0, 0x804040, 0xFFFF80, 0xFF80FF, 0x8080FF];
		private var hairColors:Array = [0x000000, 0x400000, 0xFFFF00,0x800003];
		
		public function Employee() 
		{
			type = GameVariables.clerk;
			var hasHair:Boolean = Boolean(int(Math.random() * 3));
			if (hasHair)
			{
				hair.visible = true;
				TweenMax.to(hair, 0, { tint:hairColors[int(Math.random()*hairColors.length)]} );				
			}
			TweenMax.to(body, 0, { tint:bodyColors[int(Math.random()*bodyColors.length)] } );
		}
		
	}

}