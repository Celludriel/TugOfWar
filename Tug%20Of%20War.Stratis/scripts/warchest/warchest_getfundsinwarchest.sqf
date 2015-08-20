if (isServer) then {
    "_sGetFundsInWarchest" addPublicVariableEventHandler {
        _client    = _this select 1 select 0;        
        _uid       = getPlayerUID _client;
        _pcid      = owner (_client);
        _warchest  = _uid call fetchWarchest;
        
        diag_log format ["_sGetFundsInWarchest %1, %2, %3, %4"", _client, _uid, _pcid, _warchest];
        
        _bankEntry = nil;
        if(isNil "_warchest")then {
            _bankEntry = (_uid call initWarchest) select 1;
        }else{
            _bankEntry = _warchest select 1;
        }
        
        _cGetFundsInWarchest = _bankEntry select 1;
        
        diag_log format ["_sGetFundsInWarchest returning %1", _cGetFundsInWarchest];
        _pcid publicVariableClient "_cGetFundsInWarchest";
    };    
};

if(hasInterface) then {
    "_cGetFundsInWarchest" addPublicVariableEventHandler {
        _value = _this select 1;
        diag_log format ["_cGetFundsInWarchest recieving %1", _value];
        hint str _value;
    };
};