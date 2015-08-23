////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sunspot, v1.063, #Hakiqi)
////////////////////////////////////////////////////////

class TugDisplayContainer{
    name         = "TugDisplayContainer";
    idd          = TUG_DISPLAY_CONTAINER_ID;
    fadein       = 0;
    duration     = 99999999999;
    fadeout      = 0;
    movingEnable = 1;
    onLoad       = "uiNamespace setVariable ['TugDisplayContainer',_this select 0];";
    onUnload     = "uiNamespace setVariable ['TugDisplayContainer', objNull]";
    onDestroy    = "uiNamespace setVariable ['TugDisplayContainer', objNull]"; 
    class Controls{
        class TugDisplayControl: IGUIBack
        {
            idc = 2200;
            x = 0.195781 * safezoneW + safezoneX;
            y = 0.016 * safezoneH + safezoneY;
            w = 0.20625 * safezoneW;
            h = 0.066 * safezoneH;
            colorBackground[] = {0,0,0,0.3};
        };
        class TugBalanceBar: BalanceBar
        {
            //add stuff here to import my other gui element
        }
        class WarchestValueText: RscText
        {
            idc = 1000;
            text = "Warchest: 0"; //--- ToDo: Localize;
            x = 0.267969 * safezoneW + safezoneX;
            y = 0.049 * safezoneH + safezoneY;
            w = 0.061875 * safezoneW;
            h = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
        };        
    };
};
    
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////