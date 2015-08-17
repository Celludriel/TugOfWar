/* Pierre MGI - MGI_Tactical_Icons.sqf - October 2014 - mod Feb 2015


This script is called by switch (HUD_switches_menu.sqf)
it displays :
- a light blue icon on nearest building (waiting for better working functions as findcover... );

- an icon (NATO sign) colored by side, above each (visible on screen) entity within 500m of player's position. Distance is displayed under icon for friendly unit farer than 300m;

- an orange icon for nearest enemy (known by player group) with mark for distance :
 * if _dist_x > 360 -> distance is numeric,
 * if _dist_x < 360 -> a little bar rotates around orange diamond icon indicating distance in meter same as heading : "north or up" means 360m, "east or left" means 270m, down 180m, right 90m.
 * if this icon is about to be lost out of screen (left or rignt side), orange marks appears to indicate the nearest enemy direction.


_______________________________________*/


if (!alive player or (toggle_icons == 0) or {cameraView != "internal" && cameraView != "gunner"}) exitWith {}; // switch off icons display if not 1st person
if(!isnull (findDisplay 602) or !isnull (findDisplay 314) or !isnull (findDisplay 49)) exitWith {}; // switch off icons display (inventry opened, camera mode, game paused)


private ["_dist_x","_stance_coef","_NearestEnemy","_Dist_ne","_d_ne","_mark_angle","_diststrg"];
//___________________________units within 500 m________________________________

_player_side = getNumber (configfile >> "CfgVehicles" >> typeOf player >> "side"); // true side of player
_total_entities = 0;

_totalEntitiesInRange = (getPosATL player) nearEntities [["CAManBase", "Air", "Car", "Motorcycle", "Tank"], 300];

// hint format ["total_entities in range %1", count _totalEntitiesInRange];

{   //start fnc nearentities
  if(_total_entities >= 10) exitWith { true };

//__________friends icons within 500m are always displayed (as broadcasted) /  other icons are displayed only when line of sight (LOS) is clear____________

  if ((side _x == playerSide ) or (!(lineIntersects [eyePos player, eyePos _x, player, _x]) && !(terrainIntersect [[getPosATL player select 0, getPosATL player select 1, (getPosATL player select 2)+0.5], [getPosATL _x select 0, getPosATL _x select 1, (getPosATL _x select 2)+1]]) )) then {
    //____________________________ Tac icons_______________

      if ( !(_x isKindOf "animal")
            && {_x != vehicle player}
            && {((worldToScreen (visiblePosition _x)) select 0 > (0 * safezoneW + safezoneX))
            && ((worldToScreen (visiblePosition _x)) select 0 <(1 * safezoneW + safezoneX))} ) then {

      _dist_x = round(player distance _x);
      [_x] call MGI_Stance;
      d = _stance_coef + (0.006 * _dist_x / coef_zoom);
      d_gr = _stance_coef + (0.025*_dist_x / coef_zoom);

      if (_dist_x > 300) then {
        frame = str(_dist_x)
      } else {
        frame = ""
      };

      _uispace = 0.6 * coef_uiSpace;
      _true_side = getNumber (configfile >> "CfgVehicles" >> typeOf (crew _x select 0) >> "side"); // icon of crew instead of vehicle's original side

      call{
        if (getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Combat Life Saver" or getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Recon Paramedic") exitWith {icontype = "med"};
        if (getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Engineer" or getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName") == "Repair Specialist") exitWith {icontype = "maint"};
        if (_x isKindOf "man" && {faction _x != "CIV_F"}) exitWith {icontype = "inf"};
        if (_x isKindOf "tank") exitWith {icontype = "armor"};
        if (_x isKindOf "car" && {faction _x != "CIV_F"}) exitWith {icontype = "motor_inf"};
        if (_x isKindOf "staticweapon") exitWith {icontype = "art"};
        if (_x isKindOf "UAV") exitWith {icontype = "uav"};
        if (_x isKindOf "air") exitWith {icontype = "air"};
        if (_x isKindOf "ship" && {side _x != civilian}) exitWith {icontype = "naval"};
      };

      call {
        if (_true_side == 3 or !alive (crew _x select 0)) exitWith {}; //exit if  former civilian, or dead crew inside
        if (captive _x && (_x ammo (currentWeapon _x) == 0)) exitWith {}; // prisoners and unarmed "setcaptive" are no more iconed
        if (_true_side == 1) exitWith {}; //no friendly icons they just take up enemy icon space

        if (_true_side == 0) exitWith {
          drawIcon3D [tostring (toarray("A3\ui_f\data\map\Markers\NATO\o_")) + icontype + ".paa", [1,0.3,0.3,0.1+brit*(0.2+_dist_x*0.012)], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2 )+ d],_uispace*coef_ratio,_uispace,360,"",1, 0.03,"EtelkaMonospacePro"];
          _total_entities = _total_entities + 1
        };

        if (_true_side == 2 && (resistance getfriend (side player) >= 0.6)) exitWith {
          drawIcon3D [tostring (toarray("A3\ui_f\data\map\Markers\NATO\n_")) + icontype + ".paa", [0.1,0.8,0.1,0.1+brit*(0.2+_dist_x*0.012)], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2 )+ d],_uispace*coef_ratio,_uispace,360,"",1, 0.03,"EtelkaMonospacePro"];
          _total_entities = _total_entities + 1
        }; //green

        if (_true_side == 2 && (resistance getfriend (side player) < 0.6)) exitWith {
          drawIcon3D [tostring (toarray("A3\ui_f\data\map\Markers\NATO\n_")) + icontype + ".paa", [1,1,0,0.1+brit*(0.2+_dist_x*0.012)], [visiblePosition _x select 0, visiblePosition _x select 1, (getPosATL _x select 2 )+ d],_uispace*coef_ratio,_uispace,360,"",1, 0.03,"EtelkaMonospacePro"];
          _total_entities = _total_entities + 1
        }; //yellow
      };
    }; // end !animal && me
  }; // end LoS
} foreach (_totalEntitiesInRange);