package elements 
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenMax;
	import events.PersonEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import targets.BasePerson;
	import targets.Employee;
	import targets.Manger;
	import targets.Policeman;
	import targets.Soldier;
	/**
	 * ...
	 * @author marshall
	 */
	public class BaseWindow extends Sprite
	{
		
		private var personMask:Sprite = new Sprite();	
		private var person:BasePerson;
		
		
		
		
		public function BaseWindow() 
		{
			personMask.graphics.beginFill(0);
			personMask.graphics.drawRect(0, 0, 30, 50);
			personMask.graphics.endFill();
			addChild(personMask);
			personMask.visible = false;
		}
		
		public function tick():void
		{
			if (person)
				return;
			var fromLeft:Boolean = Boolean(int(Math.random() * 2));
			if (Math.random() < GameVariables.soldierChance)
			{
				person = new Soldier();
				person.y = 50;
				TweenMax.to(person, GameVariables.soldierSpeed, { y:0, onComplete:soldierShown, ease:Linear.easeNone } );				
			}
			else if (Math.random() < GameVariables.policemanChance)
			{
				person = new Policeman();
				person.y = 50;
				TweenMax.to(person, GameVariables.policemanSpeed, { y:0, onComplete:policemanShown, ease:Linear.easeNone } );
			}
			else if (Math.random()<GameVariables.employeeChance)
			{
				person = new Employee();
				person.x = fromLeft? -30:30;
				TweenMax.to(person, GameVariables.personSpeed, { x:fromLeft?30: -30, onComplete:removePerson, ease:Linear.easeNone } );				
			}
			else if (Math.random()<GameVariables.managerChance)
			{				
				person = new Manger();
				person.x = fromLeft? -30:30;
				TweenMax.to(person, GameVariables.mangerSpeed, { x:fromLeft?30: -30, onComplete:removePerson, ease:Linear.easeNone } );				
			}			
			if (person)
			{
				addChild(person);
				person.mask = personMask;
				person.addEventListener(MouseEvent.CLICK, personHit);
			}
		}
		
		public function end():void 
		{
			TweenMax.killAll();			
		}
		
		public function clear():void
		{
			if (person && person.parent)
			{
				removeChild(person);
				person = null;
			}
		}
		
		private function soldierShown():void 
		{
			TweenMax.to(person, GameVariables.solderAim, {onComplete:killPlayer})
		}
		
		private function policemanShown():void 
		{
			TweenMax.to(person, GameVariables.policemanAim, {onComplete:killPlayer})
		}
		
		private function killPlayer():void 
		{
			var fire:Fire = new Fire();
			fire.x = 13;
			fire.y = 26;
			person.addChild(fire);
			var pe:PersonEvent = new PersonEvent(PersonEvent.SHOOT, true);
			dispatchEvent(pe);
		}
		
		
		
		private function personHit(e:MouseEvent):void 
		{
			var pe:PersonEvent = new PersonEvent(PersonEvent.HIT, true);
			pe.headshot = e.target == person.head;
			pe.score = pe.headshot?person.headshotScore:person.score;
			pe.personType = person.type;
			TweenMax.killTweensOf(person);
			TweenMax.to(person, 0.3, { height:1, y:50, onComplete:removePerson } );
			dispatchEvent(pe);
		}
		
		private function removePerson():void 
		{
			removeChild(person);
			person = null;
		}
	}

}