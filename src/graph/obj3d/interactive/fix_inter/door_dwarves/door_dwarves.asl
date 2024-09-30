ON INIT {
 SETNAME [description_door]
 SET_SHADOW OFF
 SET_PLAYER_COLLISION ON
 SET §open 0
 SET §broken 0
 SET §unlock 0
 SET £key "NONE"
 SET §lockpickability 99
 SET £doortype "dwarves_door"
 SET £animclose "Door_dwarves_close"
 SET £animopen "Door_dwarves_open"
 ACCEPT
}

ON INITEND {
 IF (£doortype == "light_door") {
  SET §breakable 1
 }
 IF (£doortype == "door_metal_double") {
  SET £animclose "Door_double_close"
  SET £animopen "Door_double_open"
 }
 LOADANIM ACTION1 ~£animclose~
 LOADANIM ACTION2 ~£animopen~
 LOADANIM DIE ~£animbreak~
 ACCEPT
}

ON HIT {
  IF (^SENDER != PLAYER) ACCEPT
  IF (§broken == 1) ACCEPT
  IF (§open == 1) ACCEPT
  IF (§breakable == 0) {
    SPEAK -p [player_wontbreak] nop
    ACCEPT
  }
 FORCEANIM DIE
 COLLISION OFF
 SET_INTERACTIVITY NONE
 SET §broken 1
 SENDEVENT -r DOORBROKEN 200 ""
 TIMERdoor OFF
 SETNAME [description_light_door_broken]
 ACCEPT
}

ON ACTION {
  IF (§open == 0) {
>>OPEN_DOOR
   IF (§unlock == 1) {
    PLAYANIM ACTION2
    SET §open 1
    SET_PLAYER_COLLISION ON
    ACCEPT
   }
   SPEAK -p [player_locked] nop
   ACCEPT
  }
  ELSE {
>>CLOSE_DOOR
   PLAYANIM ACTION1
   SET §open 0
   SET_PLAYER_COLLISION ON
  }
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

ON OPEN {
 IF (§broken == 1) ACCEPT
 IF (§open == 0) {
  IF (§unlock == 1) {
   TIMERclose 1 2 GOTO CLOSE_DOOR
   GOTO OPEN_DOOR
   ACCEPT
  }
  IF (^$PARAM1 == ~£key~) {
   SET §unlock 1
   TIMERclose 1 2 GOTO CLOSE_DOOR
   GOTO OPEN_DOOR
   ACCEPT
  }
  IF (§breakable == 1) {
   HEROSAY -d "BREAKME"
   SENDEVENT DOORLOCKED ^SENDER "BREAKABLE"
   ACCEPT
  }
  HEROSAY -d "NOT BREAKABLE"
  SENDEVENT DOORLOCKED ^SENDER ""
  ACCEPT
 }
 ACCEPT
}

ON CLOSE {
 IF (^$PARAM1 == "lock") SET §unlock 0
 IF (§open == 1) GOTO CLOSE_DOOR 
 ACCEPT
}

>>WARNINGDOOR
SENDEVENT -r WARNINGDOOR 100 ""
ACCEPT