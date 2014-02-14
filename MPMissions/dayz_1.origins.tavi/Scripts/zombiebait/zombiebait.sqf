player playActionNow "Medic";
sleep 1;
titleText ["Has puesto una trampa para zombis. Corre!!","PLAIN DOWN"]; titleFadeOut 5;
 
_mypos = getposATL player;
_dir = getdir player;
_mypos = [(_mypos select 0)+2*sin(_dir),(_mypos select 1)+2*cos(_dir), (_mypos select 2)];
_createBait = createVehicle ["Land_Bucket_EP1", _mypos, [], 0, "CAN_COLLIDE"];
_createBait setDir _dir;
_createBait setposATL _mypos;
sleep 1;
 
player removeMagazine "ItemBloodbag";
if ("FoodbeefRaw" in magazines player) {
player removeMagazine "FoodbeefRaw";
}
if ("FoodSteakRaw" in magazines player) {
player removeMagazine "FoodSteakRaw";
}
sleep 10;
 
_i = 0;
_bait = nearestObject [player, "Land_Bucket_EP1"];
_setBait = (getPosATL _bait) nearEntities ["zZombie_Base",50];
{
    _group = group _x;
    if (isNull group _x) then {
        _group = _x;
    };
    _x reveal [_bait,4];
    _targets = _group getVariable ["targets",[]];
    if (!(_bait in _targets)) then {
        _targets set [count _targets,_bait];
        _group setVariable ["targets",_targets,true];
    };
    _i = _i + 1;
} forEach _setBait;
 
sleep 120;
titleText ["Tu trampa para zombis desaparecio.","PLAIN DOWN"]; titleFadeOut 5;
deleteVehicle _createBait;
 
player removeAction zombieBait;