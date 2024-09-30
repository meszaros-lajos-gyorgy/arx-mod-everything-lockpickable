ON INIT {
 SET §lockpickability 100
 SET £key "KEY_CALPALE_0001KEY_CALPALE_0002KEY_CALPALE_0003"
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
    SET §lockpickability 100
    SET §unlock 0
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §lockpickability 100
    ACCEPT
  }
 ACCEPT
}