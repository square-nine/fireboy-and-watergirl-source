package com.miniclip.proto
{
   import com.miniclip.events.ComponentEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class ComponentBase extends MovieClip
   {
       
      
      protected var _initComplete:Boolean;
      
      protected var showing_complete:Boolean;
      
      private var isDisplayed:Boolean;
      
      private var showAtInit:Boolean;
      
      private var complete:Boolean;
      
      private var _expectedWidth:int;
      
      private var _expectedHeight:int;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _rotation:Number;
      
      public function ComponentBase(param1:Boolean = true, param2:int = -1, param3:int = -1)
      {
         super();
         this._initComplete = false;
         this.isDisplayed = false;
         this.visible = false;
         this.showAtInit = param1;
         this._expectedWidth = param2;
         this._expectedHeight = param3;
         this.showing_complete = param1;
         gotoAndStop(1);
         if(stage)
         {
            this.startChecking();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         }
         addEventListener(Event.ADDED_TO_STAGE,this.on_displayed);
      }
      
      public function show() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function get initComplete() : Boolean
      {
         return this._initComplete;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set width(param1:Number) : void
      {
      }
      
      override public function set height(param1:Number) : void
      {
      }
      
      protected function INITIALIZE() : void
      {
         this.visible = this.showAtInit;
         dispatchEvent(new ComponentEvent(ComponentEvent.ON_INIT_COMPLETE));
      }
      
      protected function preInit() : void
      {
         this.reset();
         this.clearDisplayList();
         super.visible = this.showAtInit;
      }
      
      private function _onExitFrame(param1:Event) : void
      {
         if(this.complete)
         {
            this.initializeComplete();
            return;
         }
         if(this.framesLoaded > 0 && this.framesLoaded == this.totalFrames)
         {
            this.preInit();
            this.complete = true;
         }
      }
      
      private function initializeComplete() : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this._onExitFrame);
         this._initComplete = true;
         this.INITIALIZE();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.complete = false;
         this.startChecking();
      }
      
      private function startChecking() : void
      {
         addEventListener(Event.ENTER_FRAME,this._onExitFrame);
         addEventListener(Event.ENTER_FRAME,this._checkVisibility);
      }
      
      private function _checkVisibility(param1:Event) : void
      {
         this.on_displayed();
      }
      
      private function clearDisplayList() : void
      {
         while(this.numChildren > 0)
         {
            this.removeChildAt(this.numChildren - 1);
         }
      }
      
      private function reset() : void
      {
         this._width = this._expectedWidth > 0 ? this._expectedWidth : super.width;
         this._height = this._expectedHeight > 0 ? this._expectedHeight : super.height;
         this._rotation = super.rotation;
         this.rotation = 0;
         this.alpha = 1;
         this.scaleY = 1;
         this.scaleX = 1;
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible == false && param1 == true)
         {
            this.on_displayed();
         }
         super.visible = param1;
      }
      
      override public function get alpha() : Number
      {
         return super.alpha;
      }
      
      override public function set alpha(param1:Number) : void
      {
         if(super.alpha == 0 && param1 > 0)
         {
            this.on_displayed();
         }
         super.alpha = param1;
      }
      
      protected function on_displayed(param1:Event = null) : void
      {
         if(this._initComplete == true && this.stage && this.visible == true && this.alpha > 0)
         {
            if(this.isDisplayed == false)
            {
               trace(" dispatching ComponentEvent.ON_SHOWING ");
               this.isDisplayed = true;
               dispatchEvent(new ComponentEvent(ComponentEvent.ON_SHOWING));
            }
         }
         else
         {
            this.isDisplayed = false;
         }
      }
   }
}
