package anifire.banner
{
   import anifire.component.GoActionBanner;
   import anifire.component.GoUpgradeBanner;
   import anifire.constant.ThemeConstants;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.core.Thumb;
   import anifire.managers.FeatureManager;
   import flash.events.MouseEvent;
   import mx.containers.Canvas;
   import mx.containers.ViewStack;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.events.PropertyChangeEvent;
   
   public class GoAdv extends Canvas
   {
       
      
      private var _1003743490actionBanner:GoActionBanner;
      
      private var _657850472upgradeBanner:GoUpgradeBanner;
      
      private var _459389001vsBanner:ViewStack;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _character:Character;
      
      public function GoAdv()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":ViewStack,
                  "id":"vsBanner",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":GoActionBanner,
                           "id":"actionBanner",
                           "events":{"click":"__actionBanner_click"},
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        }),new UIComponentDescriptor({
                           "type":GoUpgradeBanner,
                           "id":"upgradeBanner",
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.visible = false;
         this.includeInLayout = false;
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function refresh(param1:Character) : void
      {
         if(this._character != param1)
         {
            this._character = param1;
            this.includeInLayout = this.visible = false;
            if(!Console.getConsole().isTutorialOn)
            {
               if(Math.round(Math.random()) == 1)
               {
                  if(this.shouldShowActionBanner)
                  {
                     this.actionBanner.refresh(this._character.thumb as CharThumb);
                     this.vsBanner.selectedChild = this.actionBanner;
                     this.includeInLayout = this.visible = true;
                  }
                  else if(this.shouldShowUpgradeBanner)
                  {
                     this.upgradeBanner.refresh();
                     this.vsBanner.selectedChild = this.upgradeBanner;
                     this.includeInLayout = this.visible = true;
                  }
               }
               else if(this.shouldShowUpgradeBanner)
               {
                  this.upgradeBanner.refresh();
                  this.vsBanner.selectedChild = this.upgradeBanner;
                  this.includeInLayout = this.visible = true;
               }
               else if(this.shouldShowActionBanner)
               {
                  this.actionBanner.refresh(this._character.thumb as CharThumb);
                  this.vsBanner.selectedChild = this.actionBanner;
                  this.includeInLayout = this.visible = true;
               }
            }
         }
      }
      
      private function onActionBannerClick() : void
      {
         Console.getConsole().showActionShopWindow(Thumb(this._character.thumb).id,Thumb(this._character.thumb));
      }
      
      private function get shouldShowActionBanner() : Boolean
      {
         if(this._character == null)
         {
            return false;
         }
         if(FeatureManager.shouldActionPackBeShown && !Console.getConsole().isTutorialOn)
         {
            if(CharThumb(this._character.thumb).ccThemeId == "cc2" || CharThumb(this._character.thumb).ccThemeId == ThemeConstants.CHIBI_THEME_ID || CharThumb(this._character.thumb).ccThemeId == ThemeConstants.NINJA_THEME_ID || CharThumb(this._character.thumb).ccThemeId == ThemeConstants.ANIME_THEME_ID || CharThumb(this._character.thumb).ccThemeId == ThemeConstants.NINJAANIME_THEME_ID || CharThumb(this._character.thumb).ccThemeId == ThemeConstants.SPACE_CITIZEN_THEME_ID)
            {
               return true;
            }
         }
         return false;
      }
      
      private function get shouldShowUpgradeBanner() : Boolean
      {
         return FeatureManager.shouldUpgradeBannerBeShown;
      }
      
      public function __actionBanner_click(param1:MouseEvent) : void
      {
         this.onActionBannerClick();
      }
      
      [Bindable(event="propertyChange")]
      public function get actionBanner() : GoActionBanner
      {
         return this._1003743490actionBanner;
      }
      
      public function set actionBanner(param1:GoActionBanner) : void
      {
         var _loc2_:Object = this._1003743490actionBanner;
         if(_loc2_ !== param1)
         {
            this._1003743490actionBanner = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"actionBanner",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get upgradeBanner() : GoUpgradeBanner
      {
         return this._657850472upgradeBanner;
      }
      
      public function set upgradeBanner(param1:GoUpgradeBanner) : void
      {
         var _loc2_:Object = this._657850472upgradeBanner;
         if(_loc2_ !== param1)
         {
            this._657850472upgradeBanner = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"upgradeBanner",_loc2_,param1));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get vsBanner() : ViewStack
      {
         return this._459389001vsBanner;
      }
      
      public function set vsBanner(param1:ViewStack) : void
      {
         var _loc2_:Object = this._459389001vsBanner;
         if(_loc2_ !== param1)
         {
            this._459389001vsBanner = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"vsBanner",_loc2_,param1));
            }
         }
      }
   }
}
