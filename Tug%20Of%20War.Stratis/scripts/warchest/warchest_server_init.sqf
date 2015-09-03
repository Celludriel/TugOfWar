#include "defines.hpp"

if (isServer) then {
	diag_log format ["Executing warchest_server_init.sqf with %1", _this];

    call compileFinal preprocessFileLineNumbers "scripts\warchest\warchest_srv_functions.sqf";

    warchestBank = [];
};