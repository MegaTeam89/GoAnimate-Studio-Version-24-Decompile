package flexlib.controls
{
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.core.EdgeMetrics;
   import mx.core.IContainer;
   import mx.core.IFlexDisplayObject;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   
   public class CanvasButton extends Button implements IContainer
   {
       
      
      private var canvas:Canvas;
      
      private var _childrenCreated:Boolean = false;
      
      private var _childDescriptors:Array;
      
      private var _horizontalScrollPolicy:String = "auto";
      
      private var _verticalScrollPolicy:String = "auto";
      
      protected var _creatingContentPane:Boolean;
      
      protected var _defaultButton:IFlexDisplayObject;
      
      protected var _horizontalScrollPosition:Number;
      
      protected var _verticalScrollPosition:Number;
      
      protected var _viewMetrics:EdgeMetrics;
      
      public function CanvasButton()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         this.canvas = new Canvas();
         this.canvas.verticalScrollPolicy = this._verticalScrollPolicy;
         this.canvas.horizontalScrollPolicy = this._horizontalScrollPolicy;
         this.canvas.mouseChildren = super.mouseChildren;
         this.canvas.buttonMode = super.buttonMode;
         super.addChild(this.canvas);
         this.canvas.initializeRepeaterArrays(this);
         this.createComponents();
         this._childrenCreated = true;
      }
      
      override protected function updateDisplayList(param1:Number, param2:Number) : void
      {
         super.updateDisplayList(param1,param2);
         this.canvas.setActualSize(param1,param2);
      }
      
      override protected function measure() : void
      {
         super.measure();
         measuredHeight = this.canvas.getExplicitOrMeasuredHeight();
         measuredWidth = this.canvas.getExplicitOrMeasuredWidth();
      }
      
      override mx_internal function layoutContents(param1:Number, param2:Number, param3:Boolean) : void
      {
         super.layoutContents(param1,param2,param3);
         setChildIndex(this.canvas,numChildren - 1);
      }
      
      public function set childDescriptors(param1:Array) : void
      {
         this._childDescriptors = param1;
      }
      
      mx_internal function setDocumentDescriptor(param1:UIComponentDescriptor) : void
      {
         if(mx_internal::_documentDescriptor && mx_internal::_documentDescriptor.properties.childDescriptors)
         {
            if(param1.properties.childDescriptors)
            {
               throw new Error("Multiple sets of visual children have been specified for this component (base component definition and derived component definition).");
            }
         }
         else
         {
            _documentDescriptor = param1;
            mx_internal::_documentDescriptor.document = this;
         }
         if(param1.properties.childDescriptors)
         {
            this.childDescriptors = param1.properties.childDescriptors;
         }
      }
      
      private function createComponents() : void
      {
         var _loc1_:UIComponentDescriptor = null;
         for each(_loc1_ in this._childDescriptors)
         {
            this.canvas.createComponentFromDescriptor(_loc1_,true);
         }
      }
      
      public function get horizontalScrollPolicy() : String
      {
         return this._horizontalScrollPolicy;
      }
      
      public function set horizontalScrollPolicy(param1:String) : void
      {
         this._horizontalScrollPolicy = param1;
         if(this.canvas)
         {
            this.canvas.horizontalScrollPolicy = param1;
         }
      }
      
      public function get verticalScrollPolicy() : String
      {
         return this._verticalScrollPolicy;
      }
      
      public function set verticalScrollPolicy(param1:String) : void
      {
         this._verticalScrollPolicy = param1;
         if(this.canvas)
         {
            this.canvas.verticalScrollPolicy = param1;
         }
      }
      
      override public function get buttonMode() : Boolean
      {
         return super.buttonMode;
      }
      
      override public function set buttonMode(param1:Boolean) : void
      {
         super.buttonMode = param1;
         if(this.canvas)
         {
            this.canvas.buttonMode = param1;
         }
      }
      
      override public function get mouseChildren() : Boolean
      {
         return super.mouseChildren;
      }
      
      override public function set mouseChildren(param1:Boolean) : void
      {
         super.mouseChildren = param1;
         if(this.canvas)
         {
            this.canvas.mouseChildren = param1;
         }
      }
      
      public function get creatingContentPane() : Boolean
      {
         return this._creatingContentPane;
      }
      
      public function set creatingContentPane(param1:Boolean) : void
      {
         this._creatingContentPane = param1;
      }
      
      public function get defaultButton() : IFlexDisplayObject
      {
         return this._defaultButton;
      }
      
      public function set defaultButton(param1:IFlexDisplayObject) : void
      {
         this._defaultButton = param1;
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._horizontalScrollPosition;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         this._horizontalScrollPosition = param1;
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         this._verticalScrollPosition = param1;
      }
      
      public function get viewMetrics() : EdgeMetrics
      {
         return this._viewMetrics;
      }
      
      public function set viewMetrics(param1:EdgeMetrics) : void
      {
         this._viewMetrics = param1;
      }
   }
}
