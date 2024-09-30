ON INIT {
 SET £key "key_base_0029"
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

ON CUSTOM {
 IF (^$PARAM1 == "LOCK") SET §unlock 0
 IF (^$PARAM1 == "UNLOCK") SET §unlock 1  
 ACCEPT
}