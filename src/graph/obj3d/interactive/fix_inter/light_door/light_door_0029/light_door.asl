ON INIT {
 SET §spoken 0			// Used to konw if door has already spoken
 SET_SPEAK_PITCH 0.9
 SET £key "key_base_0031"
 SET §lockpickability 60
 SET £type "door_city_unbreak"
 ACCEPT
}

ON LOAD {
 USEMESH "door_city\door_city.teo"
 ACCEPT
}

ON INITEND {
 SET £friend "kingdom"
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §unlock 0
    SET §lockpickability 100
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §lockpickability 80
    ACCEPT
  }
 ACCEPT
}

ON CUSTOM {
  IF (^$PARAM1 == "LOCK") {
    SET §unlock 0
    ACCEPT
  }
  IF (^$PARAM1 == "UNLOCK") {
    SET §unlock 1
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
 ACCEPT
}