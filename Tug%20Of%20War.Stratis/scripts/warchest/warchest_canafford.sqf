#include "defines.hpp"

if (isServer) then {
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
};

if(hasInterface) then {
    "_cCanAfford" addPublicVariableEventHandler {
        _value = _this select 1;
        diag_log format ["_cCanAfford recieving %1", _value];
        hint str _value;
    };
};