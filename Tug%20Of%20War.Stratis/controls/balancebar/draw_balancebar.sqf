#include "defines.hpp"
diag_log format ["Executing draw_balancebar.sqf"];
if (hasInterface) then {
    _dialogName = _this select 0;
    diag_log format ["Drawing balancebar on screen on layer %1", BALANCE_BAR_LAYER];
    BALANCE_BAR_LAYER cutRsc ["BalanceBar","PLAIN",0,false];
    [_dialogName, balanceBarValue] call updateBalanceBar;
};