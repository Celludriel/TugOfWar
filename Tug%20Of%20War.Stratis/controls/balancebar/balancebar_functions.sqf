diag_log format ["Executing balancebar_functions.sqf"];
#include "defines.hpp"

updateBalanceBar = {
	diag_log format ["Calling updateBalanceBar with %1", _this];
	private ["_delta"];

	_delta = _this select 0;

	disableSerialization;
	_ui = uiNamespace getVariable "OBalanceBar";

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
	diag_log format ["Executing balanceBarUpdateEvent with balanceBarValue %1", balanceBarValue];
	[balanceBarValue] call updateBalanceBar;
	if(balanceBarValue == 100 || balanceBarValue == -100) then {
		sleep 2;
		diag_log format ["Removing balancebar from layer %1", BALANCE_BAR_LAYER];
		BALANCE_BAR_LAYER cutText ["", "PLAIN"];
	};
};
setBalanceBarValue = {
	private ["_value"];
	_value = _this select 0;
	balanceBarValue = _value;
	publicVariable  "balanceBarValue";
};