class ProgressBaseTextHUD{
    access = 0;
    type = CT_STATIC;
    style = ST_CENTER;
    idc = -1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,0.8};
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    shadow = 2;
    font = GUI_FONT_NORMAL;
    sizeEx = "0.035";
};

class RscProgressBar{
    type = CT_PROGRESS;
    style = ST_HORIZONTAL;
    texture = "";
    shadow = 2;
    colorFrame[] = {0.8,0.48,0,1};
    colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
};

class BalanceBar{
    name = "BalanceBar";
    idd = BALANCE_BAR_CONTAINER_ID;
    fadein=0;
    duration = 99999999999;
    fadeout=0;
    movingEnable = 1;
    onLoad = "uiNamespace setVariable ['OBalanceBar',_this select 0];";
    class Controls{
        class LoseBackground: ProgressBaseTextHUD{
            idc = BALANCE_BAR_LOSE_BACKGROUND_ID;

            x = safezoneX + (safeZoneW * BALANCE_BAR_X);
            y = safeZoneY + (safeZoneH * BALANCE_BAR_Y);
            w = BALANCE_BAR_SIZE * 3 / 4;
            h = BALANCE_BAR_HEIGHT;
            colorBackground[] = {1,0,0,1};
        };
        class WinBackground: ProgressBaseTextHUD{
            idc = BALANCE_BAR_WIN_BACKGROUND_ID;

            x = (safezoneX + (safeZoneW * BALANCE_BAR_X)) + (BALANCE_BAR_SIZE * 3 / 4);
            y = safeZoneY + (safeZoneH * BALANCE_BAR_Y);
            w = BALANCE_BAR_SIZE * 3 / 4;
            h = BALANCE_BAR_HEIGHT;
            colorBackground[] = {0,0,0,1};
        };
        class LoseProgress: RscProgressBar{
            idc = BALANCE_BAR_LOSE_PROGRESS_ID;

            x = safezoneX + (safeZoneW * BALANCE_BAR_X);
            y = safeZoneY + (safeZoneH * BALANCE_BAR_Y);
            w = BALANCE_BAR_SIZE * 3 / 4;
            h = BALANCE_BAR_HEIGHT;
            colorBar[] = {0,0,0,1};
        };
        class WinProgress: RscProgressBar{
            idc = BALANCE_BAR_WIN_PROGRESS_ID;

            x = (safezoneX + (safeZoneW * BALANCE_BAR_X)) + (BALANCE_BAR_SIZE * 3 / 4);
            y = safeZoneY + (safeZoneH * BALANCE_BAR_Y);
            w = BALANCE_BAR_SIZE * 3 / 4;
            h = BALANCE_BAR_HEIGHT;
            colorBar[] = {0,0,1,1};
        };
    };
};