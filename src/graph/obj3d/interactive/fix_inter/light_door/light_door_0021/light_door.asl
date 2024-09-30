ON INIT {
 SET §knock 0		// returns player has knocked
 SET §spoken 0		// Used to knoxw if door has already spoken	
 SET £type "door_city_unbreak"
 SET £friend "kingdom"
 SET §unlock 0
 SET §lockpickability 100
 SET_SPEAK_PITCH 0.9
 ACCEPT
}

ON LOAD {
 USEMESH "door_city\door_city.teo"
 ACCEPT
}

ON CUSTOM {
 IF (^$PARAM1 == "UNLOCK") SET §unlock 1
 IF (^$PARAM1 == "SHANY_DEAD") SET §unlock 1
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  SET §knock 0
  IF (#look_for_shany == 1) SET §unlock 1
  IF (#PLAYER_ON_QUEST == 6) {
    SET §unlock 0
    SET §lockpickability 100
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    IF (#look_for_shany > 1) ACCEPT
    IF (#statue_destroyed > 0) ACCEPT
    SET §lockpickability 60
    SET §unlock 1
    ACCEPT
  }
 ACCEPT
}

ON ACTION {
  IF (^SPEAKING == 1) ACCEPT
  IF (§unlock == 1) ACCEPT
  IF (#PLAYER_ON_QUEST == 6) {
    IF (§spoken == 1) ACCEPT
    SET §spoken 1
    SPEAK [5000_leave_me_misc] NOP
    ACCEPT
  }
 GOTO warning
 ACCEPT
}

>>warning
 IF (§unlock == 1) ACCEPT
 IF (§knock == 2) GOTO hail
 SPEAK [5000_leave_me_misc] SET §knock 1
 ACCEPT

>>hail
 IF (^SPEAKING == 1) ACCEPT
 SPEAK [human_male_help] SENDEVENT -g £friend PLAYER_ENEMY ""
 ACCEPT