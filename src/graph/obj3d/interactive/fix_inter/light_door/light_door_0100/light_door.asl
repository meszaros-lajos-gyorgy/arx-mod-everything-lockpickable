ON INIT {
 SET §unlock 1
 SET §lockpickability 40
 SET_SPEAK_PITCH 1.1
 SET §spoken 0			// Used to know if door has already spoken
 ACCEPT
}

ON INITEND {
 SET £friend "kingdom"
 ACCEPT
}

ON RELOAD {
  IF (§broken == 1) ACCEPT
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §breakable 0
    SET §lockpickability 100
    SET §unlock 0
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §breakable 1
    SET §lockpickability 40
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