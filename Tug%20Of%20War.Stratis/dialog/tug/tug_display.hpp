///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////
class IGUIBack
{
    type = 0;
    idc = 124;
    style = 128;
    text = "";
    colorText[] = {0,0,0,0};
    font = "PuristaMedium";
    sizeEx = 0;
    shadow = 0;
    x = 0.1;
    y = 0.1;
    w = 0.1;
    h = 0.1;
    colorbackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
};
class RscText
{
    deletable = 0;
    fade = 0;
    access = 0;
    type = 0;
    idc = -1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;
    style = 0;
    shadow = 1;
    colorShadow[] = {0,0,0,0.5};
    font = "PuristaMedium";
    SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    linespacing = 1;
    tooltipColorText[] = {1,1,1,1};
    tooltipColorBox[] = {1,1,1,1};
    tooltipColorShade[] = {0,0,0,0.65};
};

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
    onUnload     = "uiNamespace setVariable ['TugDisplayContainer', objNull];";
    onDestroy    = "uiNamespace setVariable ['TugDisplayContainer', objNull];";
    class Controls{
        class TugDisplayControl: IGUIBack
        {
            idc = TUG_DISPLAY_CONTAINER_ID;
            x = 0.195781 * safezoneW + safezoneX;
            y = 0.016 * safezoneH + safezoneY;
            w = 0.20625 * safezoneW;
            h = 0.066 * safezoneH;
            colorBackground[] = {0,0,0,0.3};
        };
        class LoseBackground: BalanceBarLoseBackground{
            idc = BALANCE_BAR_LOSE_BACKGROUND_ID;
        };
        class WinBackground: BalanceBarWinBackground{
            idc = BALANCE_BAR_WIN_BACKGROUND_ID;
        };
        class LoseProgress: BalanceBarLoseProgress{
            idc = BALANCE_BAR_LOSE_PROGRESS_ID;
        };
        class WinProgress: BalanceBarWinProgress{
            idc = BALANCE_BAR_WIN_PROGRESS_ID;
        };
        class WarchestValueText: RscText
        {
            idc  = TUG_DISPLAY_WARCHEST_ID;
            text = "Warchest: 0";
            x    = 0.267969 * safezoneW + safezoneX;
            y    = 0.049 * safezoneH + safezoneY;
            w    = 0.061875 * safezoneW;
            h    = 0.022 * safezoneH;
            colorText[] = {1,1,1,1};
        };
    };
};

////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////