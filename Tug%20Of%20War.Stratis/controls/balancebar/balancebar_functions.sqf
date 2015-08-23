diag_log format ["Executing balancebar_functions.sqf"];
#include "defines.hpp"

updateBalanceBar = {
    diag_log format ["Calling updateBalanceBar with %1", _this];
    private ["_dialogName", "_delta"];

    _dialogName = _this select 0;
    _delta      = _this select 1;

    disableSerialization;

    _ui = uiNamespace getVariable [_dialogName, objNull];
    diag_log format ["_ui: %1", _ui];

    if(_delta >= 0) then {
        _balanceBar = _ui displayCtrl BALANCE_BAR_WIN_PROGRESS_ID;
        _balanceBar progressSetPosition (balanceBarValue / 100.0);
        _balanceBar = _ui displayCtrl BALANCE_BAR_LOSE_PROGRESS_ID;
        _balanceBar progressSetPosition 100.0;
    } else {
        _balanceBar = _ui displayCtrl BALANCE_BAR_LOSE_PROGRESS_ID;
        _balanceBar progressSetPosition (1 + (balanceBarValue / 100.0));
        _balanceBar = _ui displayCtrl BALANCE_BAR_WIN_PROGRESS_ID;
        _balanceBar progressSetPosition 0;
    };
};

balanceBarUpdateEvent = {
    diag_log format ["Calling balanceBarUpdateEvent with %1", _this];
    private ["_dialogName"];

    _dialogName = _this select 0;
    [_dialogName, balanceBarValue] call updateBalanceBar;
};

setBalanceBarValue = {
    private ["_value"];
    _value = _this select 0;
    balanceBarValue = _value;
    publicVariable  "balanceBarValue";
};