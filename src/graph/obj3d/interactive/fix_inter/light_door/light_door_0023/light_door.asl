ON INIT {
 SET §spoken 0			// Used to now if door has already spoken
 SET §lockpickability 60
 SET £key "KEY_BASE_0032"
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
   SET §lockpickability 99
   ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
   SET §lockpickability 60
   ACCEPT
  }
 ACCEPT
}

ON CUSTOM {

  IF (§broken == 1) ACCEPT

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
    SPEAK [human_female_goaway] NOP
    ACCEPT
  }
 ACCEPT
}