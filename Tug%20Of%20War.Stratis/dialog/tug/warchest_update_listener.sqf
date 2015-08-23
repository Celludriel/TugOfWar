#include "defines.hpp"
if(hasInterface) then {
	disableSerialization;
    _previousWarfund = 0;

    sleep 2;
    while{true} do {
        _warfund = player getVariable "warfund";
        if(_warfund != _previousWarfund) then {
	    	diag_log format ["_warfund: %1", _warfund];
			_ui = uiNamespace getVariable ["TugDisplayContainer", objNull];
			_displayWarchest = _ui displayCtrl TUG_DISPLAY_WARCHEST_ID;
            _displayWarchest ctrlSetText  format ["Warchest: %1", _warfund];
            _previousWarfund = _warfund;
        };
        sleep 1;
    };
};