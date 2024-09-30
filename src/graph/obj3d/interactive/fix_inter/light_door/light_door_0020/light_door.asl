ON INIT {
 SET §knock 0		//returns player has knocked
 SET §spoken 0		// used to know if door has already spoken
 SET £type "door_city_unbreak"
 SET £friend "kingdom"
 SET §unlock 0
 SET §lockpickability 60
 SET_SPEAK_PITCH 1.1
 ACCEPT
}

ON LOAD {
 USEMESH "door_city\door_city.teo"
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  SET §knock 0
  IF (#PLAYER_ON_QUEST == 6) {
    SET §lockpickability 100
    SET §unlock 0
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §unlock 1
    ACCEPT
  }
 ACCEPT
}
 
ON CUSTOM {
  IF (^$PARAM1 == "SHANY_DEAD") SET §unlock 1
  IF (^$PARAM1 == "OPEN") {
    SET §unlock 1
    SENDEVENT OPEN SELF ""
    ACCEPT
  }
 ACCEPT
}

ON ACTION {
  IF (^SPEAKING == 1) ACCEPT
  IF (#PLAYER_ON_QUEST == 6) {
    IF (§spoken == 1) ACCEPT
    SET §spoken 1
    SPEAK [5000_leave_me_misc] NOP
    ACCEPT
  }
 IF (§unlock == 1) ACCEPT
 GOTO warning
 ACCEPT
}

>>warning
 IF (§unlock == 1) ACCEPT
 IF (§knock == 3) GOTO hail
 SPEAK [5000_leave_me_misc] INC §knock 1
 ACCEPT

>>hail
 IF (^SPEAKING == 1) ACCEPT
 SPEAK [human_male_help] SENDEVENT -g £friend PLAYER_ENEMY ""
 ACCEPT