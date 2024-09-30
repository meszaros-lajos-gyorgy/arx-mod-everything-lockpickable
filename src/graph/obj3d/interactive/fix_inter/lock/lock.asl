ON INIT {
 SET §teleporter 0
 SETNAME [description_lock]
 SET_SHADOW OFF
 COLLISION ON
 SET_MATERIAL METAL
 SET §unlock 0
 SET £key "NONE"
 SET §lockpickability 99
 SET £controlled_door "NONE"
 SET §chance 0
 SET £tools "NONE"
 SET §relock 0
 SET §wrong_snd 0
 ACCEPT
}

ON COMBINE 
{
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
 IF (^$PARAM1 ISIN £key ) 
 {
  IF (§teleporter == 1) {
   PLAY "door_unlock"
   SENDEVENT OPEN ~£controlled_door~ ""
   ACCEPT
  } 
 IF (§unlock == 1) 
  {
   SET §unlock 0
   PLAY "door_lock"
   SENDEVENT CLOSE ~£controlled_door~ ""
  }
  ELSE 
  {
>>UNLOCK
   SET §unlock 1
   PLAY "door_unlock"
   SENDEVENT OPEN ~£controlled_door~ ""
  }
  ACCEPT
 }
 IF (§wrong_snd == 1) ACCEPT
 SET §wrong_snd 1
 TIMERwrgsnd 1 1 SET §wrong_snd 0
 PLAY "door_wrong_key"
 ACCEPT
}