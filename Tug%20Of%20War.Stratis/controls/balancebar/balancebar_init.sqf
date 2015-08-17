diag_log format ["Executing balancebar_init.sqf"];
#include "defines.hpp"

call compile preprocessFileLineNumbers "controls\balancebar\balancebar_functions.sqf";
if(isNil "balanceBarValue") then {
    [0] call setBalanceBarValue;
};

if (hasInterface) then {
    diag_log format ["Drawing balancebar on screen on layer %1", BALANCE_BAR_LAYER];
    BALANCE_BAR_LAYER cutRsc ["BalanceBar","PLAIN",0,false];
    [balanceBarValue] call updateBalanceBar;

    "balanceBarValue" addPublicVariableEventHandler {
        [] call balanceBarUpdateEvent;
    };
};