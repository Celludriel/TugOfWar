if (isServer) then {
    call compileFinal preprocessFileLineNumbers "scripts\warchest\warchest_srv_functions.sqf";
    
    warchestBank = [];    
};