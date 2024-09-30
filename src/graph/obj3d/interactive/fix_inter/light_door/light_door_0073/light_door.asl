ON INIT {
 SET £type "door_fullmetal"
 SET £key "KEY_BASE_0008"
 SET §status 0 // when = 1 player comes from temple and door is open, Ylside is not here anymore.
 SET §lockpickability 99
 ACCEPT
}

ON LOAD {
 USE_MESH "metal_door\metal_door.teo"
 ACCEPT
}

ON RELOAD {
 SENDEVENT CLOSE SELF ""
 ACCEPT
}

ON ACTION {
 IF (§status == 1) ACCEPT
 IF (§unlock == 1) ACCEPT
 SENDEVENT CUSTOM HUMAN_BASE_0069 "KNOCK"
 ACCEPT
}

ON CUSTOM {
  IF (^$param1 == "OPEN") {
    SET §unlock 1
    SET §status 1
    SENDEVENT OPEN SELF ""
    ACCEPT 
  }
 ACCEPT
}