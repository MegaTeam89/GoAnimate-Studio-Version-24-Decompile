package
{
   import flash.net.getClassByAlias;
   import flash.net.registerClassAlias;
   import flash.system.Capabilities;
   import mx.accessibility.AccordionHeaderAccImpl;
   import mx.accessibility.AlertAccImpl;
   import mx.accessibility.ButtonAccImpl;
   import mx.accessibility.CheckBoxAccImpl;
   import mx.accessibility.ColorPickerAccImpl;
   import mx.accessibility.ComboBaseAccImpl;
   import mx.accessibility.ComboBoxAccImpl;
   import mx.accessibility.LabelAccImpl;
   import mx.accessibility.LinkButtonAccImpl;
   import mx.accessibility.ListAccImpl;
   import mx.accessibility.ListBaseAccImpl;
   import mx.accessibility.MenuAccImpl;
   import mx.accessibility.MenuBarAccImpl;
   import mx.accessibility.PanelAccImpl;
   import mx.accessibility.RadioButtonAccImpl;
   import mx.accessibility.SliderAccImpl;
   import mx.accessibility.TabBarAccImpl;
   import mx.accessibility.TitleWindowAccImpl;
   import mx.accessibility.UIComponentAccProps;
   import mx.collections.ArrayCollection;
   import mx.collections.ArrayList;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import mx.effects.EffectManager;
   import mx.managers.systemClasses.ChildManager;
   import mx.styles.IStyleManager2;
   import mx.styles.StyleManagerImpl;
   import mx.utils.ObjectProxy;
   
   public class _go_full_FlexInit
   {
       
      
      public function _go_full_FlexInit()
      {
         super();
      }
      
      public static function init(param1:IFlexModuleFactory) : void
      {
         var styleManager:IStyleManager2 = null;
         var fbs:IFlexModuleFactory = param1;
         new ChildManager(fbs);
         styleManager = StyleManagerImpl.getInstance();
         fbs.registerImplementation("mx.styles::IStyleManager2",styleManager);
         styleManager.qualifiedTypeSelectors = false;
         EffectManager.mx_internal::registerEffectTrigger("addedEffect","added");
         EffectManager.mx_internal::registerEffectTrigger("completeEffect","complete");
         EffectManager.mx_internal::registerEffectTrigger("creationCompleteEffect","creationComplete");
         EffectManager.mx_internal::registerEffectTrigger("focusInEffect","focusIn");
         EffectManager.mx_internal::registerEffectTrigger("focusOutEffect","focusOut");
         EffectManager.mx_internal::registerEffectTrigger("hideEffect","hide");
         EffectManager.mx_internal::registerEffectTrigger("itemsChangeEffect","itemsChange");
         EffectManager.mx_internal::registerEffectTrigger("mouseDownEffect","mouseDown");
         EffectManager.mx_internal::registerEffectTrigger("mouseUpEffect","mouseUp");
         EffectManager.mx_internal::registerEffectTrigger("moveEffect","move");
         EffectManager.mx_internal::registerEffectTrigger("removedEffect","removed");
         EffectManager.mx_internal::registerEffectTrigger("resizeEffect","resize");
         EffectManager.mx_internal::registerEffectTrigger("resizeEndEffect","resizeEnd");
         EffectManager.mx_internal::registerEffectTrigger("resizeStartEffect","resizeStart");
         EffectManager.mx_internal::registerEffectTrigger("rollOutEffect","rollOut");
         EffectManager.mx_internal::registerEffectTrigger("rollOverEffect","rollOver");
         EffectManager.mx_internal::registerEffectTrigger("showEffect","show");
         if(Capabilities.hasAccessibility)
         {
            ColorPickerAccImpl.enableAccessibility();
            ComboBoxAccImpl.enableAccessibility();
            PanelAccImpl.enableAccessibility();
            TabBarAccImpl.enableAccessibility();
            ListBaseAccImpl.enableAccessibility();
            AccordionHeaderAccImpl.enableAccessibility();
            TitleWindowAccImpl.enableAccessibility();
            ListAccImpl.enableAccessibility();
            AlertAccImpl.enableAccessibility();
            MenuAccImpl.enableAccessibility();
            LabelAccImpl.enableAccessibility();
            RadioButtonAccImpl.enableAccessibility();
            LinkButtonAccImpl.enableAccessibility();
            SliderAccImpl.enableAccessibility();
            CheckBoxAccImpl.enableAccessibility();
            MenuBarAccImpl.enableAccessibility();
            ButtonAccImpl.enableAccessibility();
            ComboBaseAccImpl.enableAccessibility();
            UIComponentAccProps.enableAccessibility();
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayCollection") != ArrayCollection)
            {
               registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayCollection",ArrayCollection);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ArrayList") != ArrayList)
            {
               registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ArrayList",ArrayList);
         }
         try
         {
            if(getClassByAlias("flex.messaging.io.ObjectProxy") != ObjectProxy)
            {
               registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
            }
         }
         catch(e:Error)
         {
            registerClassAlias("flex.messaging.io.ObjectProxy",ObjectProxy);
         }
         var styleNames:Array = ["highlightColor","kerning","iconColor","showErrorSkin","textRollOverColor","shadowCapColor","gradientPosition","gradientColors","textDecoration","showErrorTip","fontThickness","selectionDisabledColor","letterSpacing","chromeColor","rollOverColor","fontSize","shadowColor","strokeColor","indicatorGap","fontWeight","leading","symbolColor","fontSharpness","barColor","modalTransparencyDuration","layoutDirection","footerColors","contentBackgroundColor","contentBackgroundAlpha","fontAntiAliasType","direction","errorColor","locale","backgroundDisabledColor","modalTransparencyColor","textIndent","themeColor","gradientAlphas","modalTransparency","textAlign","headerColors","fontFamily","textSelectedColor","strokeWidth","interactionMode","labelWidth","fontGridFitType","fontStyle","dropShadowColor","accentColor","disabledColor","selectionColor","dropdownBorderColor","disabledIconColor","modalTransparencyBlur","focusColor","color","alternatingItemColors"];
         var i:int = 0;
         while(i < styleNames.length)
         {
            styleManager.registerInheritingStyle(styleNames[i]);
            i++;
         }
      }
   }
}
