ON INIT {
// SET_PLATFORM
 SETNAME [description_trapdoor]
 SET_MATERIAL METAL
 LOADANIM ACTION1 "trap_sewers_open" 
 LOADANIM ACTION2 "trap_sewers_close"
 SET §open 0
 SET §unlock 0
 SET §speaking 0				// Used to make player speak one time
 SET £tools "NONE"
 SET_GROUP "trap_sewers"
 SET £controlledzone "NONE"
 ACCEPT
}

ON ACTION {
  IF (§unlock == 0) {
    PLAY "Door_lock"
    ACCEPT
  }
  IF (§open == 0) {
>>OPEN
  SET_CONTROLLED_ZONE ~£controlledzone~
    PLAYANIM ACTION1
    SET §open 1
    ACCEPT
  }
 UNSET_CONTROLLED_ZONE ~£controlledzone~
 PLAYANIM ACTION2
 SET §open 0
 ACCEPT
}

ON CUSTOM {
  IF (^$PARAM1 == "OPEN") {
    SET §unlock 1
    ACCEPT
  }
 IF (^$PARAM1 == "OPENSESAME") {
    SET §unlock 1
    GOTO OPEN
    ACCEPT
  }
 ACCEPT
}

ON HIT {
  IF (^SENDER != PLAYER) ACCEPT
 IF (§speaking == 1) ACCEPT
 SET §speaking 1
 SPEAK -p [player_wontbreak] SET §speaking 0
 ACCEPT  
}

ON COMBINE {
  IF (^$PARAM1 ISCLASS "lockpicks") {
    IF (§unlock == 1) {
      SPEAK -p [player_not_locked] NOP 
      ACCEPT
    }
    SET £tools ^$PARAM1
    SET_INTERACTIVITY NONE
    PLAY "lockpicking"
    TIMERcheckdist 0 1 GOTO CHECK_PLAYER_DIST
    TIMERpick 1 3 GOTO BACK_FROM_PICKLOCK
    ACCEPT
  }
  IF (^$PARAM1 ISCLASS KEY ) {
    PLAY "door_wrong_key"
    ACCEPT
  }
 ACCEPT
}

>>CHECK_PLAYER_DIST
  IF (^DIST_PLAYER > 400) {
    TIMERcheckdist OFF
    TIMERpick OFF
    SET_INTERACTIVITY YES
  }
 ACCEPT

>>BACK_FROM_PICKLOCK
 SET_INTERACTIVITY ON
 SPEAK -p [player_off_impossible] GOTO DAMAGE_TOOLS
 ACCEPT

>>DAMAGE_TOOLS
  SENDEVENT CUSTOM ~£tools~ "DAMAGE"
  SPEAK -p [player_picklock_failed] NOP
  ACCEPT

ON GAME_READY {
 SET_INTERACTIVITY NONE
 ACCEPT
}