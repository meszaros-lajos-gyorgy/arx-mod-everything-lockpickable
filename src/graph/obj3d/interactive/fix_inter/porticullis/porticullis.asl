ON INIT {
 SETGROUP DOOR
 LOADANIM ACTION1 "Porticullis_open"
 LOADANIM ACTION2 "Porticullis_close"
 SETNAME [description_portcullis]
 SET_MATERIAL METAL
 SET_SHADOW OFF
 SET §open 0
 SET §playing_locked 0
 SET §lockpickability 100
 SET §chance 0
 SET £key "portcullis"   //this is used for npcs
 SET £tools "NONE"
 SET £opensfx "porticullis_open"
 SET £closesfx "porticullis_close"
 SET £type "NONE"
 SET §unlock 0
 ACCEPT
}

ON INITEND {
  IF (£type ISCLASS "SECRET") {
   SET_INTERACTIVITY NONE
   SETANGULAR ON
   SETBUMP ON
   SETZMAP ON
   SET_SECRET 50
  }
  IF (£type == "wall_secret") {
    SET_MATERIAL STONE
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_close"
    ACCEPT
  }
  IF (£type == "snake_secret") {
    SET_MATERIAL STONE
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_close"
    LOADANIM ACTION1 "Illusion_SecretWall_open"
    LOADANIM ACTION2 "Illusion_SecretWall_close"
    ACCEPT
  }
  IF (£type == "wall_secret_dissident") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "L3_dissidents_secretdoor_open"
    LOADANIM ACTION2 "L3_dissidents_secretdoor_close"
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_open"
    ACCEPT
  }
  IF (£type == "wall_secret_Fake_kult") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "L3_Fakekult_secretDoor_open"
    LOADANIM ACTION2 "L3_Fakekult_secretDoor_close"
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_open"
    ACCEPT
  }
  IF (£type == "wall_secret_temple") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "L1_Akbaa_Mostsecretdoors_open"
    LOADANIM ACTION2 "L1_Akbaa_Mostsecretdoors_close"
    ACCEPT
  }
  IF (£type == "wall_secret_cryptL18") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "Secret_wall18&19_open"
    LOADANIM ACTION2 "Secret_wall18&19_close"
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_open"
    ACCEPT
  }
  IF (£type == "wall_secret_cryptL21") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "L21_Room11_secretdoor_open"
    LOADANIM ACTION2 "L21_Room11_secretdoor_close"
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_open"
    ACCEPT
  }
  IF (£type == "wall_secret_cryptL22") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "Secret_wall_L6_Crypt03_open"
    LOADANIM ACTION2 "Secret_wall_L6_Crypt03_close"
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_open"
    ACCEPT
  }
  IF (£type == "wall_secret_cryptL23") {
    SET_MATERIAL STONE
    LOADANIM ACTION1 "Door_double_open"
    LOADANIM ACTION2 "Door_double_close"
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_open"
    ACCEPT
  }
  IF (£type == "wall_secret_throne") {
    SET_MATERIAL STONE
    SET £opensfx "secret_wall_open"
    SET £closesfx "secret_wall_close"
    LOADANIM ACTION1 "Door_double_open"
    LOADANIM ACTION2 "Door_double_close"
    ACCEPT
  }
  IF (£type ISCLASS "secret") {
    VIEWBLOCK ON
    HERO_SAY -d "secret viewblock ON"
  }
 ACCEPT
}

ON ACTION {
 IF (§playing_locked == 1) ACCEPT
 SET §playing_locked 1
 TIMERlocked 1 1 SET §playing_locked 0
 PLAY "door_locked"
 ACCEPT
}

ON NPC_OPEN {
 IF (£key ISIN ^$PARAM1) GOTO OPEN
 SENDEVENT DOORLOCKED ^SENDER ""
 ACCEPT
}

ON OPEN {
>>OPEN
 IF (£type ISCLASS "SECRET") {
 SET_SECRET -1
 }
 IF (§open == 3) ACCEPT
 IF (§open == 1) ACCEPT
 SET §open 3
 PLAYANIM -e ACTION1 SET §open 1 
 SET_INTERACTIVITY NONE
 COLLISION OFF
 PLAY ~£opensfx~ 	
// IF (£type ISCLASS "secret") {
//  VIEW_BLOCK OFF
//  HERO_SAY -d "secret viewblock OFF"
// }
 ACCEPT
}

ON NPC_CLOSE {
 IF (£key ISIN ^$PARAM1) GOTO CLOSE
 ACCEPT
}

ON CLOSE {
>>CLOSE
 IF (§open == 0) ACCEPT
 IF (§open == 3) ACCEPT
 SET §open 3
 PLAYANIM -e ACTION2 GOTO SUITE
 PLAY ~£closesfx~
 ACCEPT
>>SUITE
 COLLISION ON
 SET §open 0
	IF ( £type ISCLASS "secret" )
	{
		VIEWBLOCK ON
		HERO_SAY -d "secret viewblock ON"
		ACCEPT
	}
 SET_INTERACTIVITY YES
 ACCEPT
}

ON COMBINE {
  IF (§open == 1) ACCEPT
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
 IF ( §unlock == 1 ) GOTO OPEN
 ACCEPT
}

ON COLLISION_ERROR {
 COLLISION OFF
 SENDEVENT OPEN SELF ""
 ACCEPT
}

ON COLLISION_ERROR_DETAIL {
 HEROSAY -d ^SENDER
 DO_DAMAGE ~^SENDER~ 50
 TIMERtryclose 1 2 SENDEVENT CLOSE SELF ""
ACCEPT
}