ON INIT {
 SET §spoken 0			// Used to know if door has already spoken

 SET §unlock 1
 SET_SPEAK_PITCH 0.9

 SET £key "key_base_0030"

 SET §lockpickability 80
 SET £type "door_city_unbreak"
 ACCEPT
}

ON LOAD {
 USEMESH "door_city\door_city.teo"
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §unlock 0
    SET §lockpickability 99
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §unlock 1
    SET §lockpickability 80
    ACCEPT
  }
 ACCEPT
}

ON ACTION {
  IF (#PLAYER_ON_QUEST == 6) {
    IF (§spoken == 1) ACCEPT
    SET §spoken 1
    SPEAK [human_male_goaway] NOP
    ACCEPT
  }
  IF (#look_for_shany == 2) {
    WORLD_FADE OUT 1000 0 0 0
    SENDEVENT CUSTOM HUMAN_BASE_0094 "SHOW"
    TIMERbob -m 1 1500 SENDEVENT CINEMATIC CAMERA_0094 ""
    ACCEPT
  }
 ACCEPT
}

ON CUSTOM {
 IF (^$PARAM1 == "LOCK") SET §unlock 0
 IF (^$PARAM1 == "UNLOCK") SET §unlock 1
 ACCEPT
}