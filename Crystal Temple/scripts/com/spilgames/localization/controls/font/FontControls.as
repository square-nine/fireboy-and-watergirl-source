package com.spilgames.localization.controls.font
{
   import com.spilgames.localization.controls.BaseControls;
   import com.spilgames.localization.controls.SubmitButton;
   import flash.display.Shape;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.ui.Keyboard;
   
   public class FontControls extends BaseControls
   {
      
      private static const DEFAULT_GLYPH_TEXT:String = "Type here...";
       
      
      private var _nameField:TextField;
      
      private var _styleField:TextField;
      
      private var _typeField:TextField;
      
      private var _glyphLabel:TextField;
      
      private var _glyphValue:TextField;
      
      private var _glyphDescription:TextField;
      
      private var _glyphResult:TextField;
      
      private var _glyphOutput:TextField;
      
      private var _submitButton:SubmitButton;
      
      private var _line:Shape;
      
      private var _font:Font;
      
      public function FontControls()
      {
         super();
      }
      
      public function get font() : Font
      {
         return this._font;
      }
      
      public function set font(param1:Font) : void
      {
         this._font = param1;
         this.setLabels();
      }
      
      override public function setSize(param1:int, param2:int) : void
      {
         super.setSize(param1,param2);
         if(this._glyphDescription)
         {
            this._glyphDescription.width = backgroundWidth - BaseControls.PADDING_LEFT;
         }
         this.invalidate();
      }
      
      override protected function draw() : void
      {
         this._nameField = createTextField();
         this._nameField.x = BaseControls.PADDING_LEFT;
         this._nameField.y = BaseControls.PADDING_TOP;
         addChild(this._nameField);
         this._styleField = createTextField();
         this._styleField.x = this._nameField.x;
         this._styleField.y = this._nameField.y + this._nameField.height + BaseControls.VERTICAL_GAP;
         addChild(this._styleField);
         this._typeField = createTextField();
         this._typeField.x = this._styleField.x;
         this._typeField.y = this._styleField.y + this._styleField.height + BaseControls.VERTICAL_GAP;
         addChild(this._typeField);
         this._glyphDescription = createTextField(true,true);
         this._glyphDescription.x = this._typeField.x;
         this._glyphDescription.y = this._typeField.y + this._typeField.height + BaseControls.VERTICAL_GAP * 2;
         this._glyphDescription.border = false;
         this._glyphDescription.text = "Check whether the specified text can be displayed using the currently selected font:";
         addChild(this._glyphDescription);
         this._line = new Shape();
         addChild(this._line);
         this._glyphLabel = createTextField();
         this._glyphLabel.x = this._glyphDescription.x;
         this._glyphLabel.y = this._glyphDescription.y + this._glyphDescription.textHeight + BaseControls.HORIZONTAL_GAP;
         this._glyphLabel.htmlText = "<b>Text:</b>";
         addChild(this._glyphLabel);
         this._glyphValue = createTextField(false,false,11,BaseControls.TEXT_COLOR,2);
         this._glyphValue.addEventListener(FocusEvent.FOCUS_IN,this.onGlyphFocusIn,false,0,true);
         this._glyphValue.addEventListener(FocusEvent.FOCUS_OUT,this.onGlyphFocusOut,false,0,true);
         this._glyphValue.addEventListener(KeyboardEvent.KEY_DOWN,this.onGlyphEnterKeyDown,false,0,true);
         this._glyphValue.addEventListener(TextEvent.TEXT_INPUT,this.onGlyphInput,false,0,true);
         this._glyphValue.autoSize = TextFieldAutoSize.NONE;
         this._glyphValue.x = this._glyphLabel.x + this._glyphLabel.width + BaseControls.HORIZONTAL_GAP;
         this._glyphValue.y = this._glyphLabel.y;
         this._glyphValue.width = 200;
         this._glyphValue.height = 20;
         this._glyphValue.text = DEFAULT_GLYPH_TEXT;
         this._glyphValue.border = true;
         this._glyphValue.selectable = true;
         this._glyphValue.type = TextFieldType.INPUT;
         addChild(this._glyphValue);
         this._submitButton = new SubmitButton();
         this._submitButton.x = this._glyphValue.x + this._glyphValue.width + BaseControls.HORIZONTAL_GAP / 2;
         this._submitButton.y = this._glyphValue.y;
         this._submitButton.addEventListener(MouseEvent.CLICK,this.onSubmitGlyph,false,0,true);
         this._submitButton.label = "Submit";
         addChild(this._submitButton);
         this._glyphResult = createTextField(false,false,14);
         this._glyphResult.x = this._submitButton.x + this._submitButton.width + BaseControls.HORIZONTAL_GAP;
         this._glyphResult.y = this._submitButton.y;
         addChild(this._glyphResult);
         this._glyphOutput = createTextField(false,false);
         this._glyphOutput.border = false;
         this._glyphOutput.autoSize = TextFieldAutoSize.NONE;
         this._glyphOutput.width = 200;
         this._glyphOutput.height = 20;
         this._glyphOutput.x = this._glyphValue.x;
         this._glyphOutput.y = this._glyphValue.y + this._glyphValue.textHeight + BaseControls.VERTICAL_GAP;
         addChild(this._glyphOutput);
      }
      
      override protected function invalidate() : void
      {
         super.invalidate();
         this._line.x = this._styleField.x + 3;
         this._line.y = 70;
         this._line.graphics.clear();
         this._line.graphics.beginFill(BaseControls.LINE_COLOR);
         this._line.graphics.drawRect(0,0,backgroundWidth - (this._line.x + BaseControls.PADDING_LEFT * 2),1);
         this._line.graphics.endFill();
         this._glyphLabel.y = this._glyphDescription.y + this._glyphDescription.textHeight + 10;
         this._glyphValue.y = this._submitButton.y = this._glyphResult.y = this._glyphLabel.y;
         this._glyphOutput.y = this._glyphValue.y + this._glyphValue.textHeight + 10;
      }
      
      private function setLabels() : void
      {
         this._nameField.htmlText = "Name:   <b>" + this._font.fontName + "</b>";
         this._styleField.htmlText = "Style:     <b>" + this._font.fontStyle + "</b>";
         this._typeField.htmlText = "Type:     <b>" + this._font.fontType + "</b>";
         this._glyphResult.htmlText = this._glyphOutput.text = "";
         this._glyphValue.text = DEFAULT_GLYPH_TEXT;
      }
      
      private function submit() : void
      {
         var _loc1_:String = this._glyphValue.text;
         var _loc2_:* = "<b><font color=\'#";
         if(_loc1_.length > 0 && _loc1_ != DEFAULT_GLYPH_TEXT)
         {
            if(this._font.hasGlyphs(_loc1_))
            {
               _loc2_ += "0FB000\'>YES";
            }
            else
            {
               _loc2_ += "DE0037\'>NO";
            }
            this._glyphResult.htmlText = _loc2_ + "</font></b>";
         }
      }
      
      private function onSubmitGlyph(param1:MouseEvent) : void
      {
         this.submit();
      }
      
      private function onGlyphFocusIn(param1:FocusEvent) : void
      {
         if(this._glyphValue.text == DEFAULT_GLYPH_TEXT)
         {
            this._glyphValue.text = "";
         }
      }
      
      private function onGlyphFocusOut(param1:FocusEvent) : void
      {
         if(this._glyphValue.text == "")
         {
            this._glyphValue.text = DEFAULT_GLYPH_TEXT;
            this._glyphResult.htmlText = "";
         }
      }
      
      private function onGlyphEnterKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.submit();
         }
      }
      
      private function onGlyphInput(param1:TextEvent) : void
      {
         this._glyphResult.htmlText = "";
      }
   }
}
