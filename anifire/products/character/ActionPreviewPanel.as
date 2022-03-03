package anifire.products.character
{
   import anifire.core.Action;
   import anifire.core.CharThumb;
   import anifire.core.Character;
   import anifire.core.Console;
   import anifire.util.UtilDict;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Accordion;
   import mx.containers.Canvas;
   import mx.controls.TileList;
   import mx.core.ClassFactory;
   import mx.core.IFlexModuleFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.IndexChangedEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class ActionPreviewPanel extends Canvas
   {
      
      private static var ArrowRightIcon:Class = ActionPreviewPanel_ArrowRightIcon;
      
      private static var ArrowDownIcon:Class = ActionPreviewPanel_ArrowDownIcon;
       
      
      private var _96385acc:Accordion;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      private var __moduleFactoryInitialized:Boolean = false;
      
      private var _character:Character;
      
      private var _selectedTile:ActionItemRenderer;
      
      mx_internal var _ActionPreviewPanel_StylesInit_done:Boolean = false;
      
      public function ActionPreviewPanel()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Accordion,
                  "id":"acc",
                  "events":{"change":"__acc_change"},
                  "stylesFactory":function():void
                  {
                     this.borderStyle = "none";
                     this.headerStyleName = "accHeaderStyle";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "resizeToContent":true,
                        "headerRenderer":_ActionPreviewPanel_ClassFactory1_c()
                     };
                  }
               })]};
            }
         });
         super();
         mx_internal::_document = this;
         this.horizontalScrollPolicy = "off";
      }
      
      override public function set moduleFactory(param1:IFlexModuleFactory) : void
      {
         super.moduleFactory = param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized = true;
         mx_internal::_ActionPreviewPanel_StylesInit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set target(param1:Object) : void
      {
         if(param1 != this._character)
         {
            this._character = param1 as Character;
            this.initAccordion();
         }
      }
      
      private function onTileListItemClick(param1:ListEvent) : void
      {
         var _loc2_:Action = param1.itemRenderer.data as Action;
         if(this._character && _loc2_)
         {
            this._character.setAction(_loc2_.id);
            Console.getConsole().mainStage.sceneEditor.controller.hideControl();
         }
      }
      
      private function initAccordion() : void
      {
         var charThumb:CharThumb = null;
         var xmlChar:XML = null;
         var node:XML = null;
         var cat:XML = null;
         var array:Array = null;
         var canvas:Canvas = null;
         var selectedCanvas:Canvas = null;
         var tileList:TileList = null;
         this.acc.removeAllChildren();
         if(this._character)
         {
            charThumb = this._character.thumb as CharThumb;
            if(charThumb)
            {
               xmlChar = CharThumb(this._character.thumb).xml;
               if(xmlChar.hasOwnProperty("action"))
               {
                  canvas = new Canvas();
                  canvas.name = "Basic";
                  canvas.label = UtilDict.toDisplay("go","Poses") + " (" + xmlChar.action.length() + ")";
                  canvas.percentWidth = 100;
                  canvas.data = charThumb.getActionById(xmlChar.action[0].@id);
                  canvas.icon = ArrowRightIcon;
                  this.acc.addChild(canvas);
                  selectedCanvas = canvas;
               }
               for each(cat in xmlChar.category)
               {
                  canvas = new Canvas();
                  canvas.name = String(cat.@name);
                  canvas.label = UtilDict.toDisplay("store",String(cat.@name)) + " (" + cat.action.length() + ")";
                  canvas.percentWidth = 100;
                  canvas.data = charThumb.getActionById(cat.action[0].@id);
                  canvas.icon = ArrowRightIcon;
                  this.acc.addChild(canvas);
                  if(cat.action.(@id == _character.actionId).length() > 0)
                  {
                     selectedCanvas = canvas;
                  }
               }
               if(selectedCanvas)
               {
                  this.initTileList(selectedCanvas.name,selectedCanvas);
                  this.acc.selectedChild = selectedCanvas;
               }
            }
         }
      }
      
      protected function onAccChange(param1:IndexChangedEvent) : void
      {
         this.initTileList(param1.relatedObject.name,param1.relatedObject as Canvas);
      }
      
      private function initTileList(param1:String, param2:Canvas) : void
      {
         var charThumb:CharThumb = null;
         var xmlChar:XML = null;
         var node:XML = null;
         var cat:XML = null;
         var array:Array = null;
         var tileList:TileList = null;
         var action:Action = null;
         var selectedAction:Action = null;
         var categoryName:String = param1;
         var canvas:Canvas = param2;
         if(canvas.numChildren == 0 && this._character)
         {
            charThumb = this._character.thumb as CharThumb;
            if(charThumb)
            {
               xmlChar = CharThumb(this._character.thumb).xml;
               array = new Array();
               if(categoryName == "Basic")
               {
                  for each(node in xmlChar.action)
                  {
                     if(node.@enable != "N")
                     {
                        action = charThumb.getActionById(node.@id);
                        if(action)
                        {
                           array.push(action);
                           if(action.id == this._character.actionId)
                           {
                              selectedAction = action;
                           }
                        }
                     }
                  }
               }
               else
               {
                  cat = xmlChar.category.(@name == categoryName)[0];
                  for each(node in cat.action)
                  {
                     if(node.@enable != "N")
                     {
                        action = charThumb.getActionById(node.@id);
                        if(action)
                        {
                           array.push(action);
                           if(action.id == this._character.actionId)
                           {
                              selectedAction = action;
                           }
                        }
                     }
                  }
               }
               tileList = new ActionTileList();
               tileList.columnCount = 5;
               tileList.columnWidth = 45;
               tileList.height = 45 * (Math.floor(array.length) / 5 + 1);
               tileList.percentWidth = 100;
               tileList.addEventListener(ListEvent.ITEM_CLICK,this.onTileListItemClick);
               tileList.dataProvider = array;
               tileList.x = 5;
               tileList.y = 5;
               canvas.addChild(tileList);
               tileList.selectedItem = selectedAction;
            }
         }
      }
      
      private function _ActionPreviewPanel_ClassFactory1_c() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         _loc1_.generator = CategoryAccordionHeader;
         return _loc1_;
      }
      
      public function __acc_change(param1:IndexChangedEvent) : void
      {
         this.onAccChange(param1);
      }
      
      mx_internal function _ActionPreviewPanel_StylesInit() : void
      {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_ActionPreviewPanel_StylesInit_done)
         {
            return;
         }
         mx_internal::_ActionPreviewPanel_StylesInit_done = true;
         style = styleManager.getStyleDeclaration(".accHeaderStyle");
         if(!style)
         {
            style = new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".accHeaderStyle",style,false);
         }
         if(style.factory == null)
         {
            style.factory = function():void
            {
               this.highlightAlphas = [0,0];
               this.selectedFillColors = [0,0];
               this.fillColors = [11455193,40447];
               this.fillAlphas = [0,0];
            };
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get acc() : Accordion
      {
         return this._96385acc;
      }
      
      public function set acc(param1:Accordion) : void
      {
         var _loc2_:Object = this._96385acc;
         if(_loc2_ !== param1)
         {
            this._96385acc = param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"acc",_loc2_,param1));
            }
         }
      }
   }
}
