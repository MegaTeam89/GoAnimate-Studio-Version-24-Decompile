package anifire.tutorial
{
   public class TemplateThumbTutorial extends TutorialObject
   {
       
      
      public function TemplateThumbTutorial()
      {
         super();
         _data = <tutorial>
				<step>
					<message x="296" y="200">
						{"Templates are ready-made scenes that include props, text, characters and pre-build effects. You can use them as building blocks to quickly put a video together.\n\nDrag one to the timeline to insert it."}
					</message>
					<uncover>
					</uncover>
					<focus x="253" y="250"/>
					<guide visible="false" action="talk01" facial="head_talk_happy"/>
					<!-- <event type={MouseEvent.CLICK}/> -->
				</step>
			</tutorial>;
      }
   }
}
