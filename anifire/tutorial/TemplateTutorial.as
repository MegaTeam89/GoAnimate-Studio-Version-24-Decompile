package anifire.tutorial
{
   public class TemplateTutorial extends TutorialObject
   {
       
      
      public function TemplateTutorial()
      {
         super();
         _data = <tutorial>
				<step>
					<message x='0' y='0'>
						{"Insert pre-made scenes in your video. Check out our templates."}
					</message>
					<uncover>
					</uncover>	
					<focus target="TrayPublicTemplate"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<!-- <event type={TutorialEvent.MOUSE_DOWN} rect="{}" /> -->
				</step>
			</tutorial>;
      }
   }
}
