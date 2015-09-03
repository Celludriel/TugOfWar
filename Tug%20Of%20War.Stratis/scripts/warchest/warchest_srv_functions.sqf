#include "defines.hpp"

if(isServer) then {
    fetchWarchest = {
        diag_log format ["Calling fetchWarchest, with %1", _this];
        private ["_playerUID", "_retValue"];

        _playerUID = getPlayerUID _this;

        diag_log format ["warchestBank: %1", warchestBank];
        _retValue = nil;
        {
            if(_x select 0 == _playerUID) then {
                _retValue = [_forEachIndex, _x];
            };
        }forEach warchestBank;

        if(isNil "_retValue") then {
            _retValue = _this call initWarchest;
        };

        _retValue
    };

    initWarchest = {
        diag_log format ["Calling initWarchest, with %1", _this];
        diag_log format ["warchestBank: %1", warchestBank];
        private ["_playerUID"];

        _playerUID = getPlayerUID _this;

        if(_playerUID != "") then {
            warchestBank pushBack [_playerUID, DEFAULT_WARCHEST_VALUE];

            [_this, DEFAULT_WARCHEST_VALUE] call setWarfundOnPlayer;
            _this call fetchWarchest
        };
    };

    setWarfundOnPlayer = {
        diag_log format ["Calling setWarfundOnPlayer with %1", _this];
        private ["_amount", "_player"];

        _player = _this select 0;
        _amount    = _this select 1;
        _player setVariable ["warfund", _amount, true];
    };

    changeFunds = {
        diag_log format ["Calling changeFunds, with %1", _this];
        private ["_amount", "_player", "_warchest", "_bankEntry", "_newAmount", "_index"];

        diag_log format ["warchestBank: %1", warchestBank];
        _player = _this select 0;
        _amount = _this select 1;

        _warchest  = _player call fetchWarchest;

        diag_log format ["_warchest: %1", _warchest];

        //update bank entry
        _bankEntry = _warchest select 1;
        _newAmount = ((_bankEntry select 1) + _amount);
        _bankEntry set [1, _newAmount];

        //put bank entry back in the warchest
        _index = _warchest select 0;
        warchestBank set [_index, _bankEntry];

        //communicate players new balance
        [_player,_newAmount] call setWarfundOnPlayer;
    };

    changeFundsAllPlayers = {
        diag_log format ["Calling changeFundsAllPlayers, with %1", _this];
        private ["_amount", "_playerUID", "_player"];

        diag_log format ["warchestBank: %1", warchestBank];
        _amount = _this select 0;

        {
            _playerUID = _x select 0;
            _player = nil;
            {
                if(getPlayerUID _x == _playerUID) exitWith {
                    _player = _x;
                };
            } forEach allPlayers;
            [_player, _amount] call changeFunds;
        } forEach warchestBank;
    };

    canAfford = {
        diag_log format ["Calling canAfford, with %1", _this];
        private ["_retValue","_player","_amount","_bankEntry"];

        _player    = _this select 0;
        _amount    = _this select 1;
        _retValue  = false;
        _bankEntry = (_player call fetchWarchest) select 1;

        diag_log format ["_bankEntry: %1", _bankEntry];
        if(!isNil "_bankEntry") then {
            if(_bankEntry select 1 >= _amount) then {
                _retValue = true;
            };
        };
        diag_log format ["canAfford: %1", _retValue];
        _retValue
    };
};