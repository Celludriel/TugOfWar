#include "scripts\warchest\defines.hpp"

if (isServer) then {
    
    call compileFinal preprocessFileLineNumbers "scripts\warchest\warchest_srv_functions.sqf";
    
    warchestBank = [];
    
    "_sCanAfford" addPublicVariableEventHandler {
        _client    = _this select 1 select 0;  
        _amount    = _this select 1 select 1;       
        _uid       = getPlayerUID _client;
        _pcid      = owner (_client);
        
        diag_log format ["_sCanAfford %1, %2, %3, %4"", _client, _amount, _uid, _pcid];
        
        _cCanAfford = false;
        _bankEntry  = (_uid call fetchWarchest) select 1;  
        if(!isNil "_bankEntry") then {            
            if(_bankEntry select 1 >= _amount) then{
                _cCanAfford = true;
            };
        };
        diag_log format ["_sCanAfford returning %1", _cCanAfford];
        _pcid publicVariableClient "_cCanAfford";
    };    

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
    
    "_sChangeFunds" addPublicVariableEventHandler {
        _client = _this select 1 select 0;
        _amount = _this select 1 select 1;        
        _uid    = getPlayerUID _client;
        
        diag_log format ["_sChangeFunds %1, %2, %3", _client, _amount, _uid];
        
        [_uidn _amount] call changeFunds;
    };        
};