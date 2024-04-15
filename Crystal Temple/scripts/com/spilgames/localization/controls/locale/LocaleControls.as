package com.spilgames.localization.controls.locale
{
   import com.spilgames.localization.controls.BaseControls;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class LocaleControls extends BaseControls
   {
       
      
      private var _data:XML;
      
      private var _contentField:TextField;
      
      public function LocaleControls()
      {
         super();
      }
      
      public function get data() : XML
      {
         return this._data;
      }
      
      public function set data(param1:XML) : void
      {
         this._data = param1;
         this.setContent();
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         super.setSize(param1,param2);
         this.invalidate();
      }
      
      override protected function draw() : void
      {
         this._contentField = createTextField(true,true);
         this._contentField.x = BaseControls.PADDING_LEFT;
         this._contentField.y = BaseControls.PADDING_TOP;
         this._contentField.border = false;
         this._contentField.selectable = true;
         this._contentField.text = "";
         this._contentField.autoSize = TextFieldAutoSize.NONE;
         this._contentField.width = backgroundWidth;
         this._contentField.height = backgroundHeight;
         addChild(this._contentField);
      }
      
      override protected function invalidate() : void
      {
         super.invalidate();
         this._contentField.width = backgroundWidth;
         this._contentField.height = backgroundHeight;
      }
      
      private function setContent() : void
      {
         var _loc2_:XML = null;
         var _loc1_:String = "";
         for each(_loc2_ in this._data.children())
         {
            _loc1_ += "<b>" + _loc2_.name().localName + "</b>[" + (_loc2_.@fontName || "") + "]: " + _loc2_.text() + "\n";
         }
         this._contentField.htmlText = _loc1_;
      }
   }
}
