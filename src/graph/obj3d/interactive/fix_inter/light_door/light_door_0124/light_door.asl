ON INIT {
 SET §unlock 1
 SET £type "door_fullmetal"
 SET £key "key_base_0014"
 ACCEPT
}

ON LOAD {
 USE_MESH "DOOR_FULLMETAL\DOOR_FULLMETAL.TEO"
 ACCEPT
}

ON LOCK {
 SET §unlock 0
 SENDEVENT CLOSE SELF ""
 SET §lockpickability 99
 ACCEPT 
}

ON UNLOCK {
 SET §unlock 1
 ACCEPT 
}