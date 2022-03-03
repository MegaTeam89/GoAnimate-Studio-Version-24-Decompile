package anifire.font
{
   import anifire.constant.ServerConstants;
   import anifire.util.Util;
   import anifire.util.UtilLicense;
   import flash.text.Font;
   import mx.collections.ArrayCollection;
   import mx.controls.ComboBox;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.events.FlexEvent;
   
   public class FontFamilyComboBox extends ComboBox
   {
      
      private static const accidental_presidency:Class = FontFamilyComboBox_accidental_presidency;
      
      private static const arial:Class = FontFamilyComboBox_arial;
      
      private static const bodoniXT:Class = FontFamilyComboBox_bodoniXT;
      
      private static const boom:Class = FontFamilyComboBox_boom;
      
      private static const brawler:Class = FontFamilyComboBox_brawler;
      
      private static const budmo:Class = FontFamilyComboBox_budmo;
      
      private static const budmoj:Class = FontFamilyComboBox_budmoj;
      
      private static const casual:Class = FontFamilyComboBox_casual;
      
      private static const comicbook:Class = FontFamilyComboBox_comicbook;
      
      private static const coming_soon:Class = FontFamilyComboBox_coming_soon;
      
      private static const courier_new:Class = FontFamilyComboBox_courier_new;
      
      private static const entrails:Class = FontFamilyComboBox_entrails;
      
      private static const existence_light:Class = FontFamilyComboBox_existence_light;
      
      private static const glegoo:Class = FontFamilyComboBox_glegoo;
      
      private static const heart:Class = FontFamilyComboBox_heart;
      
      private static const honey:Class = FontFamilyComboBox_honey;
      
      private static const ihate:Class = FontFamilyComboBox_ihate;
      
      private static const impactl:Class = FontFamilyComboBox_impactl;
      
      private static const lilita_one:Class = FontFamilyComboBox_lilita_one;
      
      private static const locotvt:Class = FontFamilyComboBox_locotvt;
      
      private static const mailrayt:Class = FontFamilyComboBox_mailrayt;
      
      private static const Shanghai:Class = FontFamilyComboBox_Shanghai;
      
      private static const tahoma:Class = FontFamilyComboBox_tahoma;
      
      private static const telex:Class = FontFamilyComboBox_telex;
      
      private static const times:Class = FontFamilyComboBox_times;
      
      private static const tokyo:Class = FontFamilyComboBox_tokyo;
      
      private static const woodstamp:Class = FontFamilyComboBox_woodstamp;
      
      private static const pmingliu:Class = FontFamilyComboBox_pmingliu;
      
      public static const FONT_LIST:Array = [{
         "label":"Accidental Presidency",
         "data":"Accidental Presidency",
         "source":"go",
         "image":accidental_presidency,
         "enabled":true
      },{
         "label":"BodoniXT",
         "data":"BodoniXT",
         "source":"go",
         "image":bodoniXT,
         "enabled":true
      },{
         "label":"Boom",
         "data":"BadaBoom BB",
         "source":"go",
         "image":boom,
         "enabled":true
      },{
         "label":"Brawler",
         "data":"Brawler",
         "source":"ggoogle",
         "image":brawler,
         "enabled":true
      },{
         "label":"Budmo Jiggler",
         "data":"Budmo Jiggler",
         "source":"go",
         "image":budmo,
         "enabled":true
      },{
         "label":"Budmo Jigglish",
         "data":"Budmo Jigglish",
         "source":"go",
         "image":budmoj,
         "enabled":true
      },{
         "label":"Casual",
         "data":"Blambot Casual",
         "source":"go",
         "image":casual,
         "enabled":true
      },{
         "label":"Comic Book",
         "data":"Comic Book",
         "source":"go",
         "image":comicbook,
         "enabled":true
      },{
         "label":"Coming Soon",
         "data":"Coming Soon",
         "source":"ggoogle",
         "image":coming_soon,
         "enabled":true
      },{
         "label":"Entrails",
         "data":"Entrails BB",
         "source":"go",
         "image":entrails,
         "enabled":true
      },{
         "label":"Existence Light",
         "data":"Existence Light",
         "source":"go",
         "image":existence_light,
         "enabled":true
      },{
         "label":"Glegoo",
         "data":"Glegoo",
         "source":"ggoogle",
         "image":glegoo,
         "enabled":true
      },{
         "label":"HeartlandRegular",
         "data":"HeartlandRegular",
         "source":"go",
         "image":heart,
         "enabled":true
      },{
         "label":"Honey Script",
         "data":"Honey Script",
         "source":"go",
         "image":honey,
         "enabled":true
      },{
         "label":"I hate Comic Sans",
         "data":"I hate Comic Sans",
         "source":"go",
         "image":ihate,
         "enabled":true
      },{
         "label":"Impact Label",
         "data":"Impact Label",
         "source":"go",
         "image":impactl,
         "enabled":true
      },{
         "label":"Lilita One",
         "data":"Lilita One",
         "source":"ggoogle",
         "image":lilita_one,
         "enabled":true
      },{
         "label":"loco tv",
         "data":"loco tv",
         "source":"go",
         "image":locotvt,
         "enabled":true
      },{
         "label":"Mail Ray Stuff",
         "data":"Mail Ray Stuff",
         "source":"go",
         "image":mailrayt,
         "enabled":true
      },{
         "label":"Shanghai",
         "data":"Shanghai",
         "source":"go",
         "image":Shanghai,
         "enabled":true
      },{
         "label":"Telex Regular",
         "data":"Telex Regular",
         "source":"ggoogle",
         "image":telex,
         "enabled":true
      },{
         "label":"Tokyo",
         "data":"Tokyo Robot Intl BB",
         "source":"go",
         "image":tokyo,
         "enabled":true
      },{
         "label":"Wood Stamp",
         "data":"Wood Stamp",
         "source":"go",
         "image":woodstamp,
         "enabled":true
      }];
       
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _myFontList:Array;
      
      public function FontFamilyComboBox()
      {
         super();
         this.rowCount = 10;
         this.buttonMode = true;
         this.itemRenderer = this._FontFamilyComboBox_ClassFactory1_c();
         this.addEventListener("creationComplete",this.___FontFamilyComboBox_ComboBox1_creationComplete);
      }
      
      public static function listFonts() : Array
      {
         var _loc4_:Font = null;
         var _loc1_:Array = Font.enumerateFonts(true);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = _loc1_[_loc3_];
            if(UtilLicense.isBubbleI18NPermitted() || Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
            {
               if(_loc4_.fontName == "Arial" || _loc4_.fontName == "Courier New" || _loc4_.fontName == "Tahoma" || _loc4_.fontName == "Times New Roman" || _loc4_.fontName == "新細明體")
               {
                  _loc2_.push({
                     "label":_loc4_.fontName,
                     "data":_loc4_.fontName,
                     "source":"system",
                     "image":getImageClassByName(_loc4_.fontName),
                     "enabled":(_loc4_.fontName == "Arial" ? true : false)
                  });
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function getImageClassByName(param1:String) : Class
      {
         switch(param1)
         {
            case "Arial":
               return arial;
            case "Courier New":
               return courier_new;
            case "Tahoma":
               return tahoma;
            case "Times New Roman":
               return times;
            case "新細明體":
               return pmingliu;
            default:
               return null;
         }
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
         super.initialize();
      }
      
      private function get fullFontList() : Array
      {
         var _loc1_:Array = null;
         if(this._myFontList)
         {
            return this._myFontList;
         }
         if(Util.getFlashVar().getValueByKey(ServerConstants.PARAM_ISOFFLINE) == "1")
         {
            _loc1_ = listFonts();
         }
         else
         {
            _loc1_ = FONT_LIST.concat(listFonts());
         }
         _loc1_.sortOn(["source","label"]);
         this._myFontList = _loc1_.concat();
         return this._myFontList;
      }
      
      protected function onCreationComplete(param1:FlexEvent) : void
      {
         this.updateFontList();
      }
      
      private function updateFontList() : void
      {
         var _loc2_:Object = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.fullFontList)
         {
            if(_loc2_.enabled == true)
            {
               _loc1_.push(_loc2_);
            }
         }
         this.dataProvider = _loc1_;
      }
      
      public function selectFont(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:ArrayCollection = null;
         var _loc4_:uint = 0;
         for each(_loc2_ in this.fullFontList)
         {
            if(_loc2_.data == param1 && _loc2_.enabled == false)
            {
               _loc2_.enabled = true;
               this.updateFontList();
            }
         }
         _loc3_ = this.dataProvider as ArrayCollection;
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_].data == param1)
               {
                  this.selectedIndex = _loc4_;
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      private function _FontFamilyComboBox_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = FontFamilyComboBoxInnerClass0;
         _loc1_.properties = {"outerDocument":this};
         return _loc1_;
      }
      
      public function ___FontFamilyComboBox_ComboBox1_creationComplete(param1:FlexEvent) : void
      {
         this.onCreationComplete(param1);
      }
   }
}
