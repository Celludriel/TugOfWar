if (!isServer) exitWith {};

_station     = _this select 0;
_spawnMarker = _this select 1;
_vehicleType = _this select 2;
_value       = _this select 3;

//make indestructable
_station addEventHandler ["HandleDamage", {false}];
_station setVariable ["_value", _value, true];
_station setVariable ["_spawnMarker", _spawnMarker, true];
_station setVariable ["_vehicleType", _vehicleType, true];

//add requisition action
_station addaction [format["Requisition (%1)", _value],
{
    diag_log format ["Calling Requisition action, with %1", _this];
    _station = _this select 0;
    _caller = _this select 1;
    _uid    = getPlayerUID _caller;
    _value = _station getVariable "_value";
    _spawnMarker = _station getVariable "_spawnMarker";
    _vehicleType = _station getVariable "_vehicleType";

    if([_uid, _value] call canAfford) then {
        _spawnLocation = getMarkerPos _spawnMarker;
        _list          = _spawnLocation nearObjects 5;

        if(count _list == 0) then {
            _vehicle = createVehicle [_vehicleType, _spawnLocation, [], 0, "NONE"];
            _dir     = markerDir _spawnMarker;
            _vehicle setDir _dir;
            [_uid, -(_value)] call changeFunds;
        } else {
            hint "Something is blocking the deployment zone";
        };
    } else {
        hint "You cannot afford this vehicle";
    };
}];