ON INIT {
 LOADANIM ACTION1 "L0_Alicia_portcullis_open"
 LOADANIM ACTION2 "L0_Alicia_portcullis_close"
 SETNAME [description_portcullis]
 SET_MATERIAL METAL
 SET_SHADOW OFF
 SET §open 0
 SET §playing_locked 0
 SET §lockpickability 100
 SET £opensfx "porticullis_open"
 SET £closesfx "porticullis_close"
 SET £type "NONE"
 ACCEPT
}

ON ACTION {
 IF (§playing_locked == 1) ACCEPT
 SET §playing_locked 1
 TIMERlocked 1 1 SET §playing_locked 0
 PLAY "door_locked"
 ACCEPT
}

ON OPEN {
 IF (§open == 1) ACCEPT
 SET §open 1
 PLAYANIM -e ACTION1 PLAY ~£opensfx~ 
 TIMERclose 1 60 GOTO CLOSE
 ACCEPT
}

>>CLOSE
 PLAYANIM -e ACTION2 PLAY ~£closesfx~
 SENDEVENT CUSTOM TIMED_LEVER_0042 "CLOSE"
 SET §open 0
 ACCEPT

ON COMBINE {
  IF (^$param1 ISCLASS "lockpicks") {
    SET £tools ^$param1
    IF (§open == 1) ACCEPT
    SPEAK -p [player_picklock_impossible] NOP
    SENDEVENT CUSTOM ~£tools~ "DAMAGE"
    PLAY "door_locked"
    ACCEPT
  }
 ACCEPT
}