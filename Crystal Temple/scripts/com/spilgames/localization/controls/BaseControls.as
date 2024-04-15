package com.spilgames.localization.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class BaseControls extends Sprite
   {
      
      public static const PADDING_LEFT:int = 5;
      
      public static const PADDING_TOP:int = 5;
      
      public static const VERTICAL_GAP:int = 15;
      
      public static const HORIZONTAL_GAP:int = 10;
      
      public static const BACKGROUND_COLOR:uint = 16777215;
      
      public static const LINE_COLOR:uint = 4080183;
      
      public static const TEXT_COLOR:uint = 4407863;
      
      public static const BORDER_COLOR:uint = 7894895;
       
      
      private var _backgroundWidth:int;
      
      private var _backgroundHeight:int;
      
      public function BaseControls()
      {
         super();
         this._backgroundWidth = 100;
         this._backgroundHeight = 100;
         this.draw();
         this.invalidate();
      }
      
      public function get backgroundWidth() : int
      {
         return this._backgroundWidth;
      }
      
      public function set backgroundWidth(param1:int) : void
      {
         this._backgroundWidth = param1;
         this.invalidate();
      }
      
      public function get backgroundHeight() : int
      {
         return this._backgroundHeight;
      }
      
      public function set backgroundHeight(param1:int) : void
      {
         this._backgroundHeight = param1;
         this.invalidate();
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._backgroundWidth = param1;
         this._backgroundHeight = param2;
      }
      
      protected function draw() : void
      {
      }
      
      protected function invalidate() : void
      {
         graphics.clear();
         graphics.beginFill(BACKGROUND_COLOR);
         graphics.drawRect(0,0,this._backgroundWidth,this._backgroundHeight);
         graphics.endFill();
      }
      
      protected function createTextField(param1:Boolean = false, param2:Boolean = false, param3:int = 12, param4:uint = 0, param5:int = 0) : TextField
      {
         var _loc6_:TextField;
         (_loc6_ = new TextField()).autoSize = TextFieldAutoSize.LEFT;
         _loc6_.wordWrap = param1;
         _loc6_.multiline = param2;
         _loc6_.selectable = false;
         _loc6_.borderColor = BORDER_COLOR;
         var _loc7_:TextFormat;
         (_loc7_ = new TextFormat("Arial",param3,param4,false)).indent = param5;
         _loc6_.defaultTextFormat = _loc7_;
         return _loc6_;
      }
   }
}
