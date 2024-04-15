package com.spilgames.localization.controls.font
{
   import com.spilgames.localization.controls.BaseSelector;
   import com.spilgames.localization.events.SelectionEvent;
   import flash.events.MouseEvent;
   import flash.text.Font;
   
   public class FontSelector extends BaseSelector
   {
       
      
      private var _font:Font;
      
      public function FontSelector(param1:Font = null)
      {
         this._font = param1;
         label = this._font.fontName + " (" + this._font.fontStyle + ")";
         super();
      }
      
      public function get font() : Font
      {
         return this._font;
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
