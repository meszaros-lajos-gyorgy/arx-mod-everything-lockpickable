ON INIT {
 SETNAME [description_massivedoor]
 SET_SHADOW OFF
 LOADANIM ACTION1 "Door_close"
 LOADANIM ACTION2 "Door_open"
 SET §open 0
 SET §unlock 0
 SET £key "NOKEY"
 SET §lockpickability 99
 ACCEPT
}

ON ACTION {
  IF (§open == 0) {
    IF (§unlock == 1) {
      PLAYANIM ACTION2
      SET §open 1
      ACCEPT
    }
    SPEAK -p [player_locked] nop
    ACCEPT
  }
  ELSE {
    PLAYANIM ACTION1
    SET §open 0
  }
 ACCEPT
 }

ON HIT {
  IF (^SENDER != PLAYER) ACCEPT
 SPEAK -p [player_wontbreak] nop
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
//---------------------------------------------------------------------------
// LOCKPICK INCLUDE END -----------------------------------------------------
//---------------------------------------------------------------------------

//#
 IF (^$PARAM1 == £key ) 
 {
  IF (§unlock == 1) 
  {
   SET §unlock 0
   PLAY "door_unlock"
   }
  ELSE 
  {
   SET §unlock 1
   PLAY "door_unlock"
  }
 }
 ACCEPT
}

