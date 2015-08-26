#include "defines.hpp"

if(isServer) then {
    fetchWarchest = {
        diag_log format ["Calling fetchWarchest, with %1", _this];
        private ["_retValue"];

        diag_log format ["warchestBank: %1", warchestBank];
        _retValue = nil;
        {
            if(_x select 0 == _this) then {
                _retValue = [_forEachIndex, _x];
            }
        }forEach warchestBank;

        if(isNil "_retValue") then {
            _retValue = _this call initWarchest;
        };

        _retValue
    };

    initWarchest = {
        diag_log format ["Calling initWarchest, with %1", _this];
        diag_log format ["warchestBank: %1", warchestBank];

        warchestBank pushBack [_this, DEFAULT_WARCHEST_VALUE];

        [_this,DEFAULT_WARCHEST_VALUE] call setWarfundOnPlayerByPlayerUID;        
        _this call fetchWarchest
    };

    setWarfundOnPlayerByPlayerUID = {
        diag_log format ["Calling setWarfundOnPlayerByPlayerUID, with %1", _this];
        _playerUID = _this select 0;
        _amount    = _this select 1;
        
        {
            if(_playerUID == getPlayerUID _x) exitWith {
                _x setVariable ["warfund", _amount, true];
            };
        } forEach allPlayers;        
    };
    
    changeFunds = {
        diag_log format ["Calling changeFunds, with %1", _this];
        private ["_uid", "_amount"];

        diag_log format ["warchestBank: %1", warchestBank];
        _uid    = _this select 0;
        _amount = _this select 1;

        _warchest  = _uid call fetchWarchest;

        diag_log format ["_warchest: %1", _warchest];

        //update bank entry
        _bankEntry = _warchest select 1;
        _newAmount = ((_bankEntry select 1) + _amount);
        _bankEntry set [1, _newAmount];
        
        //put bank entry back in the warchest
        _index = _warchest select 0;
        warchestBank set [_index, _bankEntry];
        
        //communicate players new balance
        [_uid,_newAmount] call setWarfundOnPlayerByPlayerUID; 
    };

    changeFundsAllPlayers = {
        diag_log format ["Calling changeFundsAllPlayers, with %1", _this];
        private ["_amount"];

        diag_log format ["warchestBank: %1", warchestBank];
        _amount = _this select 0;

        {
            [_x select 0, _amount] call changeFunds;
        } forEach warchestBank;
    };

    canAfford = {
        diag_log format ["Calling canAfford, with %1", _this];
        private ["_retValue","_uid","_amount","_bankEntry"];

        _uid       = _this select 0;
        _amount    = _this select 1;
        _retValue  = false;
        _bankEntry = (_uid call fetchWarchest) select 1;

        diag_log format ["_bankEntry: %1", _bankEntry];
        if(!isNil "_bankEntry") then {
            if(_bankEntry select 1 >= _amount) then{
                _retValue = true;
            };
        };
        diag_log format ["canAfford: %1", _retValue];
        _retValue
    };
};