package com.spilgames.localization.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class BaseSelector extends Sprite
   {
      
      private static const PADDING_LEFT:int = 5;
      
      private static const PADDING_TOP:int = 5;
      
      private static const BACKGROUND_ALPHA:Number = 1;
      
      private static const BACKGROUND_COLOR_UP:uint = 13626845;
      
      private static const BACKGROUND_COLOR_OVER:uint = 14609885;
      
      private static const BACKGROUND_COLOR_DOWN:uint = 16771241;
      
      private static const TEXT_COLOR:uint = 4080183;
       
      
      private var _name_txt:TextField;
      
      private var _backgroundWidth:int;
      
      private var _backgroundHeight:int;
      
      private var _backgroundColor:uint;
      
      private var _selected:Boolean;
      
      private var _label:String;
      
      public function BaseSelector()
      {
         super();
         buttonMode = true;
         tabEnabled = false;
         this._selected = false;
         this._backgroundColor = BACKGROUND_COLOR_UP;
         this.draw();
         this.invalidate();
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseUp,false,0,true);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown,false,0,true);
      }
      
      public function get backgroundWidth() : int
      {
         return this._backgroundWidth;
      }
      
      public function set backgroundWidth(param1:int) : void
      {
         this._backgroundWidth = param1 - PADDING_LEFT * 2;
         this.invalidate();
      }
      
      public function get backgroundHeight() : int
      {
         return this._backgroundHeight;
      }
      
      public function set backgroundHeight(param1:int) : void
      {
         this._backgroundHeight = param1 - PADDING_TOP;
         this.invalidate();
      }
      
      public function get label() : String
      {
         return this._label;
      }
      
      public function set label(param1:String) : void
      {
         this._label = param1;
         this.draw();
         this.invalidate();
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._backgroundWidth = param1;
         this._backgroundHeight = param2;
         this.invalidate();
      }
      
      public function select() : void
      {
         this._backgroundColor = BACKGROUND_COLOR_DOWN;
         this._selected = true;
         mouseEnabled = false;
         this.invalidate();
      }
      
      public function deselect() : void
      {
         this._backgroundColor = BACKGROUND_COLOR_UP;
         this._selected = false;
         mouseEnabled = true;
         this.invalidate();
      }
      
      private function draw() : void
      {
         if(Boolean(this._name_txt) && contains(this._name_txt))
         {
            removeChild(this._name_txt);
         }
         this._name_txt = new TextField();
         this._name_txt.autoSize = TextFieldAutoSize.LEFT;
         this._name_txt.mouseEnabled = false;
         this._name_txt.selectable = false;
         this._name_txt.x = 2;
         this._name_txt.y = 0;
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "Arial";
         _loc1_.color = TEXT_COLOR;
         _loc1_.size = 12;
         this._name_txt.defaultTextFormat = _loc1_;
         this._name_txt.text = this.label;
         addChild(this._name_txt);
         this._backgroundWidth = this._name_txt.textWidth + PADDING_LEFT;
         this._backgroundHeight = this._name_txt.textHeight + 5;
      }
      
      private function invalidate() : void
      {
         graphics.clear();
         graphics.beginFill(this._backgroundColor,BACKGROUND_ALPHA);
         graphics.drawRect(0,0,this._backgroundWidth,this._backgroundHeight);
         graphics.endFill();
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(!this._selected)
         {
            this._backgroundColor = BACKGROUND_COLOR_OVER;
            this.invalidate();
         }
      }
      
      protected function onMouseUp(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(!this._selected)
         {
            this._backgroundColor = BACKGROUND_COLOR_UP;
         }
         else
         {
            this._backgroundColor = BACKGROUND_COLOR_DOWN;
         }
         this.invalidate();
      }
      
      protected function onMouseDown(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(!this._selected)
         {
            mouseEnabled = false;
            this._backgroundColor = BACKGROUND_COLOR_DOWN;
            this.invalidate();
         }
      }
   }
}
