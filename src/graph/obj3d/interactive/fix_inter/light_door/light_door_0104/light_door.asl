ON INIT {
 SET §spoken 0			// Used to know if door has already spoken
 SET §lockpickability 65
 SET £key "KEY_BASE2_0001"
 SET £type "door_city_unbreak"
 ACCEPT
}

ON LOAD {
 USE_MESH "door_castle\door_castle.teo"
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §lockpickability 100
    SET §unlock 0
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
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