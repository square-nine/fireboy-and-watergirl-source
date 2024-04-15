package com.spilgames.localization.controls.locale
{
   import com.spilgames.localization.controls.BaseSelector;
   import com.spilgames.localization.events.SelectionEvent;
   import flash.events.MouseEvent;
   
   public class LocaleStringSelector extends BaseSelector
   {
       
      
      private var _data:XML;
      
      public function LocaleStringSelector(param1:XML)
      {
         this._data = param1;
         label = param1.@id;
         super();
      }
      
      public function get data() : XML
      {
         return this._data;
      }
      
      override protected function onMouseDown(param1:MouseEvent) : void
      {
         var _loc2_:SelectionEvent = null;
         super.onMouseDown(param1);
         if(!selected)
         {
            _loc2_ = new SelectionEvent(SelectionEvent.SELECT);
            dispatchEvent(_loc2_);
         }
      }
   }
}
