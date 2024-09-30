ON INIT {
 SET £key "KEY_BASE_0031"
 SET £type "door_fullmetal"
 SET §lockpickability 80
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

ON LOAD {
 USE_MESH "Door_Human_Palace_metal\Door_Human_Palace_metal.teo"
 ACCEPT
}

ON CUSTOM {
  IF (^$PARAM1 == "UNLOCK") {
    SET §unlock 1
    ACCEPT
  }
  IF (^$PARAM1 == "LOCK") {
    SET §unlock 0
    ACCEPT
  }
 ACCEPT
}