diag_log format ["Executing threatmanager_engine.sqf"];
if (isServer) then {
	while{ true } do {
		diag_log format ["Evaluating all threats"];
		if(!isNil "activeThreatGroups") then {
			_timeSpot = serverTime;
			{
				_spawnId = _x select 0;
				_trigger = _x select 1;
				_timeToLive = _x select 2;

				if(_timeToLive <= _timeSpot) then {
					[_spawnId] call removeThreatBySpawnId;
				};
			} forEach activeThreatGroups;
		};
		sleep 60;
	};
};