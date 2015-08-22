#include "defines.hpp"

if (isServer) then {

    call compileFinal preprocessFileLineNumbers "scripts\warchest\warchest_srv_functions.sqf";

    warchestBank = [];

    onPlayerConnected {_uid call initWarchest};

    "sCanAfford" addPublicVariableEventHandler {
        _client    = _this select 1 select 0;
        _amount    = _this select 1 select 1;
        _uid       = getPlayerUID _client;
        _pcid      = owner (_client);

        diag_log format ["_sCanAfford %1, %2, %3, %4", _client, _amount, _uid, _pcid];

        cCanAfford = false;
        _bankEntry  = (_uid call fetchWarchest) select 1;
        if(!isNil "_bankEntry") then {
            if(_bankEntry select 1 >= _amount) then{
                cCanAfford = true;
            };
        };
        diag_log format ["_sCanAfford returning %1", cCanAfford];
        _pcid publicVariableClient "cCanAfford";
    };

    "sGetFundsInWarchest" addPublicVariableEventHandler {
        _client    = _this select 1 select 0;
        _uid       = getPlayerUID _client;
        _pcid      = owner (_client);
        _warchest  = _uid call fetchWarchest;

        diag_log format ["_sGetFundsInWarchest %1, %2, %3, %4", _client, _uid, _pcid, _warchest];

        _bankEntry = _warchest select 1;

        diag_log format ["_bankEntry is %1", _bankEntry];

        cGetFundsInWarchest = _bankEntry select 1;

        diag_log format ["_sGetFundsInWarchest returning %1", cGetFundsInWarchest];
        _pcid publicVariableClient "cGetFundsInWarchest";
    };

    "sChangeFunds" addPublicVariableEventHandler {
        _client = _this select 1 select 0;
        _amount = _this select 1 select 1;
        _uid    = getPlayerUID _client;

        diag_log format ["_sChangeFunds %1, %2, %3", _client, _amount, _uid];

        [_uidn, _amount] call changeFunds;
    };
};