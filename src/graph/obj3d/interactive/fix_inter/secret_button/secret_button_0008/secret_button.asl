ON INIT {
 SET §first 0
 SET_SECRET 50
 SET §lockpickability 100
 SET §unlock 0
 SET £key "NOKEY"
 SET £tools "NONE"
 ACCEPT
}

ON LOAD {
 USEMESH "Secret_button_bank_inside\Secret_button_bank_inside.teo"
 ACCEPT
}

ON ACTION {
  IF (§unlock == 0) ACCEPT
  IF (§pushed == 0) {
    IF (§first == 0) {
      ADD_XP 5000
      SET §first 1
    }
    SET §pushed 2
    SENDEVENT OPEN LIGHT_DOOR_0057 ""
    SENDEVENT CUSTOM CHEST_METAL_0068 "ACTIVE"
    SENDEVENT CUSTOM CHEST_METAL_0070 "ACTIVE"
    SENDEVENT CUSTOM GOLD_COIN_0184 "ACTIVE"
    SENDEVENT CUSTOM GOLD_COIN_0185 "ACTIVE"
    PLAYANIM -e ACTION1 SET §pushed 1
    ACCEPT
  }
  IF (§pushed == 1) {
    SET §pushed 2
    SENDEVENT CLOSE LIGHT_DOOR_0057 ""
    SENDEVENT CUSTOM CHEST_METAL_0068 "NOACTIVE"
    SENDEVENT CUSTOM CHEST_METAL_0070 "NOACTIVE"
    SENDEVENT CUSTOM GOLD_COIN_0184 "NOACTIVE"
    SENDEVENT CUSTOM GOLD_COIN_0185 "NOACTIVE"
    PLAYANIM -e ACTION1 SET §pushed 0
    ACCEPT
  }
 ACCEPT
}

ON COMBINE {
  IF (§unlock == 1) ACCEPT
  IF (^$PARAM1 ISCLASS "lockpicks") {
    SET £tools ^$PARAM1
    SPEAK -p [player_picklock_impossible] NOP
    GOTO DAMAGE_TOOLS
    ACCEPT
  }
  IF (^$PARAM1 ISCLASS "key_bank") {
    IF (§unlock == 0) {
      SET §unlock 1
      PLAY "door_unlock"
      ACCEPT
    }
    IF (§unlock == 1)
      SET §unlock 0
      PLAY "door_lock"
      ACCEPT
    }    
  PLAY "door_locked"
  ACCEPT
 }
 ACCEPT
}

>>DAMAGE_TOOLS
 SENDEVENT CUSTOM ~£tools~ "DAMAGE"
 PLAY "door_locked"
 ACCEPT

ON RELOAD {
 SET §pushed 0
 ACCEPT
}