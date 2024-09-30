ON INIT {
 SET §lockpickability 65
 SET £key "KEY_BASE2_0001KEY_BANK_0001"
 SEt £type "door_fullmetal"
 ACCEPT
}

ON LOAD {
 USE_MESH "Door_Human_Palace_metal\Door_Human_Palace_metal.teo"
 ACCEPT
}

ON GAME_READY {
 SET £key "KEY_BASE2_0001"
 ACCEPT
}

ON RELOAD {
  SENDEVENT CLOSE SELF ""
  IF (#PLAYER_ON_QUEST == 6) {
    SET §lockpickability 100
    SET §unlock 0
    SET £key "NOKEYEVER"
    ACCEPT
  }
  IF (#PLAYER_ON_QUEST == 7) {
    SET §lockpickability 80
    SET £key "KEY_BASE2_0001KEY_BANK_0001"
    ACCEPT
  }
 ACCEPT
}

ON CUSTOM {
 IF (^$PARAM1 == "LOCK") SET §unlock 0
 IF (^$PARAM1 == "UNLOCK") SET §unlock 1
 ACCEPT
}