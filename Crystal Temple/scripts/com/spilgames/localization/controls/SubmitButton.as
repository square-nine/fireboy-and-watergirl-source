package com.spilgames.localization.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class SubmitButton extends Sprite
   {
      
      private static const TEXT_COLOR_UP:uint = 0;
      
      private static const TEXT_COLOR_OVER:uint = 0;
      
      private static const LINE_COLOR:uint = 7894895;
      
      private static const BACKGROUND_COLOR_UP:uint = 13626845;
      
      private static const BACKGROUND_COLOR_OVER:uint = 14609885;
      
      private static const BACKGROUND_COLOR_DOWN:uint = 16771241;
      
      private static const WIDTH:int = 100;
      
      private static const HEIGHT:int = 20;
      
      private static const PADDING_LEFT:int = 5;
      
      private static const PADDING_RIGHT:int = 5;
       
      
      private var _labelField:TextField;
      
      private var _label:String;
      
      private var _backgroundColor:uint;
      
      private var _textColor:uint;
      
      public function SubmitButton()
      {
         super();
         buttonMode = true;
         tabEnabled = false;
         this._backgroundColor = BACKGROUND_COLOR_UP;
         this._textColor = TEXT_COLOR_UP;
         this.draw();
         this.invalidate();
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         this._labelField.text = this._label;
         this.invalidate();
      }
      
      private function draw() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Arial";
         _loc1_.size = 10;
         _loc1_.color = TEXT_COLOR_UP;
         this._labelField = new TextField();
         this._labelField.mouseEnabled = false;
         this._labelField.selectable = false;
         this._labelField.border = false;
         this._labelField.borderColor = 14687052;
         this._labelField.autoSize = TextFieldAutoSize.LEFT;
         this._labelField.defaultTextFormat = _loc1_;
         addChild(this._labelField);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseUp,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
      }
      
      private function invalidate() : void
      {
         var _loc1_:int = WIDTH + PADDING_LEFT + PADDING_RIGHT;
         if(this._label)
         {
            _loc1_ = this._labelField.width + PADDING_LEFT + PADDING_RIGHT;
            this._labelField.textColor = this._textColor;
         }
         graphics.clear();
         graphics.lineStyle(0.5,LINE_COLOR,1,true);
         graphics.beginFill(this._backgroundColor);
         graphics.drawRect(0,0,_loc1_,HEIGHT);
         graphics.endFill();
         this._labelField.x = _loc1_ / 2 - this._labelField.width / 2;
         this._labelField.y = HEIGHT / 2 - this._labelField.height / 2;
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         this._backgroundColor = BACKGROUND_COLOR_OVER;
         this._textColor = TEXT_COLOR_OVER;
         this.invalidate();
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         this._backgroundColor = BACKGROUND_COLOR_UP;
         this._textColor = TEXT_COLOR_UP;
         this.invalidate();
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this._backgroundColor = BACKGROUND_COLOR_DOWN;
         this._textColor = TEXT_COLOR_OVER;
         this.invalidate();
      }
   }
}
