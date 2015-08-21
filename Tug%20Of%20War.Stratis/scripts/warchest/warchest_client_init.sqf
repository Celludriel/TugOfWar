#include "scripts\warchest\defines.hpp"

if(hasInterface) then {
    "_cCanAfford" addPublicVariableEventHandler {
        _value = _this select 1;
        diag_log format ["_cCanAfford recieving %1", _value];
        hint str _value;
    };
    
    "_cGetFundsInWarchest" addPublicVariableEventHandler {
        _value = _this select 1;
        diag_log format ["_cGetFundsInWarchest recieving %1", _value];
        hint str _value;
    };    
};