#include "defines.hpp"

if(hasInterface) then {
    "cCanAfford" addPublicVariableEventHandler {
        _value = _this select 1;
        diag_log format ["_cCanAfford recieving %1", _value];
        hint str _value;
    };

    "cGetFundsInWarchest" addPublicVariableEventHandler {
        _value = _this select 1;
        diag_log format ["_cGetFundsInWarchest recieving %1", _value];
        hint str _value;
    };
};