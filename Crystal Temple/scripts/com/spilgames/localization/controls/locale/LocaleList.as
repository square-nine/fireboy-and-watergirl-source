package com.spilgames.localization.controls.locale
{
   import com.spilgames.localization.controls.BaseList;
   import com.spilgames.localization.events.SelectionEvent;
   
   public class LocaleList extends BaseList
   {
       
      
      private var _data:XML;
      
      public function LocaleList(param1:XML)
      {
         this._data = param1;
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:LocaleStringSelector = null;
         var _loc2_:XML = null;
         for each(_loc2_ in this._data.item)
         {
            _loc1_ = new LocaleStringSelector(_loc2_);
            _loc1_.x = BaseList.PADDING_LEFT;
            _loc1_.y = BaseList.PADDING_TOP + selectors.length * (_loc1_.height + BaseList.VERTICAL_GAP);
            _loc1_.backgroundWidth = backgroundWidth;
            _loc1_.addEventListener(SelectionEvent.SELECT,onSelect,false,0,true);
            addChild(_loc1_);
            selectors.push(_loc1_);
         }
         if(selectors.length > 0)
         {
            if(selectedItem)
            {
               selectedItem.deselect();
            }
            selectedItem = LocaleStringSelector(selectors[0]);
            selectedItem.select();
            selectedIndex = 0;
         }
      }
   }
}
