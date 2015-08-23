diag_log format ["Executing balancebar_init.sqf"];
#include "defines.hpp"

call compile preprocessFileLineNumbers "controls\balancebar\balancebar_functions.sqf";
if(isNil "balanceBarValue") then {
    [0] call setBalanceBarValue;
};

if (hasInterface) then {
    "balanceBarValue" addPublicVariableEventHandler {
        [] call balanceBarUpdateEvent;
    };
};