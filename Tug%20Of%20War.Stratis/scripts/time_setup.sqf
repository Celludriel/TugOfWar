if (isServer) then {
    _definedTime = "TimeOfDay" call BIS_fnc_getParamValue;
    diag_log format ["TimeOfDay: %1", _definedTime];
    skipTime ((_definedTime - daytime + 24 ) % 24 );
};