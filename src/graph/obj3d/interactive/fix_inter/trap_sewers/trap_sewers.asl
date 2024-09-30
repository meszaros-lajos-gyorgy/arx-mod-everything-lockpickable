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
 SET §lockpickability 20
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
//#lockpick
//---------------------------------------------------------------------------
// LOCKPICK INCLUDE START ---------------------------------------------------
//---------------------------------------------------------------------------
 IF (^$param1 ISCLASS "lockpicks") 
 {
  SET £tools ^$param1
  IF (§unlock == 1) ACCEPT
  SET_INTERACTIVITY NONE
  SENDEVENT CUSTOM ~£tools~ "INTERNO"
  PLAY "lockpicking"
  TIMERcheckdist 0 1 GOTO CHECK_PLAYER_DIST
  TIMERpick 1 3 GOTO BACK_FROM_PICKLOCK
  ACCEPT

>>CHECK_PLAYER_DIST
  IF (^DIST_PLAYER > 400) 
  {
   SENDEVENT CUSTOM ~£tools~ "INTERYES"
   TIMERcheckdist OFF
   TIMERpick OFF
   SET_INTERACTIVITY YES
  }
  ACCEPT

>>BACK_FROM_PICKLOCK
  TIMERcheckdist OFF
  SENDEVENT CUSTOM ~£tools~ "INTERYES"
  SET_INTERACTIVITY YES
  SETMAINEVENT MAIN
  IF (§lockpickability == 100) 
  {
   SPEAK -p [player_off_impossible] NOP
   ACCEPT
  }
  IF (^PLAYER_SKILL_MECANISM < §lockpickability)
  {
   SPEAK -p [player_picklock_impossible] NOP
   GOTO DAMAGE_TOOLS
  }
  SET §chance ~^PLAYER_SKILL_MECANISM~
  DEC §chance §lockpickability
  INC §chance 20
  RANDOM ~§chance~ 
  {
   SPEAK -p [player_picklock_succeed] NOP
   SET §unlock 1
   PLAY "door_unlock"
   ADDXP 150
   SENDEVENT LOCKPICKED SELF ""
   ACCEPT
  }
  SPEAK -p [player_picklock_failed] NOP
>>DAMAGE_TOOLS
  SENDEVENT LOCKPICKED SELF ""
  SENDEVENT CUSTOM ~£tools~ "DAMAGE"
  PLAY "door_locked"
  ACCEPT
 }

ON GAME_READY {
 SET_INTERACTIVITY NONE
 ACCEPT
}