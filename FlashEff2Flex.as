package
{
   import com.jumpeye.flashEff2.buttonEffect.FEBColorMatrixFilterPlugin;
   import com.jumpeye.flashEff2.buttonEffect.FEBCustomTintPlugin;
   import com.jumpeye.flashEff2.buttonEffect.FEBFilterPlugins;
   import com.jumpeye.flashEff2.presets.JFESP1;
   import com.jumpeye.flashEff2.presets.JFESP10;
   import com.jumpeye.flashEff2.presets.JFESP11;
   import com.jumpeye.flashEff2.presets.JFESP12;
   import com.jumpeye.flashEff2.presets.JFESP13;
   import com.jumpeye.flashEff2.presets.JFESP14;
   import com.jumpeye.flashEff2.presets.JFESP15;
   import com.jumpeye.flashEff2.presets.JFESP16;
   import com.jumpeye.flashEff2.presets.JFESP17;
   import com.jumpeye.flashEff2.presets.JFESP18;
   import com.jumpeye.flashEff2.presets.JFESP19;
   import com.jumpeye.flashEff2.presets.JFESP2;
   import com.jumpeye.flashEff2.presets.JFESP20;
   import com.jumpeye.flashEff2.presets.JFESP3;
   import com.jumpeye.flashEff2.presets.JFESP4;
   import com.jumpeye.flashEff2.presets.JFESP5;
   import com.jumpeye.flashEff2.presets.JFESP6;
   import com.jumpeye.flashEff2.presets.JFESP7;
   import com.jumpeye.flashEff2.presets.JFESP8;
   import com.jumpeye.flashEff2.presets.JFESP9;
   import com.jumpeye.flashEff2.presets.JFESPM2;
   import com.jumpeye.flashEff2.presets.JFESPM3;
   import com.jumpeye.flashEff2.presets.JFESPM4;
   import com.jumpeye.flashEff2.presets.JFESPM5;
   import com.jumpeye.flashEff2.presets.JFESPM6;
   import com.jumpeye.flashEff2.presets.JFESPM7;
   import com.jumpeye.flashEff2.presets.JFESPM8;
   import com.jumpeye.flashEff2.presets.JFETP10;
   import com.jumpeye.flashEff2.presets.JFETP11;
   import com.jumpeye.flashEff2.presets.JFETP12;
   import com.jumpeye.flashEff2.presets.JFETP13;
   import com.jumpeye.flashEff2.presets.JFETP14;
   import com.jumpeye.flashEff2.presets.JFETP15;
   import com.jumpeye.flashEff2.presets.JFETP16;
   import com.jumpeye.flashEff2.presets.JFETP17;
   import com.jumpeye.flashEff2.presets.JFETP18;
   import com.jumpeye.flashEff2.presets.JFETP19;
   import com.jumpeye.flashEff2.presets.JFETP2;
   import com.jumpeye.flashEff2.presets.JFETP20;
   import com.jumpeye.flashEff2.presets.JFETP21;
   import com.jumpeye.flashEff2.presets.JFETP22;
   import com.jumpeye.flashEff2.presets.JFETP23;
   import com.jumpeye.flashEff2.presets.JFETP24;
   import com.jumpeye.flashEff2.presets.JFETP25;
   import com.jumpeye.flashEff2.presets.JFETP26;
   import com.jumpeye.flashEff2.presets.JFETP27;
   import com.jumpeye.flashEff2.presets.JFETP28;
   import com.jumpeye.flashEff2.presets.JFETP29;
   import com.jumpeye.flashEff2.presets.JFETP3;
   import com.jumpeye.flashEff2.presets.JFETP30;
   import com.jumpeye.flashEff2.presets.JFETP3D10;
   import com.jumpeye.flashEff2.presets.JFETP3D11;
   import com.jumpeye.flashEff2.presets.JFETP3D12;
   import com.jumpeye.flashEff2.presets.JFETP3D13;
   import com.jumpeye.flashEff2.presets.JFETP3D14;
   import com.jumpeye.flashEff2.presets.JFETP3D15;
   import com.jumpeye.flashEff2.presets.JFETP3D16;
   import com.jumpeye.flashEff2.presets.JFETP3D17;
   import com.jumpeye.flashEff2.presets.JFETP3D18;
   import com.jumpeye.flashEff2.presets.JFETP3D19;
   import com.jumpeye.flashEff2.presets.JFETP3D2;
   import com.jumpeye.flashEff2.presets.JFETP3D3;
   import com.jumpeye.flashEff2.presets.JFETP3D4;
   import com.jumpeye.flashEff2.presets.JFETP3D5;
   import com.jumpeye.flashEff2.presets.JFETP3D6;
   import com.jumpeye.flashEff2.presets.JFETP3D7;
   import com.jumpeye.flashEff2.presets.JFETP3D8;
   import com.jumpeye.flashEff2.presets.JFETP3D9;
   import com.jumpeye.flashEff2.presets.JFETP4;
   import com.jumpeye.flashEff2.presets.JFETP5;
   import com.jumpeye.flashEff2.presets.JFETP6;
   import com.jumpeye.flashEff2.presets.JFETP7;
   import com.jumpeye.flashEff2.presets.JFETP8;
   import com.jumpeye.flashEff2.presets.JFETP9;
   import com.jumpeye.transitions.easing.Back;
   import com.jumpeye.transitions.easing.Bounce;
   import com.jumpeye.transitions.easing.Circular;
   import com.jumpeye.transitions.easing.Cubic;
   import com.jumpeye.transitions.easing.Elastic;
   import com.jumpeye.transitions.easing.Exponential;
   import com.jumpeye.transitions.easing.Linear;
   import com.jumpeye.transitions.easing.Quadratic;
   import com.jumpeye.transitions.easing.Quartic;
   import com.jumpeye.transitions.easing.Quintic;
   import com.jumpeye.transitions.easing.Sine;
   import com.jumpeye.transitions.easing.Strong;
   
   public class FlashEff2Flex extends FlashEff2
   {
       
      
      public function FlashEff2Flex()
      {
         super();
         this.initAssets();
      }
      
      protected function initAssets() : void
      {
         var _loc1_:JFESP1 = null;
         var _loc2_:JFESP2 = null;
         var _loc3_:JFESP3 = null;
         var _loc4_:JFESP4 = null;
         var _loc5_:JFESP5 = null;
         var _loc6_:JFESP6 = null;
         var _loc7_:JFESP7 = null;
         var _loc8_:JFESP8 = null;
         var _loc9_:JFESP9 = null;
         var _loc10_:JFESP10 = null;
         var _loc11_:JFESP11 = null;
         var _loc12_:JFESP12 = null;
         var _loc13_:JFESP13 = null;
         var _loc14_:JFESP14 = null;
         var _loc15_:JFESP15 = null;
         var _loc16_:JFESP16 = null;
         var _loc17_:JFESP17 = null;
         var _loc18_:JFESP18 = null;
         var _loc19_:JFESP19 = null;
         var _loc20_:JFESP20 = null;
         var _loc21_:JFESPM2 = null;
         var _loc22_:JFESPM3 = null;
         var _loc23_:JFESPM4 = null;
         var _loc24_:JFESPM5 = null;
         var _loc25_:JFESPM6 = null;
         var _loc26_:JFESPM7 = null;
         var _loc27_:JFESPM8 = null;
         var _loc28_:JFETP2 = null;
         var _loc29_:JFETP3 = null;
         var _loc30_:JFETP4 = null;
         var _loc31_:JFETP5 = null;
         var _loc32_:JFETP6 = null;
         var _loc33_:JFETP7 = null;
         var _loc34_:JFETP8 = null;
         var _loc35_:JFETP9 = null;
         var _loc36_:JFETP10 = null;
         var _loc37_:JFETP11 = null;
         var _loc38_:JFETP12 = null;
         var _loc39_:JFETP13 = null;
         var _loc40_:JFETP14 = null;
         var _loc41_:JFETP15 = null;
         var _loc42_:JFETP16 = null;
         var _loc43_:JFETP17 = null;
         var _loc44_:JFETP18 = null;
         var _loc45_:JFETP19 = null;
         var _loc46_:JFETP20 = null;
         var _loc47_:JFETP21 = null;
         var _loc48_:JFETP22 = null;
         var _loc49_:JFETP23 = null;
         var _loc50_:JFETP24 = null;
         var _loc51_:JFETP25 = null;
         var _loc52_:JFETP26 = null;
         var _loc53_:JFETP27 = null;
         var _loc54_:JFETP28 = null;
         var _loc55_:JFETP29 = null;
         var _loc56_:JFETP30 = null;
         var _loc57_:JFETP3D2 = null;
         var _loc58_:JFETP3D3 = null;
         var _loc59_:JFETP3D4 = null;
         var _loc60_:JFETP3D5 = null;
         var _loc61_:JFETP3D6 = null;
         var _loc62_:JFETP3D7 = null;
         var _loc63_:JFETP3D8 = null;
         var _loc64_:JFETP3D9 = null;
         var _loc65_:JFETP3D10 = null;
         var _loc66_:JFETP3D11 = null;
         var _loc67_:JFETP3D12 = null;
         var _loc68_:JFETP3D13 = null;
         var _loc69_:JFETP3D14 = null;
         var _loc70_:JFETP3D15 = null;
         var _loc71_:JFETP3D16 = null;
         var _loc72_:JFETP3D17 = null;
         var _loc73_:JFETP3D18 = null;
         var _loc74_:JFETP3D19 = null;
         var _loc75_:Back = null;
         var _loc76_:Bounce = null;
         var _loc77_:Circular = null;
         var _loc78_:Cubic = null;
         var _loc79_:Elastic = null;
         var _loc80_:Exponential = null;
         var _loc81_:Linear = null;
         var _loc82_:Quadratic = null;
         var _loc83_:Quartic = null;
         var _loc84_:Quintic = null;
         var _loc85_:Sine = null;
         var _loc86_:Strong = null;
         var _loc87_:FEBColorMatrixFilterPlugin = new FEBColorMatrixFilterPlugin();
         var _loc88_:FEBCustomTintPlugin = new FEBCustomTintPlugin();
         var _loc89_:FEBFilterPlugins = new FEBFilterPlugins();
      }
   }
}
