package com.spilgames.localization.controls.font
{
   import com.spilgames.localization.controls.BaseList;
   import com.spilgames.localization.events.SelectionEvent;
   import flash.text.Font;
   
   public class FontList extends BaseList
   {
       
      
      private var _embeddedFonts:Array;
      
      public function FontList()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:FontSelector = null;
         var _loc3_:Font = null;
         this._embeddedFonts = Font.enumerateFonts(false);
         this._embeddedFonts.sortOn("fontName",Array.CASEINSENSITIVE);
         var _loc2_:int = 0;
         while(_loc2_ < this._embeddedFonts.length)
         {
            _loc3_ = Font(this._embeddedFonts[_loc2_]);
            _loc1_ = new FontSelector(_loc3_);
            _loc1_.x = BaseList.PADDING_LEFT;
            _loc1_.y = BaseList.PADDING_TOP + _loc2_ * (_loc1_.height + BaseList.VERTICAL_GAP);
            _loc1_.backgroundWidth = backgroundWidth;
            _loc1_.addEventListener(SelectionEvent.SELECT,onSelect,false,0,true);
            addChild(_loc1_);
            selectors.push(_loc1_);
            _loc2_++;
         }
         if(this._embeddedFonts.length > 0)
         {
            if(selectedItem)
            {
               selectedItem.deselect();
            }
            selectedItem = FontSelector(selectors[0]);
            selectedItem.select();
            selectedIndex = 0;
         }
      }
   }
}
