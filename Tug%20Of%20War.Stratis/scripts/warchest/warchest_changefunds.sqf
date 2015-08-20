if (isServer) then {
    "_sChangeFunds" addPublicVariableEventHandler {
        _client = _this select 1 select 0;
        _amount = _this select 1 select 1;        
        _uid    = getPlayerUID _client;
        
        diag_log format ["_sChangeFunds %1, %2, %3", _client, _amount, _uid];
        
        [_uidn _amount] call changeFunds;
    };    
};