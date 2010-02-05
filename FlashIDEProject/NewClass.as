package  
{
	import fl.controls.Button;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author K.Yoshioka
	 */
	public class NewClass extends Sprite
	{
		
		public function NewClass() 
		{
			trace("hello");
			var button:Button = new Button;
			this.addChild(button);
			
		}
		
		
	}

}