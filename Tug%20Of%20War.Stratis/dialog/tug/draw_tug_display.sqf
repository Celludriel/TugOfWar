#include "defines.hpp"
diag_log format ["Executing draw_tug_display.sqf"];
if (hasInterface) then {
    _dialogName = _this select 0;
    diag_log format ["Drawing tug_display on screen on layer %1", TUG_DISPLAY_LAYER];
    TUG_DISPLAY_LAYER cutRsc ["TugDisplayContainer","PLAIN",0,false];
    [_dialogName, balanceBarValue] call updateBalanceBar;    
    [] execVM "dialog\tug\warchest_update_listener.sqf";
};