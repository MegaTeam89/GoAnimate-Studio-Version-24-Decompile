package anifire.banner
{
   import anifire.util.UtilNavigate;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class GoSchoolBanner extends Sprite
   {
       
      
      private var bgClass:Class;
      
      private var BtnClass:Class;
      
      private var _bg:MovieClip;
      
      private var _bar:Sprite;
      
      private var status:TextField;
      
      public function GoSchoolBanner()
      {
         this.bgClass = GoSchoolBanner_bgClass;
         this.BtnClass = GoSchoolBanner_BtnClass;
         this.status = new TextField();
         super();
      }
      
      public function init(param1:String = "en_US") : void
      {
         if(param1 != "en_US" && param1 != "ja_JP" && param1 != "zh_TW")
         {
            param1 = "en_US";
         }
         this._bg = new this.bgClass();
         addChild(this._bg);
         var _loc2_:XML = <msg>
					<status>
						<en_US>Loading...</en_US>
						<zh_TW>工作室下載中...</zh_TW>
						<ja_JP>工作室はダウンロード...</ja_JP>
					</status>
					<title>
						<en_US>DID YOU KNOW?!</en_US>
						<zh_TW>你知道嗎?!</zh_TW>
						<ja_JP>DID YOU KNOW?!</ja_JP>
					</title>
					<subtitle>
						<en_US>With a School Account</en_US>
						<zh_TW>With a School Account</zh_TW>
						<ja_JP>With a School Account</ja_JP>
					</subtitle>
					<content>
						<en_US>
							Privacy, security, content moderation and group management tools are built in! Clean content at a deep discount!
						</en_US>
						<zh_TW>
							Privacy, security, content moderation and group management tools are built in! Clean content at a deep discount!
						</zh_TW>
						<ja_JP>
							Privacy, security, content moderation and group management tools are built in! Clean content at a deep discount!
						</ja_JP>
					</content>
					<btnLabel>
						<en_US>More Info</en_US>
						<zh_TW>More Info</zh_TW>
						<ja_JP>More Info</ja_JP>
					</btnLabel>
				</msg>;
         this._bg.addChild(this.status);
         this.status.x = 160;
         this.status.y = 315;
         this.status.width = 300;
         var _loc3_:TextFormat = new TextFormat();
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.color = 16777215;
         _loc3_.size = 16;
         _loc3_.bold = true;
         _loc3_.font = "trebuchet MS";
         this.status.defaultTextFormat = _loc3_;
         this.status.text = _loc2_.status.child(param1);
         var _loc4_:TextField = new TextField();
         this._bg.addChild(_loc4_);
         _loc4_.x = 20;
         _loc4_.y = 20;
         _loc4_.width = 400;
         _loc3_ = new TextFormat();
         _loc3_.color = 16777215;
         _loc3_.size = 34;
         _loc3_.font = "trebuchet MS";
         _loc3_.bold = true;
         _loc4_.defaultTextFormat = _loc3_;
         _loc4_.text = _loc2_.subtitle.child(param1);
         var _loc5_:TextField;
         (_loc5_ = new TextField()).x = 50;
         _loc5_.y = 75;
         _loc5_.width = 300;
         _loc3_ = new TextFormat();
         _loc3_.align = TextFormatAlign.CENTER;
         _loc3_.color = 16777215;
         _loc3_.size = 18;
         _loc3_.font = "trebuchet MS";
         _loc5_.defaultTextFormat = _loc3_;
         _loc5_.text = _loc2_.subtitle.child(param1);
         var _loc6_:TextField = new TextField();
         this._bg.addChild(_loc6_);
         _loc6_.x = 20;
         _loc6_.y = 70;
         _loc6_.width = 350;
         _loc6_.height = 500;
         _loc3_ = new TextFormat();
         _loc3_.color = 16777215;
         _loc3_.size = 18;
         _loc3_.font = "trebuchet MS";
         _loc3_.leading = 3;
         _loc3_.bold = true;
         _loc6_.wordWrap = true;
         _loc6_.defaultTextFormat = _loc3_;
         _loc6_.htmlText = _loc2_.content.child(param1);
         var _loc7_:MovieClip;
         (_loc7_ = new this.BtnClass()).x = 20;
         _loc7_.y = 170;
         _loc7_.addEventListener(MouseEvent.CLICK,this.onClick);
         this._bg.addChild(_loc7_);
         var _loc8_:TextField;
         (_loc8_ = new TextField()).x = 80;
         _loc8_.y = 174;
         _loc8_.width = 200;
         _loc3_ = new TextFormat();
         _loc3_.color = 16777215;
         _loc3_.size = 15;
         _loc3_.bold = true;
         _loc3_.font = "trebuchet MS";
         _loc8_.defaultTextFormat = _loc3_;
         _loc8_.text = _loc2_.btnLabel.child(param1);
         _loc8_.mouseEnabled = false;
         this._bg.addChild(_loc8_);
      }
      
      public function set statusText(param1:String) : void
      {
         this.status.text = param1;
      }
      
      private function onClick(param1:Event) : void
      {
         UtilNavigate.toG4S("preloader","_blank");
      }
   }
}
