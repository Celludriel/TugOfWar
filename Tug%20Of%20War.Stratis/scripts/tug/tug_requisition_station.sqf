if (!isServer) exitWith {};
    
_station     = _this select 0;
_spawnMarker = _this select 1;
_vehicleType = _this select 2;
_value       = _this select 3;

//make indestructable
_station addEventHandler ["HandleDamage", {false}];

//add requisition action
_station addaction [format["Requisition (%1)", _value], 
{
    diag_log format ["Calling Requisition action, with %1", _this];
    _caller = _this select 1;
    _uid    = getPlayerUID _client;
    if([_uid, _value] call canAfford) then {
        _spawnLocation = getMarkerPos _spawnMarker;
        _vehicle       = createVehicle [_vehicleType, _spawnLocation, [], 0, "NONE"];
        _dir = getDir _spawnLocation;
        _vehicle setDir _dir;
        [_uid, -(_value)] call changeFunds;
    } else {
        hint "You cannot afford this vehicle";
    };
}];