ON INIT {
 SET §spoken 0			// Used to know if door has already spoken
 SET_SPEAK_PITCH 0.9
 SET §unlock 0
 SET £key "key_base_0044"
 SET §lockpickability 50
 ACCEPT
}

ON INITEND {
 SET £friend "kingdom"
 ACCEPT
}

ON CUSTOM {
  IF (^$PARAM1 == "UNLOCK") {
    SET §unlock 1
    ACCEPT
  }
 ACCEPT
}

ON RELOAD {
  IF (§broken == 1) ACCEPT
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §breakable 0
    SET §lockpickability 99
    SET §unlock 0
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §breakable 1
    SET §lockpickability 60
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