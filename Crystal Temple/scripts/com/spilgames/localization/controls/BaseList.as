package com.spilgames.localization.controls
{
   import com.spilgames.localization.events.SelectionEvent;
   import flash.display.Sprite;
   
   public class BaseList extends Sprite
   {
      
      public static const PADDING_LEFT:int = 5;
      
      public static const PADDING_RIGHT:int = 5;
      
      public static const PADDING_TOP:int = 5;
      
      public static const PADDING_BOTTOM:int = 5;
      
      public static const VERTICAL_GAP:int = 5;
      
      public static const BACKGROUND_COLOR:uint = 16777215;
       
      
      private var _backgroundWidth:int;
      
      private var _backgroundHeight:int;
      
      private var _selectors:Array;
      
      private var _selectedItem:BaseSelector;
      
      private var _selectedIndex:int;
      
      public function BaseList()
      {
         super();
         this._backgroundWidth = 100;
         this._backgroundHeight = 100;
         this._selectors = [];
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
      
      public function get selectedItem() : BaseSelector
      {
         return this._selectedItem;
      }
      
      public function set selectedItem(param1:BaseSelector) : void
      {
         this._selectedItem = param1;
      }
      
      public function get selectedIndex() : int
      {
         return this._selectedIndex;
      }
      
      public function set selectedIndex(param1:int) : void
      {
         this._selectedIndex = param1;
         if(Boolean(this._selectedIndex) && Boolean(this._selectors[this._selectedIndex]))
         {
            if(this._selectedItem)
            {
               this._selectedItem.deselect();
            }
            this._selectedItem = this._selectors[this._selectedIndex];
            this._selectedItem.select();
         }
      }
      
      public function get selectors() : Array
      {
         return this._selectors;
      }
      
      public function set selectors(param1:Array) : void
      {
         this._selectors = param1;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this._backgroundWidth = param1;
         this._backgroundHeight = param2;
         this.invalidate();
      }
      
      protected function draw() : void
      {
      }
      
      protected function invalidate() : void
      {
         var _loc1_:BaseSelector = null;
         graphics.clear();
         graphics.beginFill(BACKGROUND_COLOR);
         graphics.drawRect(0,0,this._backgroundWidth,this._backgroundHeight);
         graphics.endFill();
         for each(_loc1_ in this.selectors)
         {
            _loc1_.backgroundWidth = this.backgroundWidth;
         }
      }
      
      protected function onSelect(param1:SelectionEvent) : void
      {
         var _loc2_:BaseSelector = null;
         if(this.selectedItem)
         {
            this.selectedItem.deselect();
         }
         this.selectedItem = BaseSelector(param1.currentTarget);
         this.selectedItem.select();
         var _loc3_:int = 0;
         while(_loc3_ < this.selectors.length)
         {
            _loc2_ = this.selectors[_loc3_];
            if(_loc2_ == this.selectedItem)
            {
               this.selectedIndex = _loc3_;
               break;
            }
            _loc3_++;
         }
      }
   }
}
