#include "defines.hpp"

if(hasInterface) then {
    "cGetFundsInWarchest" addPublicVariableEventHandler {
        _input  = _this select 1;
        _value  = _input select 0;
        _player = _input select 1;
        diag_log format ["_cGetFundsInWarchest recieving %1", _value];
        player setVariable["warfund", _value, false];
    };
};