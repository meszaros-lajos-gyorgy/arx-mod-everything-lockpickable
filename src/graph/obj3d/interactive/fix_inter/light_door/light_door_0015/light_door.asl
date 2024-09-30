ON INIT {
 SET §unlock 1
 SET £type "door_fullmetal"
 SET £key "key_base_0014"
 SET §alarm 0
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

ON ALARM {
 SENDEVENT ALARM HUMAN_BASE_0108 ""
 SENDEVENT ALARM HUMAN_BASE_0086 ""
 SENDEVENT ALARM HUMAN_BASE_0085 ""
>>ALARM
 IF (§alarm == 8) TIMERgong OFF ACCEPT
 INC §alarm 1
 PLAY ARX_BELL
 TIMERgong 0 1 GOTO ALARM
 ACCEPT
}
ON RELOAD {
 IF (#weapon_enchanted == 1) {
  SET §unlock 1
  SENDEVENT OPEN SELF ""
  ACCEPT
 }
 IF (#weapon_enchanted == 2) SET §unlock 1
 ACCEPT
}
