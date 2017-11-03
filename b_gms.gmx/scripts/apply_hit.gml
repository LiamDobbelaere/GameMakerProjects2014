objGUI.pwr = pwr
objGUI.atk_pow = atk_pow
with (objGUI)
{
    atkpower = round(atk_pow*(pwr/50))
    get[1] = http_get("http://" + global.host + "/request.php?rtype=setevent&batid=" + string(global.BattleID) + "&event=" + string("atk") + ":" + global.playtype + ":" + string(atkpower) + ":" + string(atk_pow))
    global.vsHP-=atkpower
    global.myXP += round(atk_pow*global.myLevel/2)
    if global.vsHP<=0 then {
    global.vsHP = 0
    event = "iwon"
    }
    else event = "wait"
    lbar.visible = true
    alarm[0] = room_speed
}
instance_destroy();
