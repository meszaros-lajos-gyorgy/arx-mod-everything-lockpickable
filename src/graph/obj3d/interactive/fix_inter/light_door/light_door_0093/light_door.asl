ON INIT {
 SET §unlock 1
 SET §spoken 0				// Used to know if door has already spoken
 SET £type "door_city_unbreak"
 SET §lockpickability 80
 ACCEPT
}

ON LOAD {
 USE_MESH "Door_church02\Door_church02.teo"
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