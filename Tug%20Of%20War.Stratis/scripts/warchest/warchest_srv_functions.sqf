#include "defines.hpp"

if(isServer) then {
    fetchWarchest = {
        diag_log format ["Calling fetchWarchest, with %1", _this];
        _uid       = _this select 0;
        _bankEntry = nil;
        _index     = nil;
        {
            if(_x select 0 == _uid) then {
                _bankEntry = _x;
                _index     = _forEachIndex;
            }
        }forEach warchestBank;
        [_index,_bankEntry]
    };
    
    initWarchest = {
        diag_log format ["Calling initWarchest, with %1", _this];
        _uid       = _this select 0;

        _bankEntry = [_uid, DEFAULT_WARCHEST_VALUE];
        warchestBank pushBack _bankEntry;
        _uid call fetchWarchest
    };
        
    changeFunds = {
        diag_log format ["Calling changeFunds, with %1", _this];
        _uid    = _this select 0;
        _amount = _this select 1;
        
        _warchest  = _uid call fetchWarchest;
        _bankEntry = _warchest select 1;   
        _bankEntry set [1, (_currentValue + _amount)];
        _index = _warchest select 0;
        warchestBank set [_index, _bankEntry];
    };
    
};