#include "defines.hpp"
if(hasInterface) then {
	disableSerialization;
    _previousWarfund = 0;

    sleep 5;
    while{true} do {
        _warfund = player getVariable ["warfund", objNull];
        diag_log format ["_warfund: %1", _warfund];

        if(_warfund != _previousWarfund) then {
            _ui = uiNamespace getVariable ["TugDisplayContainer", objNull];
            _displayWarchest = _ui displayCtrl TUG_DISPLAY_WARCHEST_ID;
            _displayWarchest ctrlSetText  format ["Warchest: %1", _warfund];
            _previousWarfund = _warfund;
        };

        sleep 1;
    };
};