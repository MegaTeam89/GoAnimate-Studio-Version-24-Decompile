package anifire.assets.view
{
   import anifire.events.AssetViewEvent;
   import anifire.events.BubbleAssetEvent;
   import anifire.interfaces.IAssetView;
   import anifire.interfaces.IBubbleText;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class TextableAssetView extends AbstractAssetViewDecorator
   {
       
      
      public function TextableAssetView(param1:IAssetView)
      {
         super(param1);
         param1.addEventListener(AssetViewEvent.VIEW_LOAD_COMPLETE,this.onDecoratedLoadComplete);
         this.addAssetEventListeners(param1.asset);
      }
      
      private function onDecoratedLoadComplete(param1:Event) : void
      {
         this.updateDecorated();
      }
      
      private function updateDecorated() : void
      {
         if(decorated.asset is IBubbleText)
         {
            this.changeText(decorated.asset as IBubbleText);
         }
         if(decorated.asset is IBubbleText)
         {
            this.changeTextColor(decorated.asset as IBubbleText);
         }
         if(decorated.asset is IBubbleText)
         {
            this.changeTextFont(decorated.asset as IBubbleText);
         }
         if(decorated.asset is IBubbleText)
         {
            this.changeTextAlign(decorated.asset as IBubbleText);
         }
         if(decorated.asset is IBubbleText)
         {
            this.changeTextBold(decorated.asset as IBubbleText);
         }
         if(decorated.asset is IBubbleText)
         {
            this.changeTextEmbed(decorated.asset as IBubbleText);
         }
      }
      
      override protected function onDecoratedChange(param1:Event) : void
      {
      }
      
      override public function destroy(param1:String = "rip") : void
      {
         this.removeAssetEventListeners(super.asset);
         super.destroy(param1);
      }
      
      private function addAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.addEventListener(BubbleAssetEvent.TEXT_CHANGE,this.onTextChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_COLOR_CHANGE,this.onTextColorChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_FONT_CHANGE,this.onTextFontChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_ALIGN_CHANGE,this.onTextAlignChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_BOLD_CHANGE,this.onTextBoldChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_EMBED_CHANGE,this.onTextEmbedChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_STYLE_CHANGE,this.onTextStyleChange);
            param1.addEventListener(BubbleAssetEvent.TEXT_SIZE_CHANGE,this.onTextSizeChange);
            param1.addEventListener(BubbleAssetEvent.AUTO_TEXT_RESIZE_CHANGE,this.onAutoTextResizeChange);
         }
      }
      
      private function removeAssetEventListeners(param1:IEventDispatcher) : void
      {
         if(param1)
         {
            param1.removeEventListener(BubbleAssetEvent.TEXT_CHANGE,this.onTextChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_COLOR_CHANGE,this.onTextColorChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_FONT_CHANGE,this.onTextFontChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_ALIGN_CHANGE,this.onTextAlignChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_BOLD_CHANGE,this.onTextBoldChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_EMBED_CHANGE,this.onTextEmbedChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_STYLE_CHANGE,this.onTextStyleChange);
            param1.removeEventListener(BubbleAssetEvent.TEXT_SIZE_CHANGE,this.onTextSizeChange);
            param1.removeEventListener(BubbleAssetEvent.AUTO_TEXT_RESIZE_CHANGE,this.onAutoTextResizeChange);
         }
      }
      
      private function onTextColorChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.changeTextColor(param1.asset as IBubbleText);
         }
      }
      
      private function onTextFontChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.changeTextFont(param1.asset as IBubbleText);
         }
      }
      
      private function onTextAlignChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.changeTextAlign(param1.asset as IBubbleText);
         }
      }
      
      private function onTextBoldChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.changeTextBold(param1.asset as IBubbleText);
         }
      }
      
      private function onTextStyleChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.updateTextStyle(param1.asset as IBubbleText);
         }
      }
      
      private function onTextSizeChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.updateTextSize(param1.asset as IBubbleText);
         }
      }
      
      private function onAutoTextResizeChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.updateAutoTextResize(param1.asset as IBubbleText);
         }
      }
      
      private function onTextEmbedChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.changeTextEmbed(param1.asset as IBubbleText);
         }
      }
      
      private function onTextChange(param1:BubbleAssetEvent) : void
      {
         if(param1.asset is IBubbleText)
         {
            this.changeText(param1.asset as IBubbleText);
         }
      }
      
      private function changeText(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).text = param1.text;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function changeTextColor(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textColor = param1.textColor;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function changeTextFont(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textFont = param1.textFont;
            this.dispatchEvent(new AssetViewEvent(AssetViewEvent.VIEW_CHANGE,true));
         }
      }
      
      private function changeTextAlign(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textAlign = param1.textAlign;
         }
      }
      
      private function changeTextBold(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textBold = param1.textBold;
         }
      }
      
      private function updateTextStyle(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textItalic = param1.textItalic;
         }
      }
      
      private function updateTextSize(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textSize = param1.textSize;
         }
      }
      
      private function updateAutoTextResize(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).autoTextResize = param1.autoTextResize;
         }
      }
      
      private function changeTextEmbed(param1:IBubbleText) : void
      {
         if(super.assetImage is IBubbleText)
         {
            IBubbleText(super.assetImage).textEmbed = param1.textEmbed;
         }
      }
   }
}
