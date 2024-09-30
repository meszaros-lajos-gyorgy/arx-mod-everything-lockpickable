ON INIT {
 SET §unlock 0
 SET §lockpickability 100
 SETNAME [description_chest]
 SET_MATERIAL WOOD
 INVENTORY CREATE
 LOADANIM ACTION1 "cupboard_close"
 LOADANIM ACTION2 "cupboard_open"
 ACCEPT
}

ON INVENTORY2_OPEN {
  IF (§open == 0) {
    IF (§unlock == 1) {
      PLAY "chestopen1"
      PLAYANIM ACTION2
      SET §open 1
      ACCEPT
    }
   SPEAK -p [player_locked] nop
   PLAY "door_locked"
   REFUSE
  }
 ACCEPT
}


ON INVENTORY2_CLOSE {
 SET §open 0
 PLAY "cupboard_close"
 PLAYANIM ACTION1
 ACCEPT
}