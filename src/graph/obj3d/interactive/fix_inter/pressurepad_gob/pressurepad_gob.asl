ON INIT {
 SET_PLATFORM ON
 SET_SHADOW OFF
 SET_INTERACTIVITY NONE
 LOADANIM ACTION1 "pressurepad_down"
 LOADANIM ACTION2 "pressurepad_up"
 SET §onme 0
 SETANGULAR ON
 SETBUMP ON
 SETZMAP ON
 // for trap lockpicking....
 SET §lockpickability 99
 SET §unlock 0

 // for trap detection
 SETTRAP -1
 ACCEPT
}

ON INITEND
{
 IF ( §lockpickability != 100 )
 {
  SET_INTERACTIVITY YES
 }
 ACCEPT
}

ON SPELLCAST {
 IF (§trapped == 0) ACCEPT
 IF (^DIST_PLAYER > 400) ACCEPT
 IF (^$PARAM1 == DISARM_TRAP) {
  SET #TMP ~^#PARAM2~
  MUL #TMP 10
  IF (#TMP < §trap_lockpickability) {
   SPEAK -p [player_not_skilled_enough] NOP
   play "magic_fizzle"
   ACCEPT
  }
  SENDEVENT TRAP_DISARMED SELF ""
 }
 ACCEPT
}

ON TREATOUT {
 REFUSE
}

ON TRAP_DISARMED
{
 IF (§trapped == 0) ACCEPT
 TIMERpouet 1 1 HALO -f
 HALO -os 30
 SET §unlock 1 // this event can be send by the game...
 SETTRAP -1
 SET_INTERACTIVITY NONE
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

 ACCEPT
}

ON LOCKPICKED
{
 IF ( §unlock == 1 ) SENDEVENT TRAP_DISARMED SELF ""
 ACCEPT
}