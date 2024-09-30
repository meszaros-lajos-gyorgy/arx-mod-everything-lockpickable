ON INIT {
 SET §unlock 1
 SET §lockpickability 70
 SET £key "KEY_BASE_0023KEY_BANK_0001"
 SEt £type "door_fullmetal"
 ACCEPT
}

ON LOAD {
 USE_MESH "Door_Human_Palace_metal\Door_Human_Palace_metal.teo"
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §lockpickability 99
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